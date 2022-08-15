from pymongo import MongoClient

def get_db_handle():
    client = MongoClient("mongodb+srv://Nikhilesh:Dalesteyn08#@lewis.csy1lc4.mongodb.net/?retryWrites=true&w=majority")
    #db = client.test
    return client

def get_collection_handle(db_handle, collection_name):
    return db_handle[collection_name]