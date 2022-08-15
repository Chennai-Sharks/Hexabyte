from logging import log
from django.http import HttpResponse, JsonResponse
from pymongo import MongoClient, errors
import json
from django.views.decorators.csrf import csrf_exempt

def get_db_handle():    
    client = MongoClient("mongodb+srv://Nikhilesh:Dalesteyn08#@lewis.csy1lc4.mongodb.net/?retryWrites=true&w=majority")    
    return client
    
@csrf_exempt
def data_collection(request):        
    try:
        client = get_db_handle()    
        db = client.Lewis
        data_ = request.body
        my_json = data_.decode('utf8').replace("'", '"')  
        data = json.loads(my_json)
        result=db.metadata.insert_one(data)
        return JsonResponse({
            "status": "Success",
            "message": "Data stored successfully"
        }, status = 200)
    except Exception as e:
        print(e)