from rest_framework import serializers
# from phonenumber_field.modelfields import PhoneNumberField

class MetadataSerializer(serializers.Serializer):
    name = serializers.CharField()
    age = serializers.IntegerField()
    phone = serializers.IntegerField()
    business = serializers.CharField()
    location = serializers.ListField(child = serializers.FloatField(), allow_empty = False,  min_length=2, max_length=2)
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
    total_qty = serializers.IntegerField()
    cost_per_kg = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField(required=False)
    available_qty =  serializers.IntegerField(required=False)

class OrderDataSerializer(serializers.Serializer):
    customer_id  = serializers.CharField()
    item_id = serializers.CharField()
    duration = serializers.IntegerField()
    subscribed_qty = serializers.IntegerField()
    cost_per_kg = serializers.IntegerField()
    date = serializers.DateField(required=False)
