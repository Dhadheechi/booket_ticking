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

@login_required(login_url="login")  # Ensure user is logged in
def book_ticket(request):
    from .models import Showtime 
    customer, created = Customer.objects.get_or_create(user=request.user, defaults={
        'customer_name': request.user.username,
        'email_id': request.user.email
    })  # ✅ Auto-create Customer profile if missing

    if created:
        print(f"✅ New Customer Profile Created: {customer}")

    shows = Showtime.objects.all()
    seats = Seat.objects.filter(status='available')  # ✅ Corrected filter

    if request.method == "POST":
        show_id = request.POST.get("show")
        seat_id = request.POST.get("seat")

        try:
            show = Showtime.objects.get(id=show_id)
            seat = Seat.objects.get(id=seat_id, status='available')
        except (Showtime.DoesNotExist, Seat.DoesNotExist):
            messages.error(request, "Invalid show or seat selection.")
            return redirect("book_ticket")

        # Create booking
        booking = Booking.objects.create(
            customer=customer,
            show=show,
            seat=seat,
            status=Booking.CONFIRMED
        )

        seat.status = 'booked'
        seat.save()

        messages.success(request, "Your ticket has been successfully booked!")
        return redirect("book_ticket")

    return render(request, "bookings/book_ticket.html", {"shows": shows, "seats": seats})



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