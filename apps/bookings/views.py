from django.shortcuts import render
from django.http import JsonResponse
from .models import Event
from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Booking  # Make sure your Booking model exists
from django.contrib.auth.models import User  # Import User model
from django.contrib.auth import authenticate, login  # Import authenticate and login functions
from .models import Customer  # ✅ Correct if Customer is in bookings/models.py
from .models import Customer, Seat, Booking

def event_list(request):
    events = list(Event.objects.values())  # Convert QuerySet to list of dicts
    return JsonResponse({'events': events})


def index(request):
    return redirect("register")  # Redirects to the register page


from django.contrib.auth.decorators import login_required

from .models import Showtime, Seat, Booking, Customer, Theatre


from django.views.decorators.csrf import csrf_exempt

# @login_required  # Ensure only logged-in users can book tickets
# def book_ticket(request):
#     selected_city_id = request.session.get("selected_city_id")
#     if not selected_city_id:
#         return redirect("select_city")

#     theatres = Theatre.objects.filter(city_id=selected_city_id)

#     # Get selected theatre, event, and show
#     selected_theatre_id = request.GET.get("theatre")
#     events = Event.objects.filter(showtime__screen__theatre_id=selected_theatre_id).distinct() if selected_theatre_id else []
#     selected_event_id = request.GET.get("event")
#     shows = Showtime.objects.filter(screen__theatre_id=selected_theatre_id, event_id=selected_event_id) if selected_theatre_id and selected_event_id else []

#     # ✅ Fetch Tiers for the Selected Theatre
#     tiers = Tier.objects.all()  # Fetch all tiers initially

#     # ✅ Fetch Seats for the Selected Tier (Initially Empty, Fetched via AJAX)
#     selected_tier_id = request.GET.get("tier")
#     seats = Seat.objects.all()  # Fetch all seats initially

#     # ✅ Handle Booking Form Submission
#     if request.method == "POST":
#         show_id = request.POST.get("show")
#         seat_id = request.POST.get("seat")

#         if not (show_id and seat_id):
#             return JsonResponse({"status": "error", "message": "Missing show or seat."}, status=400)

#         # Ensure seat is available before booking
#         seat = Seat.objects.filter(id=seat_id, status="available").first()
#         if not seat:
#             return JsonResponse({"status": "error", "message": "Seat is not available."}, status=400)

#                 # ✅ Get the logged-in user's customer profile
#         try:
#             customer = Customer.objects.get(user=request.user)  # Assuming `Customer` has a `user` FK
#         except Customer.DoesNotExist:
#             return JsonResponse({"status": "error", "message": "Customer profile not found."}, status=400)


#         # ✅ Create a booking
#         booking = Booking.objects.create(
#             customer=customer,
#             show_id=show_id,
#             seat_id=seat_id,
#             status="confirmed"
#         )

#         # Mark seat as booked
#         seat.status = "booked"
#         seat.save()

#         return JsonResponse({"status": "success", "booking_id": booking.id})

#     return render(request, "bookings/book_ticket.html", {
#         "theatres": theatres,
#         "events": events,
#         "shows": shows,
#         "tiers": tiers,
#         "seats": seats,
#         "selected_city_id": selected_city_id,
#         "selected_theatre_id": selected_theatre_id,
#         "selected_event_id": selected_event_id,
#         "selected_tier_id": selected_tier_id
#     })
from apps.bookings.models import Date  # ✅ Import Date model
from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from .models import Showtime, Seat, Tier, Customer, Booking, UniqueSeatBooking, City, Theatre, Event
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.utils import timezone
from django.urls import reverse


