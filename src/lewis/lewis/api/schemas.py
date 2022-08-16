from rest_framework import serializers
from phonenumber_field.modelfields import PhoneNumberField

class MetadataSerializer(serializers.Serializer):
    name = serializers.CharField()
    age = serializers.IntegerField()
    phone = serializers.IntegerField()