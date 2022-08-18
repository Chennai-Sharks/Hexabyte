from pymongo import MongoClient
import json

# def get_db_handle():    
#     client = MongoClient("mongodb+srv://Nikhilesh:Dalesteyn08#@lewis.csy1lc4.mongodb.net/?retryWrites=true&w=majority")    
#     return client

def bytes_to_json(data):
    my_json = data.decode('utf8').replace("'", '"')  
    data = json.loads(my_json)
    return data