@login_required
def book_ticket(request):
    selected_city_id = request.session.get("selected_city_id")
    if not selected_city_id:
        return redirect("select_city")

    theatres = Theatre.objects.filter(city_id=selected_city_id)
    selected_theatre_id = request.GET.get("theatre")
    events = Event.objects.filter(showtime__screen__theatre_id=selected_theatre_id).distinct() if selected_theatre_id else []
    selected_event_id = request.GET.get("event")
    selected_date = request.GET.get("date")
    # booking_date, created = Date.objects.get_or_create(date=date)
    shows = Showtime.objects.filter(screen__theatre_id=selected_theatre_id, event_id=selected_event_id, date=selected_date) if selected_theatre_id and selected_event_id and selected_date else []

    
    tiers = Tier.objects.all()
    selected_tier_id = request.GET.get("tier")
    seats = Seat.objects.all()


    if request.method == "POST":
        show_id = request.POST.get("show")
        seat_id = request.POST.get("seat")
        tier_id = request.POST.get("tier")
        screen_id = request.POST.get("theatre")  # Ensure this is passed
        date = request.POST.get("date")
        theatre_id = request.POST.get("theatre")
        

        
        if not (show_id and seat_id and tier_id and date):
            return JsonResponse({"status": "error", "message": "Missing show, seat, tier, or date."}, status=400)
        
        print(f"City ID: {selected_city_id}, Type: {type(selected_city_id)}")
        
        try:
            city = City.objects.get(id=selected_city_id)
            show_instance = Showtime.objects.get(id=show_id)
            event_instance = show_instance.event  # Ensure event is fetched from the show
            #date_instance, _ = Date.objects.get_or_create(date=date)
            customer = Customer.objects.get(user=request.user)
        except (Showtime.DoesNotExist, Customer.DoesNotExist):
            return JsonResponse({"status": "error", "message": "Invalid show or customer not found."}, status=400)
        
        unique_seat_id = f"{selected_city_id}-{theatre_id}-{event_instance.id}-{show_id}-{date}-{tier_id}-{seat_id}"
        
        if UniqueSeatBooking.objects.using('default').filter(unique_seat_id=unique_seat_id).exists():
            return JsonResponse({"status": "error", "message": "Seat is already booked."}, status=400)
        
        try:
            customer = Customer.objects.get(user=request.user)
        except Customer.DoesNotExist:
            return JsonResponse({"status": "error", "message": "Customer profile not found."}, status=400)
    
        # Create booking with ID values, not objects
        unique_booking = UniqueSeatBooking.objects.create(
            unique_seat_id=unique_seat_id,
            seat_id=int(seat_id),  # Convert to integer
            tier_id=int(tier_id),  # Convert to integer
            show_id=int(show_id),  # Convert to integer
            event_id=event_instance.id,  # Use the ID, not the object
            screen_id=int(screen_id),  # Convert to integer
            city_id=int(selected_city_id),  # Convert to integer
            date=date,  # Date string is fine
        )
        unique_booking.save()

        booking = Booking.objects.create(
            customer=customer,
            show_id=show_id,
            seat_id=seat_id,
            status="confirmed",
            booking_date=date
        )

        print(f"Redirecting to confirm_booking with unique_seat_id: {unique_booking.unique_seat_id}")
        return redirect(reverse("confirm_booking", kwargs={"unique_seat_id": unique_booking.unique_seat_id}))



    return render(request, "bookings/book_ticket.html", {
        "theatres": theatres,
        "events": events,
        "shows": shows,
        "tiers": tiers,
        "seats": seats,
        "selected_city_id": selected_city_id,
        "selected_theatre_id": selected_theatre_id,
        "selected_event_id": selected_event_id,
        "selected_tier_id": selected_tier_id,
        "selected_date": selected_date
    })



from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import UniqueSeatBooking

@login_required
def confirm_booking(request, unique_seat_id):
    unique_booking = get_object_or_404(UniqueSeatBooking, unique_seat_id=unique_seat_id)
    
    # Fetch related objects
    seat = get_object_or_404(Seat, id=unique_booking.seat_id)
    tier = get_object_or_404(Tier, id=unique_booking.tier_id)
    show = get_object_or_404(Showtime, id=unique_booking.show_id)
    event = get_object_or_404(Event, id=unique_booking.event_id)
    screen = show.screen
    theatre = screen.theatre
    city = get_object_or_404(City, id=unique_booking.city_id)
    
    # return redirect(reverse("initiate_payment", kwargs={"booking_id": unique_booking.id}))

    context = {
        "unique_booking": unique_booking,
        "seat": seat,
        "tier": tier,
        "show": show,
        "event": event,
        "screen": screen,
        "theatre": theatre,
        "city": city,
        "date": unique_booking.date
    }
    
    return render(request, "bookings/confirm_booking.html", context)




from django.contrib.auth.models import User
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Customer

def register(request):
    if request.method == 'POST':
        username = request.POST['username'].strip()  # Strip whitespace
        email = request.POST['email'].strip()
        phone_no = request.POST['phone_no'].strip()
        password1 = request.POST['password1']
        password2 = request.POST['password2']

        if not phone_no:
            messages.error(request, "Phone number is required.")
            return redirect('register')

        # ✅ Check if username already exists
        if User.objects.filter(username=username).exists():
            messages.error(request, "Username already taken. Please choose another one.")
            return redirect('register')

        # ✅ Check if email already exists
        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already registered. Try logging in.")
            return redirect('register')

        # ✅ Check if passwords match
        if password1 != password2:
            messages.error(request, "Passwords do not match.")
            return redirect('register')

        # ✅ Create user
        user = User.objects.create_user(username=username, email=email, password=password1)
        user.save()

        # ✅ Auto-create Customer profile
        Customer.objects.create(user=user, customer_name=username, email_id=email, phone_no=phone_no)

        messages.success(request, "Registration successful. Please log in.")
        return redirect('login')

    return render(request, 'bookings/register.html')



