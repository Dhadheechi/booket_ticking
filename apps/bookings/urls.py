from django.urls import path
from . import views
from .views import register, user_login, user_logout, book_ticket  # Import views

urlpatterns = [
    path('', views.index, name='home'),  # Add this for homepage
    path('book/', views.book_ticket, name='book_ticket'),
    path("register/", register, name="register"),
    path("login/", user_login, name="login"),
    path("logout/", user_logout, name="logout"),
    path("book/", book_ticket, name="book_ticket"),
]
