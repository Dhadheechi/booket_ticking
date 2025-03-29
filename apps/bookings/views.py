from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.contrib import messages
from django.urls import reverse
from django.utils import timezone
import uuid

# Models from bookings app
from .models import (
    Event,
    Booking,
    Customer,
    Seat,
    Showtime,
    Theatre,
    Tier,
    UniqueSeatBooking,
    City,
    Screen,
    Date,
    Transaction,
)

# PDF generation
from reportlab.pdfgen import canvas


def event_list(request):
    events = list(Event.objects.values())
    return JsonResponse({"events": events})


def index(request):
    return redirect("register")


@login_required
def book_ticket(request):
    selected_city_id = request.session.get("selected_city_id")
    if not selected_city_id:
        return redirect("select_city")

    theatres = Theatre.objects.filter(city_id=selected_city_id)
    selected_theatre_id = request.GET.get("theatre")
    events = (
        Event.objects.filter(
            showtime__screen__theatre_id=selected_theatre_id
        ).distinct()
        if selected_theatre_id
        else []
    )
    selected_event_id = request.GET.get("event")
    selected_date = request.GET.get("date")
    selected_show_id = request.GET.get("show")
    shows = (
        Showtime.objects.filter(
            screen__theatre_id=selected_theatre_id,
            event_id=selected_event_id,
            show_date=selected_date,
        )
        if selected_theatre_id and selected_event_id and selected_date
        else []
    )

    tiers = (
        Tier.objects.filter(screen_id=selected_theatre_id)
        if selected_theatre_id
        else []
    )

    selected_tier_id = request.GET.get("tier")
    print(f"tier_id={selected_tier_id}")

    seats = Seat.objects.filter(tier_id=selected_tier_id) if selected_tier_id else []

    if selected_show_id and selected_date:
        booked_seat_ids = UniqueSeatBooking.objects.filter(
            show_id=selected_show_id, date=selected_date
        ).values_list("seat_id", flat=True)

        seats = seats.exclude(id__in=booked_seat_ids)

    if request.method == "POST":
        show_id = request.POST.get("show")
        seat_id = request.POST.get("seat")
        tier_id = request.POST.get("tier")
        screen_id = request.POST.get("theatre")
        date = request.POST.get("date")
        theatre_id = request.POST.get("theatre")

        if not (show_id and seat_id and tier_id and date):
            return JsonResponse(
                {"status": "error", "message": "Missing show, seat, tier, or date."},
                status=400,
            )

        print(f"City ID: {selected_city_id}, Type: {type(selected_city_id)}")

        try:
            city = City.objects.get(id=selected_city_id)
            show_instance = Showtime.objects.get(id=show_id)
            event_instance = show_instance.event

            customer = Customer.objects.get(user=request.user)
        except (Showtime.DoesNotExist, Customer.DoesNotExist):
            return JsonResponse(
                {"status": "error", "message": "Invalid show or customer not found."},
                status=400,
            )

        unique_seat_id = f"{selected_city_id}-{theatre_id}-{event_instance.id}-{show_id}-{date}-{tier_id}-{seat_id}"

        if (
            UniqueSeatBooking.objects.using("default")
            .filter(unique_seat_id=unique_seat_id)
            .exists()
        ):
            return JsonResponse(
                {"status": "error", "message": "Seat is already booked."}, status=400
            )

        try:
            customer = Customer.objects.get(user=request.user)
        except Customer.DoesNotExist:
            return JsonResponse(
                {"status": "error", "message": "Customer profile not found."},
                status=400,
            )

        unique_booking = UniqueSeatBooking.objects.create(
            unique_seat_id=unique_seat_id,
            seat_id=int(seat_id),
            tier_id=int(tier_id),
            show_id=int(show_id),
            event_id=event_instance.id,
            screen_id=int(screen_id),
            city_id=int(selected_city_id),
            date=date,
        )
        unique_booking.save()

        booking = Booking.objects.create(
            customer=customer,
            show_id=show_id,
            seat_id=seat_id,
            status="confirmed",
            booking_date=date,
        )

        print(
            f"Redirecting to confirm_booking with unique_seat_id: {unique_booking.unique_seat_id}"
        )
        return redirect(
            reverse(
                "confirm_booking",
                kwargs={"unique_seat_id": unique_booking.unique_seat_id},
            )
        )

    return render(
        request,
        "bookings/book_ticket.html",
        {
            "theatres": theatres,
            "events": events,
            "shows": shows,
            "tiers": tiers,
            "seats": seats,
            "selected_city_id": selected_city_id,
            "selected_theatre_id": selected_theatre_id,
            "selected_event_id": selected_event_id,
            "selected_tier_id": selected_tier_id,
            "selected_date": selected_date,
        },
    )