from django.contrib.auth import authenticate, login

def user_login(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]

        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect("book_ticket")  # ✅ Redirect to booking page after login
        else:
            return render(request, "bookings/login.html", {"error": "Invalid credentials!"})

    return render(request, "bookings/login.html")


def user_logout(request):
    logout(request)
    return redirect("login")

from .models import City



from django.shortcuts import redirect

@login_required

def after_login_redirect(request):
    print("🔍 Debug Session Data After Login:", request.session.items())  # 🛠 Debugging


    return redirect("select_city")  # 🚨 Redirects if city not set

    # print("✅ City found in session. Redirecting to book_ticket.")
    # return redirect("book_ticket")  # ✅ Proceed if city is set

def city_selection(request):
    cities = City.objects.all()  # Fetch all cities from the database
    return render(request, "bookings/city_selection.html", {"cities": cities})  # Pass data to template

from django.shortcuts import render, redirect
from apps.bookings.models import City, Theatre



def set_city(request):
    if request.method == "POST":
        city_id = request.POST.get("city_id")
        print(f"🔍 Selected City ID from POST: {city_id}")  # ✅ Debugging

        if not city_id:
            messages.error(request, "No city selected!")
            return redirect("select_city")  

        # ✅ Store in session & confirm update
        request.session["selected_city_id"] = city_id
        request.session.modified = True  # ✅ Force session update

        print(f"✅ Session updated: {request.session.get('selected_city_id')}")  # Debugging
        return redirect("book_ticket")

    return redirect("select_city")


from django.http import JsonResponse
from .models import Event

def get_events(request):
    theatre_id = request.GET.get("theatre_id")
    events = Event.objects.filter(showtime__screen__theatre_id=theatre_id).distinct()
    
    data = {"events": [{"id": e.id, "name": e.event_name} for e in events]}
    return JsonResponse(data)

from .models import Showtime

from django.http import JsonResponse
from .models import Showtime  # Make sure it's "Showtime" (as per your model)

def get_shows(request):
    theatre_id = request.GET.get("theatre_id")
    event_id = request.GET.get("event_id")

    if theatre_id and event_id:
        shows = Showtime.objects.filter(screen__theatre_id=theatre_id, event_id=event_id)
        
        show_list = [{
            "id": show.id,
            "time": show.slot_time.strftime("%I:%M %p")  # Adjust field name if needed
        } for show in shows]

        return JsonResponse({"shows": show_list})

    return JsonResponse({"shows": []})

from django.http import JsonResponse
from .models import Seat, Showtime

from django.http import JsonResponse
from .models import Seat, Tier

from django.http import JsonResponse
from .models import Seat, Tier, UniqueSeatBooking

def get_seats(request):
    tier_id = request.GET.get('tier_id')
    show_id = request.GET.get('show_id')  
    import datetime

    date_str = request.GET.get("date")  # Example: "2025-03-16"
    if date_str:
        naive_date = datetime.datetime.strptime(date_str, "%Y-%m-%d")  # Converts string to naive datetime
        aware_date = timezone.make_aware(naive_date)  # Converts to timezone-aware datetime
    else:
        aware_date = timezone.now().date()  # Fallback: use current date

    booked_seats = Booking.objects.filter(booking_date=aware_date, show=show_id).values_list("seat_id", flat=True)


    # Get available seats by excluding booked ones
    available_seats = Seat.objects.filter(tier_id=tier_id).exclude(id__in=booked_seats)
    
    return JsonResponse({
        "seats": [{"id": seat.id, "seat_number": seat.seat_number} for seat in available_seats]
    })




    

def get_tiers(request):
    show_id = request.GET.get("show_id")
    if not show_id:
        return JsonResponse({"error": "Missing show ID"}, status=400)

    try:
        # Get screen linked to the show
        show = Showtime.objects.get(id=show_id)
        screen = show.screen

        # Get tiers linked to this screen
        tiers = Tier.objects.all()  # Fetch all tiers initially

        tier_data = [{"id": tier.id, "name": tier.tier_name, "price": str(tier.price)} for tier in tiers]

        return JsonResponse({"tiers": tier_data})

    except Showtime.DoesNotExist:
        return JsonResponse({"error": "Invalid show ID"}, status=400)
    



# @login_required
# def finalize_booking(request):
#     if request.method == "POST":
#         show_id = request.POST.get("show_id")
#         seat_id = request.POST.get("seat_id")
#         tier_id = request.POST.get("tier_id")
#         screen_id = request.POST.get("screen_id")
#         theatre_id = request.POST.get("theatre_id")
#         city_id = request.POST.get("city_id")

