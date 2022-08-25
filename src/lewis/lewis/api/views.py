from bson import ObjectId, json_util
import json
import pandas as pd
# from logging import log
from pprint import pprint
# from textwrap import indent
from django.http import HttpResponse, JsonResponse
from lewis.api.utils import  bytes_to_json # ,get_db_handle,
from lewis.api.schemas import consumerMetadataSerializer , producerMetadataSerializer,  OrderDataSerializer ,UserRatingSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from bson import json_util
from lewis.settings import db
from pymongo import GEO2D
from itertools import combinations
from geopy import distance


@api_view(['POST'])
@csrf_exempt
def product_search(request):
    '''
    calls the respective member function from the class search depending on the search list in the request
    :param request: Search list based on the user's request
    :return: JSON response with search results
    '''
    data_ = request.body
    data = bytes_to_json(data_)
    # search_for = data["search_list"]["type"]  
    # if search_for == "product_search":
        # search_object = search(data["search_list"]["product_id"], data["phone"])
        # search_results = search_object.product_search()                    
    metadata = db.metadata.find_one({"phone": data["phone"]})
    location = metadata["location"]
    print(data)
    if data["tags"] == []:
        data_cursor = db.Items.find({"$and":[
                                        {"location": {"$near": location}},
                                        # {"applicable_tags":{'$in':data["tags"]}},
                                        {
                                            "$or":[
                                                {"food_waste_title":{'$regex':data["query"],"$options":"i"}},
                                                {"description":{'$regex':data["query"],"$options":"i"}}
                                            ]
                                        }
                                    ]})
    else:
        data_cursor = db.Items.find({"$and":[
                                        {"location": {"$near": location}},
                                        {"applicable_tags":{'$in':data["tags"]}},
                                        {
                                            "$or":[
                                                {"food_waste_title":{'$regex':data["query"],"$options":"i"}},
                                                {"description":{'$regex':data["query"],"$options":"i"}}
                                            ]
                                        }
                                    ]})
    if data_cursor is not None:                           
        data_cursor = json.loads(json_util.dumps(data_cursor))
        return JsonResponse({
            "status": "Success",
            "message": "Fetched search results",
            "data": data_cursor
        }, status = 200)
    else:
        return JsonResponse({
            "status": "Failure",
            "message": "Couldn't fetch search results",            
        }, status = 400)

    
@api_view(['GET'])
@csrf_exempt
def nearest(request, id):
    import pdb
    pdb.set_trace()
    metadata = db.metadata.find_one({"phone": id})    
    location = metadata["location"]
    data_cursor = db.Items.find(
                                {"location": {"$near": location}}                                            
                            )    
    if data_cursor is not None:                                   
        data_cursor = json.loads(json_util.dumps(data_cursor[:10]))
        for data in data_cursor:
            coords_1 = location
            coords_2 = data["location"]

            data["distance"] = distance.geodesic(coords_1, coords_2).km 
        return JsonResponse({
            "status": "Success",
            "message": "Fetched search results",
            "data": data_cursor
        }, status = 200)
    else:
        return JsonResponse({
            "status": "Failure",
            "message": "Couldn't fetch search results",            
        }, status = 400)
    
@api_view(['GET'])
@csrf_exempt
def combo_buy(request):
    '''
    Get the tags from the metadata and search for the related products to that tag and compute the distance 
    and cost for all the permutations combinations. 
    :param request: User ID and metadata
    :return: A success or failure JSON Response
    '''
    data_ = request.body
    data = bytes_to_json(data_)
    tags = data["tags"]
    for tag in tags:
        pass                    
            
@api_view(['POST'])
@csrf_exempt
def data_collection(request):   
    '''
    Collect the User data. If the user already exists, then don't store the data | instead return the ID
    :param request: The user metadata
    :return: A success or a failure JSON Response
    '''
    
    data_ = request.body
    data = bytes_to_json(data_)
    phone = data['phone'] 
    is_phone_exist = db.metadata.find_one({"phone": phone})        
    if is_phone_exist is None:
        try:    
            if data["role"] == "consumer":
                serializer = consumerMetadataSerializer(data = data)                            
                if serializer.is_valid():                                                                              
                    location = data["location"]["coordinates"]  
                    result = db.metadata.insert_one(data)
                    #print(result)
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
                serializer = producerMetadataSerializer(data = data)
        except Exception as e:
            print(e) 
            return JsonResponse({
                "status": "Failure",
                "message": "Something went wrong in data collection"                    
            }, status = 400)           
            
    else:
        return JsonResponse({
            "status": "Redundant",
            "message": "User already exists"
        }, status = 422)
           

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

@api_view(['GET'])
@csrf_exempt
def producer_manage_orders(request):
    data_ = request.body
    data = bytes_to_json(data_)
    phone = data['phone'] 
    item_data_cursor = db.Orders.find({"producer_id": phone})  
    if item_data_cursor is not None:                           
        item_data = json.loads(json_util.dumps(item_data_cursor))


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
        print(resul)
        final_result = db.Items.find({'_id':{'$in':resul}})
        result_arr=[]
        for i in final_result:
            # result_arr.append(i)
            print(i)
        return JsonResponse({
                    "status": "Success",
                    "message": "Data stored successfully",
                    # "data":json.loads(json_util.dumps(final_result))
                }, status = 200)
        # return HttpResponse(result_arr)
    # except Exception as e:
    #     print(e)
