from djongo import models
from django.contrib.postgres.fields import ArrayField
import uuid

# Create your models here.
class User(models.Model):
    uuid = models.UUIDField(primary_key=True ,default = uuid.uuid4,editable=False)
    name = models.CharField(max_length=200)
    purpose = models.CharField(max_length=200)
    preferences = ArrayField(models.CharField(max_length=200))
    location = models.CharField(max_length=200)
    objects = models.DjongoManager()

class LiveMarket(models.Model):
    uuid = models.UUIDField(primary_key=True ,default = uuid.uuid4,editable=False)
    product_name = models.CharField(max_length=200)
    category = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    weight = models.IntegerField()
    price = models.IntegerField()
    description = models.TextField()
    expiry_date = models.DateField()
    objects = models.DjongoManager()

class UploadLogs(models.Model):
    product_name = models.CharField(max_length=200)
    category = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    weight = models.IntegerField()
    objects = models.DjongoManager()

class OrderHistory(models.Model):
    buyer_id = models.UUIDField(primary_key=True ,default = uuid.uuid4,editable=False)
    seller_id = models.UUIDField(default = uuid.uuid4,editable=False)
    product_name = models.CharField(max_length=200)
    description = models.TextField()
    weight = models.IntegerField()
    contract = models.CharField(max_length=200)
    price = models.IntegerField()
    transaction_date = models.DateField()
    objects = models.DjongoManager()