#         if not (show_id and seat_id and tier_id and screen_id and theatre_id and city_id):
#             return JsonResponse({"status": "error", "message": "Missing required fields."}, status=400)

#         # ✅ Generate unique seat identifier
#         unique_seat_id = f"{city_id}-{theatre_id}-{show_id}-{tier_id}-{seat_id}"

#         # ✅ Check if seat is already booked
#         if UniqueSeatBooking.objects.filter(unique_seat_id=unique_seat_id, status="booked").exists():
#             return JsonResponse({"status": "error", "message": "Seat is already booked."}, status=400)

#         # ✅ Get customer profile
#         try:
#             customer = Customer.objects.get(user=request.user)
#         except Customer.DoesNotExist:
#             return JsonResponse({"status": "error", "message": "Customer profile not found."}, status=400)

#         # ✅ Create a unique seat booking entry
#         unique_booking = UniqueSeatBooking.objects.create(
#             unique_seat_id=unique_seat_id,
#             seat_id=seat_id,
#             tier_id=tier_id,
#             showtime_id=show_id,
#             screen_id=screen_id,
#             theatre_id=theatre_id,
#             city_id=city_id,
#             status="booked"
#         )

#         # ✅ Create a booking entry
#         booking = Booking.objects.create(
#             customer=customer,
#             show_id=show_id,
#             seat_id=seat_id,
#             status="confirmed"
#         )

#         return redirect("booking_success", booking_id=booking.id)

#     return redirect("book_ticket")



# @login_required
# def booking_success(request, booking_id):
#     booking = Booking.objects.get(id=booking_id)
#     return render(request, "bookings/booking_success.html", {"booking": booking})

from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from reportlab.pdfgen import canvas
from .models import UniqueSeatBooking, Event, Showtime, City, Seat, Tier, Theatre, Screen

def download_booking_pdf(request, unique_seat_id):
    unique_booking = get_object_or_404(UniqueSeatBooking, unique_seat_id=unique_seat_id)

    # Fetch related objects using stored IDs
    event = get_object_or_404(Event, id=unique_booking.event_id)
    show = get_object_or_404(Showtime, id=unique_booking.show_id)
    city = get_object_or_404(City, id=unique_booking.city_id)
    seat = get_object_or_404(Seat, id=unique_booking.seat_id)
    tier = get_object_or_404(Tier, id=unique_booking.tier_id)
    screen = get_object_or_404(Screen, id=unique_booking.screen_id)
    theatre = get_object_or_404(Theatre, id=screen.theatre_id)  # Fetch theatre using screen

    response = HttpResponse(content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="booking_{unique_seat_id}.pdf"'

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

# from .models import Transaction
# from django.db import transaction
# from django.utils.timezone import now


from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from .models import Booking, UniqueSeatBooking, Transaction
from django.contrib import messages
from django.urls import reverse
import uuid  # To generate unique transaction IDs

from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
import uuid
from .models import Booking, Transaction

from django.urls import reverse

@login_required
def initiate_payment(request, booking_id):
    try:
        # Directly fetch booking using booking_id (no need to split)
        booking = get_object_or_404(Booking, id=booking_id, customer__user=request.user)

        # Create a transaction record with initial pending status
        transaction = Transaction.objects.create(
            booking=booking,
            amount_paid=booking.seat.tier.price,  # Assuming this exists
            payment_method="Online",  # Adjust if necessary
            payment_status=Transaction.PENDING
        )

        return render(request, "bookings/payment_page.html", {
            "transaction": transaction,
            "booking": booking
        })

    except Booking.DoesNotExist:
        messages.error(request, "Booking not found.")
        return redirect('home')




from django.urls import reverse

@login_required
def process_payment(request):
    if request.method == "POST":
        transaction_id = request.POST.get("transaction_id")
        otp_entered = request.POST.get("otp")

        transaction = get_object_or_404(Transaction, transaction_id=transaction_id)

        # ✅ Mock OTP Validation (Assume "123456" is the correct OTP)
        if otp_entered != "000000":
            transaction.payment_status = Transaction.SUCCESS
            transaction.save()

            messages.success(request, "Payment successful! Your booking is confirmed.")
            success_url = reverse("booking_success", kwargs={"booking_id": transaction.booking.id})
            return redirect(success_url)
        else:
            transaction.payment_status = Transaction.FAILED
            transaction.save()

            # 🚨 Rollback: Delete booking and free seat
            transaction.booking.delete()
            UniqueSeatBooking.objects.filter(unique_seat_id=transaction.booking.unique_seat_id).delete()

            messages.error(request, "Payment failed. Please try again.")
            return redirect("booking_failed")

    return redirect("home")
