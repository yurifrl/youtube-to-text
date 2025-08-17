from django.urls import path, re_path
from . import views

urlpatterns = [
    path("api/transcript", views.api_transcript, name="api_transcript"),
    path("transcribe/<uid>/", views.transcribe, name="transcribe"),
    re_path(".*", views.query_view, name="query_view"),
]
