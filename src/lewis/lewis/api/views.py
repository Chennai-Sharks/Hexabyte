from datetime import  date,timedelta
from logging import log
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