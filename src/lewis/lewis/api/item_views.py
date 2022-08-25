from logging import log
from django.http import HttpResponse, JsonResponse
from lewis.api.utils import  bytes_to_json 
from lewis.api.schemas import MetadataSerializer , ItemDataSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from lewis.settings import db
from bson import ObjectId, json_util
import json

@api_view(['POST'])
@csrf_exempt
def item_addition(request):   
    '''
    Adds a new Item
    :param request: The incoming request
    :return: A success or a failure JSON Response
    ''' 
    try:
        import pdb 
        pdb.set_trace()
        data_ = request.body
        data = bytes_to_json(data_)
        serializer = ItemDataSerializer(data = data)
        if serializer.is_valid():
            user_data = db.metadata.find_one({"phone": data['producer_id']})        
            if user_data is None:
                return JsonResponse({
                    "status": "Failure",
                    "message": "No such User"
                }, status = 400)
            else:
                data['business']=user_data['business']
                data['location']=user_data['location']
                data["subscribed_qty"]=0
                data["balance_qty"]=data["total_qty"]
                result = db.Items.insert_one(data)
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
def item_get(request,id):
    try:
        item_data = db.Items.find_one({"_id":ObjectId(id)})    
        if item_data is None:
            return JsonResponse({
                "status": "Failure",
                "message": "No such item"
            }, status = 400)
        else:
            return HttpResponse(json_util.dumps(item_data))
    except Exception as e:
        print(e)

@api_view(['PUT'])
def item_edit(request,id):
    try:
        data_ = request.body
        data = bytes_to_json(data_)
        update = db.Items.update_one({"_id":ObjectId(id)},{"$set":data})
        return JsonResponse({
                "status": "Success",
                "message": "Data updated successfully"
            }, status = 200)
    except Exception as e:
        print(e)