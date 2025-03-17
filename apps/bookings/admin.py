from django.contrib import admin
from .models import City, Theatre, Screen, Event, Booking, Transaction, Customer, Seat, Tier

@admin.register(City)
class CityAdmin(admin.ModelAdmin):
    list_display = ('id', 'city_name')
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
    # list_display = ('id', 'customer', 'show', 'seat', 'booking_date')  # Removed 'status'
    # list_filter = ('booking_date',)  # Removed 'status'
    list_display = ('id', 'customer', 'show', 'seat')  # Removed 'status'
    #list_filter = ('booking_date',)  # Removed 'status'


@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = ('id', 'booking', 'amount_paid', 'payment_method', 'payment_status', 'transaction_date')
    list_filter = ('payment_status',)

@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ('id', 'customer_name', 'email_id', 'phone_no')
    search_fields = ('customer_name', 'email_id')

@admin.register(Seat)
class SeatAdmin(admin.ModelAdmin):
    list_display = ('id', 'seat_number', 'tier')
    list_filter = ('tier',)
    search_fields = ('seat_number',)

@admin.register(Tier)
class TierAdmin(admin.ModelAdmin):
    list_display = ('id', 'tier_name', 'price', 'screen')
    list_filter = ('screen',)
    search_fields = ('tier_name',)

from django.contrib import admin
from .models import City, Theatre, Screen, Event, Booking, Transaction, Customer, Seat, Tier, UniqueSeatBooking, Date

@admin.register(Date)  # ✅ Register Date Model
class DateAdmin(admin.ModelAdmin):
    list_display = ('id', 'show_date')
    search_fields = ('show_date',)

from django.contrib import admin
from .models import UniqueSeatBooking

@admin.register(UniqueSeatBooking)
class UniqueSeatBookingAdmin(admin.ModelAdmin):
    list_display = ['unique_seat_id', 'city_id', 'screen_id', 'event_id', 'date', 'show_id', 'tier_id', 'seat_id']
    list_filter = ['city_id', 'screen_id', 'event_id', 'date', 'show_id', 'tier_id']
    search_fields = ['unique_seat_id']
