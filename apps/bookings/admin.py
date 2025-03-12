from django.contrib import admin
from .models import *
from .models import Customer  # Import your Customer model

@admin.register(City)
class CityAdmin(admin.ModelAdmin):
    list_display = ('id', 'city_name')  # Use 'id' instead of 'city_id'
    search_fields = ('city_name',)

@admin.register(Theatre)
class TheatreAdmin(admin.ModelAdmin):
    list_display = ('id', 'theatre_name', 'city')
    list_filter = ('city',)

@admin.register(Screen)
class ScreenAdmin(admin.ModelAdmin):
    list_display = ('id', 'screen_name', 'theatre')
    list_filter = ('theatre',)

@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('id', 'event_name', 'event_type', 'duration', 'lang', 'organizer')
    list_filter = ('event_type', 'lang')
    search_fields = ('event_name',)

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ('id', 'customer', 'show', 'seat', 'status', 'booking_date')  # Use 'status' instead of 'stat'
    list_filter = ('status', 'booking_date')  # 'status' should be a field in your model

@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = ('id', 'booking', 'amount_paid', 'payment_method', 'payment_status', 'transaction_date')
    list_filter = ('payment_status',)

@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ('id', 'customer_name', 'email_id', 'phone_no')
    search_fields = ('customer_name', 'email_id')

from django.contrib import admin
from .models import Seat, Tier

@admin.register(Seat)
class SeatAdmin(admin.ModelAdmin):
    list_display = ('seat_number', 'status', 'tier')
    list_filter = ('status', 'tier')
    search_fields = ('seat_number',)

@admin.register(Tier)
class TierAdmin(admin.ModelAdmin):
    list_display = ('tier_name', 'price', 'screen')
    list_filter = ('screen',)
    search_fields = ('tier_name',)
