from django.db import models
from django.contrib.auth.models import User

class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="customer_profile")
    customer_name = models.CharField(max_length=255)
    email_id = models.EmailField(unique=True)
    phone_no = models.CharField(max_length=15, null=True, blank=True)  # Allow null values

    def __str__(self):
        return self.customer_name
