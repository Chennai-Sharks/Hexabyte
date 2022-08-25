from datetime import  date,timedelta
from logging import log
import pandas as pd
from django.http import HttpResponse, JsonResponse
from lewis.api.utils import  bytes_to_json # ,get_db_handle,
from lewis.api.schemas import MetadataSerializer , OrderDataSerializer ,UserRatingSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from lewis.settings import db
from bson import ObjectId, json_util
@api_view(['POST'])
@csrf_exempt
def data_collection(request):   
    '''
    Collect the User data. If the user already exists, then send don't store the data | instead return the ID
    :param request: The incoming request
    :return: A success or a failure JSON Response
    '''

    try:
        # client = get_db_handle()    
        # db = client.Lewis
        data_ = request.body
        data = bytes_to_json(data_)
        phone = data['phone'] 
        is_phone_exist = db.metadata.find_one({"phone": phone})        
        if is_phone_exist is None:
            serializer = MetadataSerializer(data = data)
            if serializer.is_valid():
                result = db.metadata.insert_one(data)
                return JsonResponse({
                    "status": "Success",
                    "message": "Data stored successfully"
                }, status = 200)
            else:
                return JsonResponse({
                    "status": "Failure",
                    "message": "Invalid data or format"
                }, status = 400)
        else:
            return JsonResponse({
                "status": "Redundant",
                "message": "User already exists"
            }, status = 422)
    except Exception as e:
        print(e)

@api_view(['POST'])
@csrf_exempt
def purchase_item(request):
    try:
        data_ = request.body
        data = bytes_to_json(data_)
        serializer = OrderDataSerializer(data = data)
        if serializer.is_valid():
            item_data = db.Items.find_one({"_id":ObjectId(data['item_id']['$oid'])})        

            # order validity checking
            if item_data['balance_qty']<data['subscribed_qty']:
                return JsonResponse({
                        "status": "Failure",
                        "message": "Insufficient quantity"
                    }, status = 400)
            elif item_data['duration']<data['duration']:
                return JsonResponse({
                        "status": "Failure",
                        "message": "Insufficient duration"
                    }, status = 400)
            item_data['balance_qty']-=data['subscribed_qty']
            if data['one_time']==False:
                item_data['subscribed_qty']+=data['subscribed_qty']
                # data['end_date']=date.today() +timedelta(days=data['duration'])
            # else:
                # data['end_date']=date.today() +timedelta(days=1)
            item_result = db.Items.save(item_data)
            
            order_result = db.Orders.insert_one(data)
            

            return JsonResponse({
                "status": "Success",
                "message": "Data stored successfully"
            }, status = 200)
        else:
            return JsonResponse({
                "status": "Failure",
                "message": "Invalid data or format"
            }, status = 400)
    except Exception as e:
        print(e)    

@api_view(['POST'])
@csrf_exempt
def item_rating(request):
    try:
        data_ = request.body
        data = bytes_to_json(data_)
        serializer = UserRatingSerializer(data = data)
        if serializer.is_valid():
            results = db.Ratings.insert_one(data)
            return JsonResponse({
                "status": "Success",
                "message": "Data stored successfully"
            }, status = 200)
        else:
                return JsonResponse({
                    "status": "Failure",
                    "message": "Invalid data or format"
                }, status = 400)
    except Exception as e:
        print(e)    

def recommendation(input,corrMatrix):
    '''
    input = Must be a List of Tuples
    '''
    def get_similar(prod_name,rating):
        similar_ratings = corrMatrix[prod_name]*(rating-5)
        similar_ratings = similar_ratings.sort_values(ascending=False)    
        return similar_ratings

    def rec_algo(consumer):
        similar_products = pd.DataFrame()
        for prod_id,rating in consumer:
          similar_products = similar_products.append(get_similar(prod_id,rating),ignore_index = True)
        return similar_products

    consumer1 = rec_algo(input) #Call the Rec_algo fn
    ans = consumer1.sum().sort_values(ascending=False)
    #print(ans) #Descending order of Best Recommended Products
    suggested_products=[]
    not_suggested_products=[]
    for i in range(ans.size):
      if ans[i]>2.5:
        suggested_products.append(ans.index[i])
      else:
        not_suggested_products.append(ans.index[i])
    print(suggested_products,'\n',not_suggested_products) #Prints the User's Recommended Product_ids and NonRecommended Product_ids(worst case when there are no recommended products)
    return suggested_products


@api_view(['GET'])
@csrf_exempt
def recomm(request,phone):
    # try:
        data = db.Ratings.find({})
        df = pd.DataFrame.from_records(data)
        df['item'] = df['item_id'].map(lambda item: item['$oid'])
        dataset = df[['user_id','item','rating']].pivot(index='user_id' ,columns='item',values='rating')
        corrMatrix = dataset.corr(method='pearson')
        data = db.Ratings.find({'user_id':phone}).sort('_id',-1) 
        input=[]
        for i in data[:2]:
            inp=[]
            inp.append(i['item_id']['$oid'])
            inp.append(i['rating'])
            input.append(inp)
        results = recommendation(input,corrMatrix)
        resul=[]
        for oid in results:
            resul.append(ObjectId(oid))
        final_result = db.Items.find({'_id':{'$in':resul}})
        print(type(final_result))
        return HttpResponse(final_result)
    # except Exception as e:
    #     print(e)
