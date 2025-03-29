from django.db import models


class City(models.Model):
    city_name = models.CharField(max_length=255)

    def __str__(self):
        return self.city_name


class Theatre(models.Model):
    city = models.ForeignKey(City, on_delete=models.CASCADE)
    theatre_name = models.CharField(max_length=255)
    loc = models.CharField(max_length=255)
    total_screens = models.PositiveIntegerField()

    def __str__(self):
        return self.theatre_name


class Screen(models.Model):
    theatre = models.ForeignKey(
        Theatre, on_delete=models.CASCADE, related_name="screens"
    )
    screen_name = models.CharField(max_length=100)
    total_seats = models.PositiveIntegerField()

    def __str__(self):
        return self.screen_name


class Organizer(models.Model):
    organizer_name = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.organizer_name


class Event(models.Model):
    MOVIE = "movie"
    CONCERT = "concert"
    EVENT_TYPES = [(MOVIE, "Movie"), (CONCERT, "Concert")]
    event_name = models.CharField(max_length=255)
    event_type = models.CharField(max_length=10, choices=EVENT_TYPES)
    duration = models.PositiveIntegerField()
    lang = models.CharField(max_length=50)
    organizer = models.ForeignKey(Organizer, on_delete=models.CASCADE)

    def __str__(self):
        return self.event_name


class Showtime(models.Model):
    event = models.ForeignKey(Event, on_delete=models.CASCADE)
    screen = models.ForeignKey(Screen, on_delete=models.CASCADE)
    show_date = models.DateField()
    slot_time = models.TimeField()
    available_seats = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.event.event_name} - {self.show_date} {self.slot_time}"


class Tier(models.Model):
    PLATINUM = "Platinum"
    GOLD = "Gold"
    SILVER = "Silver"
    TIER_CHOICES = [(PLATINUM, "Platinum"), (GOLD, "Gold"), (SILVER, "Silver")]
    screen = models.ForeignKey(Screen, on_delete=models.CASCADE)
    tier_name = models.CharField(max_length=10, choices=TIER_CHOICES)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"{self.screen.screen_name} - {self.tier_name}"


class Seat(models.Model):
    seat_number = models.CharField(max_length=10, unique=True)
    tier = models.ForeignKey(Tier, on_delete=models.CASCADE, related_name="seats")

    def __str__(self):
        return f"Seat {self.seat_number} - {self.tier.tier_name}"


from django.contrib.auth.models import User


class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=True, blank=True)
    customer_name = models.CharField(max_length=255)
    email_id = models.EmailField(unique=True)
    phone_no = models.CharField(max_length=20, unique=True)

    def __str__(self):
        return self.customer_name


class Booking(models.Model):
    CANCELLED = "cancelled"
    CONFIRMED = "confirmed"
    STATUS_CHOICES = [(CANCELLED, "Cancelled"), (CONFIRMED, "Confirmed")]

    customer = models.ForeignKey(
        Customer, on_delete=models.CASCADE, null=True, blank=True
    )
    show = models.ForeignKey(Showtime, on_delete=models.CASCADE)
    seat = models.ForeignKey(Seat, on_delete=models.CASCADE)
    booking_date = models.DateTimeField()
    status = models.CharField(max_length=10, choices=STATUS_CHOICES)

    def __str__(self):
        return f"{self.customer.customer_name} - {self.show.event.event_name}"


import uuid


class Transaction(models.Model):
    FAILED = "failed"
    SUCCESS = "success"
    PENDING = "pending"
    PAYMENT_STATUS_CHOICES = [
        (FAILED, "Failed"),
        (SUCCESS, "Success"),
        (PENDING, "Pending"),
    ]
    transaction_id = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    booking = models.ForeignKey(Booking, on_delete=models.CASCADE)
    amount_paid = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=50)
    payment_status = models.CharField(max_length=20, choices=PAYMENT_STATUS_CHOICES)
    transaction_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Transaction {self.id} - {self.amount_paid}"


class Cancellation(models.Model):
    PROCESSED = "processed"
    PENDING = "pending"
    REFUND_STATUS_CHOICES = [(PROCESSED, "Processed"), (PENDING, "Pending")]
    booking = models.ForeignKey(Booking, on_delete=models.CASCADE)
    cancel_date = models.DateTimeField(auto_now_add=True)
    refund_status = models.CharField(max_length=10, choices=REFUND_STATUS_CHOICES)

    def __str__(self):
        return f"Cancellation {self.id} - {self.refund_status}"


class Admin(models.Model):
    user = models.OneToOneField(Customer, on_delete=models.CASCADE)
    admin_role = models.CharField(max_length=50)

    def __str__(self):
        return f"Admin: {self.user.customer_name}"


from django.db import models


class Date(models.Model):
    show_date = models.DateField(unique=True)

    def __str__(self):
        return str(self.show_date)


class UniqueSeatBooking(models.Model):
    unique_seat_id = models.CharField(max_length=255, unique=True)
    city_id = models.IntegerField(default=1)
    screen_id = models.IntegerField(default=1)
    event_id = models.IntegerField(default=1)
    show_id = models.IntegerField(db_column="show_id", default=1)
    date = models.CharField(max_length=20, default="2025-03-17")
    seat_id = models.IntegerField(default=1)
    tier_id = models.IntegerField(default=1)

    class Meta:
        db_table = "unique_seat_booking"

    def __str__(self):
        return f"Booking {self.unique_seat_id}"
