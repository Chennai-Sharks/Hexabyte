from django.shortcuts import render
from bson import json_util
from bson.objectid import ObjectId
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from rest_framework.parsers import JSONParser
from django.http.response import JsonResponse,HttpResponse
import jwt,datetime
from rest_framework.decorators import api_view

# model imports
from apiApp.models import User

# Create your views here.
@csrf_exempt
@api_view(('GET',))
# @renderer_classes((TemplateHTMLRenderer, JSONRenderer))
def loginRoute(request,uuid):
    if request.method == "GET":
        # user_data = JSONParser().parse(request)
        user_data = User.objects.mongo_find_one({"uuid":uuid})
        if not user_data:
            return HttpResponse("User not found")

        payload={
            'uuid':user_data['uuid'],
            'location':user_data['location']
            # 'exp':datetime.datetime.utcnow() + datetime.timedelta(minutes=120),
            # 'iat':datetime.datetime.utcnow()
        }
        token = jwt.encode(payload
        ,'secret',
        algorithm='HS256') 
        response = Response()
        response['auth-token'] = token
        # response.set_cookie(key='jwt',value=token,httponly=True,expires=payload['exp'])
        return response

@csrf_exempt
@api_view(('POST',))
def registerRoute(request):
    user_data = JSONParser().parse(request)
    if User.objects.mongo_find_one({"uuid":user_data['uuid']}) == None:      
        User.objects.mongo_insert_one(user_data)
        # return HttpResponse(json_util.dumps(user_data))
        payload={
            'uuid': user_data['uuid'],
            'location':user_data['location']
            # 'exp':datetime.datetime.utcnow() + datetime.timedelta(minutes=120),
            # 'iat':datetime.datetime.utcnow()
        }
        token = jwt.encode(payload
        ,'secret',
        algorithm='HS256') 
        response = Response()
        response['auth-token'] = token
        return response
        # return JsonResponse("User added!")
    else:
        return JsonResponse("User already exists",safe=False)
