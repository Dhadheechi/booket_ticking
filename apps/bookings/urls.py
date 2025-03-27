from django.urls import path
from . import views
from .views import register, user_login, user_logout, book_ticket  # Import views
from .views import city_selection
from django.contrib.auth import views as auth_views
from .views import after_login_redirect 
from django.urls import path, include
from .views import get_events
from .views import get_shows
from .views import get_seats
from .views import get_tiers
from django.urls import path
from .views import confirm_booking, download_booking_pdf

urlpatterns = [
    path('', views.index, name='home'),  # Add this for homepage
    path('book/', views.book_ticket, name='book_ticket'),
    path("register/", register, name="register"),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path("logout/", user_logout, name="logout"),
    # path("book/", include("apps.bookings.urls")),  # Ensure this is correct
    path('select-city/', city_selection, name='city_selection'),
    path('after-login/', after_login_redirect, name='after_login'),
    path("select-city/", views.city_selection, name="select_city"),
    path("set-city/", views.set_city, name="set_city"),
    path("get-events/", views.get_events, name="get-events"),
    path("get-shows/", views.get_shows, name="get-shows"),
    path("get-seats/", get_seats, name="get-seats"),
    path("get-tiers/", get_tiers, name="get_tiers"),
    path('book/confirm/<str:unique_seat_id>/', views.confirm_booking, name='confirm_booking'),
    path("book/confirm/<path:unique_seat_id>/download/", download_booking_pdf, name="download_booking_pdf"),
    path("book/payment/<path:unique_seat_id>/", views.initiate_payment, name="initiate_payment"),
    path("book/process_payment/<path:unique_seat_id>/", views.process_payment, name="process_payment"),
    # path("book/confirm/<str:unique_seat_id>/", views.process_payment, name="process_payment"),
    path("booking-success/<int:booking_id>/", views.booking_success, name="booking_success"),
    # path("booking-success/<path:unique_seat_id>/", views.booking_success, name="booking_success"),
    path("booking-failed/", views.booking_failed, name="booking_failed"),
]


