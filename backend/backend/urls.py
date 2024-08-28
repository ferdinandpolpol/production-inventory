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
from django.contrib.auth import views as auth_views
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)


from . import views, viewsets

urlpatterns = [
    path('admin/', admin.site.urls),
    # path('', views.index, name='index'),
    # path('production/', views.production, name='production'),
    # path('login/', views.login, name='login'),
    # path('logout/', views.logout, name='logout'),
    # path('sales/', views.sales, name='sales'),
    # path('supply/', views.supply, name='supply'),
    # path('purchase/', views.purchase, name='reports'),
    # path('reports/', views.reports, name='reports'),

    # APIs
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/reports/', views.reports_api),
    path('api/purchase/', viewsets.PurchaseViewSet.as_view({'get': 'list', 'post': 'create'})),
    path('api/sales/', viewsets.SalesViewSet.as_view({'get': 'list', 'post': 'create'})),
    path('api/supply/', viewsets.SupplyViewSet.as_view({'get': 'list', 'post': 'create'})),
    path('api/product/<int:product_id>', views.get_product),
    path('api/production/', viewsets.ProductionViewSet.as_view({'get': 'list', 'post': 'create'})),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