@login_required
def confirm_booking(request, unique_seat_id):
    unique_booking = get_object_or_404(UniqueSeatBooking, unique_seat_id=unique_seat_id)

    seat = get_object_or_404(Seat, id=unique_booking.seat_id)
    tier = get_object_or_404(Tier, id=unique_booking.tier_id)
    show = get_object_or_404(Showtime, id=unique_booking.show_id)
    event = get_object_or_404(Event, id=unique_booking.event_id)
    screen = show.screen
    theatre = screen.theatre
    city = get_object_or_404(City, id=unique_booking.city_id)

    context = {
        "unique_booking": unique_booking,
        "seat": seat,
        "tier": tier,
        "show": show,
        "event": event,
        "screen": screen,
        "theatre": theatre,
        "city": city,
        "date": unique_booking.date,
    }

    return render(request, "bookings/confirm_booking.html", context)


def register(request):
    if request.method == "POST":
        username = request.POST["username"].strip()
        email = request.POST["email"].strip()
        phone_no = request.POST["phone_no"].strip()
        password1 = request.POST["password1"]
        password2 = request.POST["password2"]

        if not phone_no:
            messages.error(request, "Phone number is required.")
            return redirect("register")

        if User.objects.filter(username=username).exists():
            messages.error(
                request, "Username already taken. Please choose another one."
            )
            return redirect("register")

        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already registered. Try logging in.")
            return redirect("register")

        if password1 != password2:
            messages.error(request, "Passwords do not match.")
            return redirect("register")

        user = User.objects.create_user(
            username=username, email=email, password=password1
        )
        user.save()

        Customer.objects.create(
            user=user, customer_name=username, email_id=email, phone_no=phone_no
        )

        messages.success(request, "Registration successful. Please log in.")
        return redirect("login")

    return render(request, "bookings/register.html")


def user_login(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]

        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect("book_ticket")
        else:
            return render(
                request, "bookings/login.html", {"error": "Invalid credentials!"}
            )

    return render(request, "bookings/login.html")


def user_logout(request):
    logout(request)
    return redirect("login")


@login_required
def after_login_redirect(request):
    print(" Debug Session Data After Login:", request.session.items())

    return redirect("select_city")


def city_selection(request):
    cities = City.objects.all()
    return render(request, "bookings/city_selection.html", {"cities": cities})


def set_city(request):
    if request.method == "POST":
        city_id = request.POST.get("city_id")
        print(f" Selected City ID from POST: {city_id}")

        if not city_id:
            messages.error(request, "No city selected!")
            return redirect("select_city")

        request.session["selected_city_id"] = city_id
        request.session.modified = True

        
        return redirect("book_ticket")

    return redirect("select_city")


def get_events(request):
    theatre_id = request.GET.get("theatre_id")
    events = Event.objects.filter(showtime__screen__theatre_id=theatre_id).distinct()

    data = {"events": [{"id": e.id, "name": e.event_name} for e in events]}
    return JsonResponse(data)


def get_shows(request):
    theatre_id = request.GET.get("theatre_id")
    event_id = request.GET.get("event_id")
    date = request.GET.get("date")

    if theatre_id and event_id and date:
        shows = Showtime.objects.filter(
            screen__theatre_id=theatre_id, event_id=event_id, show_date=date
        )

        show_list = [
            {"id": show.id, "time": show.slot_time.strftime("%I:%M %p")}
            for show in shows
        ]

        return JsonResponse({"shows": show_list})

    return JsonResponse({"shows": []})


