from logging import log
from django.http import HttpResponse, JsonResponse
from lewis.api.utils import get_db_handle, bytes_to_json
from lewis.api.schemas import MetadataSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view

@api_view(['POST'])
@csrf_exempt
def data_collection(request):   
    '''
    Collect the User data. If the user already exists, then send don't store the data | instead return the ID
    :param request: The incoming request
    :return: A success or a failure JSON Response
    '''

    try:
        client = get_db_handle()    
        db = client.Lewis
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