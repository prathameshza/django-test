from django.contrib import admin
from django.urls import path, include
from home import views
from django.conf.urls.static import static

urlpatterns = [
    path("admin/", admin.site.urls),
    path('', views.index, name='home')
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
