import json
from logging import log
from textwrap import indent
from django.http import HttpResponse, JsonResponse
from lewis.api.utils import  bytes_to_json # ,get_db_handle,
from lewis.api.schemas import MetadataSerializer , ItemDataSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from bson import json_util
from lewis.settings import db

class search:
    def __init__(self, product_id):
        self.product_id = product_id
    
    def product_search(self):
        search_tags = []
        search_tags.append(self.product_id)
        data_cursor = db.Items.find({"tags" : search_tags})
        if data_cursor is not None:                           
            return json.loads(json_util.dumps(data_cursor))

@api_view(['GET'])
@csrf_exempt
def search_api(request):
    '''
    calls the respective member function from the class search depending on the search list in the request
    :param request: Search list based on the user's request
    :return: JSON response with search results
    '''
    data_ = request.body
    data = bytes_to_json(data_)
    search_for = data["search_list"]["type"]  
    if search_for == "product_search":
        search_object = search(data["search_list"]["product_id"])
        search_results = search_object.product_search()                    
        return JsonResponse({
            "status": "Success",
            "message": "Fetched search results",
            "data": search_results,            
        }, status = 200)
    else:
        return JsonResponse({
            "status": "Failure",
            "message": "Cannot perform the requested search"
        }, status = 400)

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
            serializer = MetadataSerializer(data = data)
        

            if serializer.is_valid():
                result = db.metadata.insert_one(data)
                print(result)
                return JsonResponse({
                    "status": "Success",
                    "message": "Data stored successfully"
                }, status = 200)
        except Exception as e:
            print(e)            
            return JsonResponse({
                "status": "Failure",
                "message": "Invalid data or format"                    
            }, status = 400)
    else:
        return JsonResponse({
            "status": "Redundant",
            "message": "User already exists"
        }, status = 422)