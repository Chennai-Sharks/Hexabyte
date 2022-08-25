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
from lewis.settings import db

    
@api_view(['GET'])
@csrf_exempt
def live_orders(request,phone):
    # metadata = db.Orders.find({"phone": phone})
    results = db.Orders.aggregate([
        { '$match': { 'producer_id':phone }  },
        # { 
        #     '$lookup':{
        #         "from":"Items",
        #         "localField":"item_id['$oid']",
        #         "foreignField":"_id",
        #         "as": "itemdata"
        #     }
        # },
        { 
            '$lookup':{
                "from":"metadata",
                "localField":"customer_id",
                "foreignField":"phone",
                "as": "customerdata"
            }
        },
        {
            "$project":{
                    # "itemdata.food_waste_title":1,
                    # "itemdata.description":1,
                    # "itemdata.applicable_tags":1,
                    "item_id":1,
                    "subscribed_qty":1,
                    "customerdata.name":1,
                    "customerdata.phone":1,
                    "customerdata.business":1,
                    "customerdata.email":1,
                }
        }   
    ])
    data_cursor = json.loads(json_util.dumps(results))
    print(data_cursor)
    final_result=[]
    for i in data_cursor:
        # print(i)
        newdata={}
        newdata["item_id"]=i["item_id"]
        newdata["subscribed_qty"]=i["subscribed_qty"]
        newdata["name"]=i["customerdata"][0]["name"]
        newdata["phone"]=i["customerdata"][0]["phone"]
        newdata["business"]=i["customerdata"][0]["business"]
        newdata["email"]=i["customerdata"][0]["email"]

        itemdata=db.Items.find_one({'_id':ObjectId(i['item_id']['$oid'])})
        print(itemdata)        
        newdata["food_waste_title"]=itemdata['food_waste_title']
        # newdata["description"]=itemdata['description']
        newdata["applicable_tags"]=itemdata['applicable_tags']
        final_result.append(newdata)
    if results is not None:                           
        # data_cursor = json.loads(json_util.dumps(results))
        return JsonResponse({
            "status": "Success",
            "message": "Fetched search results",
            "data": final_result
        }, status = 200)
    else:
        return JsonResponse({
            "status": "Failure",
            "message": "Couldn't fetch search results",            
        }, status = 400)