def get_seats(request):
    tier_id = request.GET.get("tier_id")
    show_id = request.GET.get("show_id")
    import datetime

    date_str = request.GET.get("date")
    if date_str:
        naive_date = datetime.datetime.strptime(date_str, "%Y-%m-%d")
        aware_date = timezone.make_aware(naive_date)
    else:
        aware_date = timezone.now().date()

    booked_seats = Booking.objects.filter(
        booking_date=aware_date, show=show_id
    ).values_list("seat_id", flat=True)

    available_seats = Seat.objects.filter(tier_id=tier_id).exclude(id__in=booked_seats)

    return JsonResponse(
        {
            "seats": [
                {"id": seat.id, "seat_number": seat.seat_number}
                for seat in available_seats
            ]
        }
    )


def get_tiers(request):
    show_id = request.GET.get("show_id")

    if show_id:

        try:
            show = Showtime.objects.get(id=show_id)
            screen_id = show.screen_id

            tiers = Tier.objects.filter(screen_id=screen_id)

            tier_list = [
                {"id": tier.id, "name": tier.tier_name, "price": float(tier.price)}
                for tier in tiers
            ]

            return JsonResponse({"tiers": tier_list})
        except Showtime.DoesNotExist:
            return JsonResponse({"tiers": []})

    return JsonResponse({"tiers": []})


def download_booking_pdf(request, unique_seat_id):
    unique_booking = get_object_or_404(UniqueSeatBooking, unique_seat_id=unique_seat_id)

    event = get_object_or_404(Event, id=unique_booking.event_id)
    show = get_object_or_404(Showtime, id=unique_booking.show_id)
    city = get_object_or_404(City, id=unique_booking.city_id)
    seat = get_object_or_404(Seat, id=unique_booking.seat_id)
    tier = get_object_or_404(Tier, id=unique_booking.tier_id)
    screen = get_object_or_404(Screen, id=unique_booking.screen_id)
    theatre = get_object_or_404(Theatre, id=screen.theatre_id)

    response = HttpResponse(content_type="application/pdf")
    response["Content-Disposition"] = (
        f'attachment; filename="booking_{unique_seat_id}.pdf"'
    )

    p = canvas.Canvas(response)
    p.setFont("Helvetica-Bold", 16)
    p.drawString(100, 800, "Booking Confirmation")

    p.setFont("Helvetica", 12)
    p.drawString(100, 770, f"Booking ID: {unique_booking.unique_seat_id}")
    p.drawString(100, 750, f"Event Name: {event.event_name}")
    p.drawString(100, 730, f"Date: {unique_booking.date}")
    p.drawString(100, 710, f"Show Time: {show.slot_time}")
    p.drawString(100, 690, f"City: {city.city_name}")
    p.drawString(100, 670, f"Theatre: {theatre.theatre_name}")
    p.drawString(100, 650, f"Seat Number: {seat.seat_number}")
    p.drawString(100, 630, f"Tier: {tier.tier_name}")
    p.drawString(100, 610, f"Price: ${tier.price}")

    p.showPage()
    p.save()
    return response


@login_required
def initiate_payment(request, unique_seat_id):
    print("DEBUG: Initiating payment...")

    try:

        unique_booking = get_object_or_404(
            UniqueSeatBooking, unique_seat_id=unique_seat_id
        )

        booking = get_object_or_404(
            Booking,
            seat_id=unique_booking.seat_id,
            show_id=unique_booking.show_id,
            customer__user=request.user,
        )
        print(f"DEBUG: Booking found: {booking}")

        transaction = Transaction.objects.create(
            booking=booking,
            amount_paid=booking.seat.tier.price,
            payment_method="Online",
            payment_status=Transaction.PENDING,
        )
        print(f"DEBUG: Transaction created: {transaction}")

        return render(
            request,
            "bookings/payment_page.html",
            {
                "transaction": transaction,
                "booking": booking,
                "unique_seat_id": unique_seat_id,
            },
        )

    except UniqueSeatBooking.DoesNotExist:
        print("DEBUG: UniqueSeatBooking not found.")
        messages.error(request, "Booking not found.")
        return redirect("booking_failed")

    except Booking.DoesNotExist:
        print("DEBUG: Booking not found.")
        messages.error(request, "Payment failed. No booking found.")
        return redirect("booking_failed")

    except Exception as e:
        print(f"DEBUG: Error in initiate_payment - {str(e)}")
        messages.error(request, f"An error occurred: {str(e)}")
        return redirect("booking_failed")


