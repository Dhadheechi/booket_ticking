from django.contrib.auth.models import User
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Customer  # Import the Customer model

def register(request):
    if request.method == 'POST':
        username = request.POST['username'].strip()
        email = request.POST['email'].strip()
        phone_no = request.POST.get('phone_no', '').strip()
        password1 = request.POST['password1']
        password2 = request.POST['password2']

        if User.objects.filter(username=username).exists():
            messages.error(request, "Username already taken. Please choose another one.")
            return redirect('register')

        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already registered. Try logging in.")
            return redirect('register')

        if password1 != password2:
            messages.error(request, "Passwords do not match.")
            return redirect('register')

        # ✅ Create user
        user = User.objects.create_user(username=username, email=email, password=password1)
        user.save()

        # ✅ Auto-create Customer profile
        customer = Customer.objects.create(user=user, customer_name=username, email_id=email, phone_no=phone_no)
        print(f"✅ Customer Profile Created: {customer}")  # Debugging

        messages.success(request, "Registration successful. Please log in.")
        return redirect('login')

    return render(request, 'bookings/register.html')


from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Customer

def user_login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)

            # ✅ Check if Customer profile exists
            if not Customer.objects.filter(user=user).exists():
                messages.error(request, "No customer profile found. Please complete your registration.")
                return redirect('register')  # Redirect to registration page
            
            return redirect('home')  # Redirect to home page after successful login
        else:
            messages.error(request, "Invalid username or password.")
    
    return render(request, 'login.html')
