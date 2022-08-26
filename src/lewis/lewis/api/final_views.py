from bson import ObjectId, json_util
import json
# from logging import log
from pprint import pprint
# from textwrap import indent
from django.http import HttpResponse, JsonResponse
from lewis.api.utils import  bytes_to_json # ,get_db_handle,
from lewis.api.schemas import  OrderDataSerializer ,UserRatingSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from lewis.settings import db

@api_view(['GET'])
@csrf_exempt
def producer_orders(request,phone):
    results = db.Orders.find({"producer_id":phone})
    final_result=[]
    if results is not None:                           
        for i in results:
            # print(i)
            newdata={}
            newdata["item_id"]=i["item_id"]
            newdata["subscribed_qty"]=i["subscribed_qty"]
            newdata["cost"]=i["cost"]
            newdata["ship_charge"]=i["ship_charge"]
            newdata["tax"]=i["tax"]
            newdata["status"]=i["status"]
            # newdata["phone"]=i["phone"]
            # newdata["email"]=i["email"]
            userdata=db.metadata.find_one({'phone':i['customer_id']})
            itemdata=db.Items.find_one({'_id':ObjectId(i['item_id']['$oid'])})
            print(itemdata)        
            newdata["food_waste_title"]=itemdata['food_waste_title']
            newdata['customer_name']=userdata['name']
            newdata['customer_phone']=userdata['phone']
            # newdata["business"]=itemdata["business"]
            # newdata["description"]=itemdata['description']
            # newdata["applicable_tags"]=itemdata['applicable_tags']
            final_result.append(newdata)
        data_cursor = json.loads(json_util.dumps(final_result))
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


@csrf_exempt
def customer_live(request,phone):
    results = db.Orders.find({"customer_id":phone,"status":"Pending"})
    final_result=[]
    if results is not None:                           
        for i in results:
            # print(i)
            newdata={}
            newdata["item_id"]=i["item_id"]
            newdata["_id"]=i["_id"]
            newdata["subscribed_qty"]=i["subscribed_qty"]
            newdata["cost"]=i["cost"]
            # newdata["phone"]=i["phone"]
            # newdata["email"]=i["email"]

            itemdata=db.Items.find_one({'_id':ObjectId(i['item_id']['$oid'])})
            print(itemdata)        
            newdata["food_waste_title"]=itemdata['food_waste_title']
            newdata["business"]=itemdata["business"]
            # newdata["description"]=itemdata['description']
            newdata["applicable_tags"]=itemdata['applicable_tags']
            final_result.append(newdata)
        data_cursor = json.loads(json_util.dumps(final_result))
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

@api_view(['PUT'])
def order_complete(request,id):
    # try:
        # data_ = request.body
        # data = bytes_to_json(data_)
        update = db.Orders.update_one({"_id":ObjectId(id)},{"$set":{"status":"Completed"}})
        return JsonResponse({
                "status": "Success",
                "message": "Order updated successfully"
            }, status = 200)
    # except Exception as e:
    #     print(e)
