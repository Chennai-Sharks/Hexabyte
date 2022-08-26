from rest_framework import serializers
    
class MetadataSerializer(serializers.Serializer):
    name = serializers.CharField()
    age = serializers.IntegerField()
    phone = serializers.IntegerField()
    phone = serializers.IntegerField()
    business = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2)
    email = serializers.CharField()
    subscription_threshold_count = serializers.IntegerField(required=False)

class ItemDataSerializer(serializers.Serializer):
    producer_id = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2,required=False)
    business = serializers.CharField(required=False)
    food_waste_title = serializers.CharField()
    applicable_tags = serializers.ListField(child = serializers.CharField())
    duration = serializers.IntegerField()    
    description = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2,required=False)
    total_qty = serializers.IntegerField()
    cost = serializers.FloatField()
    subscribed_qty = serializers.IntegerField(required=False)
    available_qty =  serializers.IntegerField(required=False)
    expiry_date = serializers.CharField()
    is_active = serializers.BooleanField(default=True)

class OrderDataSerializer(serializers.Serializer):
    producer_id = serializers.CharField()
    customer_id  = serializers.CharField()
    item_id = serializers.JSONField()
    duration = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField()
    cost = serializers.FloatField()
    ship_charge = serializers.FloatField()
    tax = serializers.FloatField()
    status = serializers.CharField(required=False)
    one_time = serializers.BooleanField()

class UserRatingSerializer(serializers.Serializer):
    customer_id  = serializers.CharField()
    item_id = serializers.JSONField()
    rating = serializers.IntegerField()
