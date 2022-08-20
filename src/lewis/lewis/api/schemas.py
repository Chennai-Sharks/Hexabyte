from rest_framework import serializers
# from phonenumber_field.modelfields import PhoneNumberField

class LocationSerializer(serializers.Serializer):
    type = serializers.CharField()
    coordinates = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2)
    
class MetadataSerializer(serializers.Serializer):
    name = serializers.CharField()
    age = serializers.IntegerField()
    phone = serializers.IntegerField()
    business = serializers.CharField()
    location = LocationSerializer()
    location = serializers.DictField()
    email = serializers.CharField()
    subscription_threshold_count = serializers.IntegerField(required=False)

class ItemDataSerializer(serializers.Serializer):
    producer_id = serializers.CharField()    
    business = serializers.CharField(required = False)
    title = serializers.CharField()
    tags = serializers.ListField(child = serializers.CharField())
    duration = serializers.IntegerField()    
    description = serializers.CharField()
    total_qty = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField(required=False)
    available_qty =  serializers.IntegerField(required=False)

class OrderDataSerializer(serializers.Serializer):
    customer_id  = serializers.CharField()
    item_id = serializers.CharField()
    duration = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField()
