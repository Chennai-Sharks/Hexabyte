import jwt
from rest_framework.response import Response
from django.http.response import JsonResponse,HttpResponse

exempt_urls =['login','register']

class AuthMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
    def __call__(self, request):
        request.user = self.auth(request)
        return self.get_response(request)
    def auth(self,request):
        path = request.path_info.split('/')
        # print(path)
        # if request.path not in exclusion_list:
        if path[2] not in exempt_urls:
            try:
                # urlstr = request.path
                # user = urlstr.split('/')[1]
                
                token = request.headers['auth-token']
                if not token:
                    return JsonResponse('user not found')
                payload = jwt.decode(token,'secret',algorithms=['HS256'])
                # userObj = TUser.objects.get(username=user)
                # if payload.get('username') == userObj.username:
                #     return True
                # else:
                return payload
                

            except (jwt.ExpiredSignatureError, jwt.DecodeError, jwt.InvalidTokenError) as e:
                error = {'Error_code': "status.HTTP_403_FORBIDDEN",
                                'Error_Message': "Token is Invalid/Expired"}
                # logger.error(e)
                return JsonResponse(error)

            except Exception as e:
                error = {'Error_code': "status.HTTP_403_FORBIDDEN",
                                'Error_Message': "Invalid User"}
                # logger.error(e) 
                return JsonResponse(error)
        else:
            return None