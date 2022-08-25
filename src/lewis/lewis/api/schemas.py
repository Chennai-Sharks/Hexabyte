from rest_framework import serializers
    
class consumerMetadataSerializer(serializers.Serializer):
    name = serializers.CharField()    
    phone = serializers.IntegerField()
    business = serializers.CharField()
    tags = serializers.ListField(child = serializers.CharField())
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2,required=False)
    email = serializers.CharField()        

class producerMetadataSerializer(serializers.Serializer):
    name = serializers.CharField()    
    phone = serializers.IntegerField()
    business = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2,required=False)
    email = serializers.CharField()
    subscription_threshold_count = serializers.IntegerField(required=False)

class ItemDataSerializer(serializers.Serializer):
    producer_id = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2,required=False)
    business = serializers.CharField(required=False)
    title = serializers.CharField()
    tags = serializers.ListField(child = serializers.CharField())
    duration = serializers.IntegerField()    
    description = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2,required=False)
    total_qty = serializers.IntegerField()
    cost_per_kg = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField(required=False)
    available_qty =  serializers.IntegerField(required=False)
    is_active = serializers.BooleanField(default=True)

class OrderDataSerializer(serializers.Serializer):
    producer_id = serializers.CharField()
    customer_id  = serializers.CharField()
    item_id = serializers.JSONField()
    duration = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField()
    cost_per_kg = serializers.IntegerField()
    one_time = serializers.BooleanField()

class UserRatingSerializer(serializers.Serializer):
    customer_id  = serializers.CharField()
    item_id = serializers.JSONField()
    rating = serializers.IntegerField()