def process_payment(request, unique_seat_id):
    print("DEBUG: Processing payment...")

    if request.method == "POST":
        otp_entered = request.POST.get("otp")
        print(f"DEBUG: OTP entered: {otp_entered}")

        if otp_entered != "356473":
            print("DEBUG: Invalid OTP. Rolling back transaction.")
            messages.error(request, "Payment failed. Invalid OTP.")
            return redirect("booking_failed")

        try:

            unique_booking = UniqueSeatBooking.objects.get(
                unique_seat_id=unique_seat_id
            )
            booking = Booking.objects.get(
                seat_id=unique_booking.seat_id, show_id=unique_booking.show_id
            )
            print(f"DEBUG: Found existing Booking: {booking}")

            transaction = Transaction.objects.create(
                booking=booking,
                amount_paid=100.00,
                payment_method="Dummy",
                payment_status=Transaction.SUCCESS,
            )
            print(f"DEBUG: Transaction created: {transaction}")

            booking.status = Booking.CONFIRMED
            booking.save()
            print(f"DEBUG: Booking status updated to confirmed for {booking}")

            print("DEBUG: Redirecting to booking_success with booking_id:", booking.id)
            return redirect(
                reverse("booking_success", kwargs={"booking_id": booking.id})
            )

        except UniqueSeatBooking.DoesNotExist:
            print("DEBUG: UniqueSeatBooking not found.")
            messages.error(request, "Booking not found.")
            return redirect("booking_failed")

        except Booking.DoesNotExist:
            print("DEBUG: Booking not found.")
            messages.error(request, "Payment failed. No booking found.")
            return redirect("booking_failed")

        except Exception as e:
            print(f"DEBUG: Unexpected error - {str(e)}")
            messages.error(request, f"An error occurred: {str(e)}")
            return redirect("booking_failed")


@login_required
def booking_success(request, booking_id):

    try:
        booking = get_object_or_404(
            Booking,
            id=booking_id,
            customer__user=request.user,
            status=Booking.CONFIRMED,
        )
        print(f"DEBUG: Booking confirmed with ID {booking.id}")
    except Exception as e:
        print(f"DEBUG: Error fetching booking - {e}")
        messages.error(request, "Booking not found or unauthorized access.")
        return redirect("book_ticket")

    try:

        booking_date_str = booking.booking_date.strftime("%Y-%m-%d")
        unique_seat_booking = UniqueSeatBooking.objects.get(
            seat_id=booking.seat_id, show_id=booking.show_id, date=booking_date_str
        )
    except UniqueSeatBooking.DoesNotExist:
        print(
            f"DEBUG: No matching UniqueSeatBooking found for Seat ID {booking.seat_id}, Show ID {booking.show_id}, Date {booking_date_str}"
        )
        messages.error(request, "Booking details not found.")
        return redirect("book_ticket")

    try:
        event = Event.objects.get(id=unique_seat_booking.event_id)
        show = Showtime.objects.get(id=unique_seat_booking.show_id)
        seat = Seat.objects.get(id=unique_seat_booking.seat_id)
        tier = Tier.objects.get(id=unique_seat_booking.tier_id)
        city = City.objects.get(id=unique_seat_booking.city_id)
        screen = Screen.objects.get(id=unique_seat_booking.screen_id)
        theatre = screen.theatre
    except Exception as e:
        print(f"DEBUG: Error fetching related objects - {e}")
        messages.error(request, f"Error retrieving booking details: {str(e)}")
        return redirect("book_ticket")

    context = {
        "booking": booking,
        "unique_seat_booking": unique_seat_booking,
        "event": event,
        "show": show,
        "seat": seat,
        "tier": tier,
        "city": city,
        "screen": screen,
        "theatre": theatre,
        "unique_seat_id": unique_seat_booking.unique_seat_id,
    }
    print("DEBUG: Booking success context:", context)
    return render(request, "bookings/booking_success.html", context)


def booking_failed(request):

    return render(
        request,
        "bookings/booking_failed.html",
        {"message": "Your booking could not be completed. Please try again."},
    )
