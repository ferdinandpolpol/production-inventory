"""web URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from . import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index, name='index'),
    path('sales/', views.sales, name='sales'),
    path('supply/', views.supply, name='supply'),
    # path('purchase/', views.reports, name='reports'),
    path('reports/', views.reports, name='reports'),

    # APIs
    path('api/reports/', views.reports_api),
    path('api/sales/', views.sales_api),
    path('api/supply/', views.supply_api),
    path('api/product/<int:product_id>', views.get_product),
    path('api/production/', views.production_api),
    path('api/production/<int:id>', views.production_api),
    path('api/production/totals/', views.production_api_totals),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
