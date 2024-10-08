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
from django.urls import include
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from rest_framework import routers, permissions

from drf_yasg.views import get_schema_view
from drf_yasg import openapi


from . import views, viewsets

router = routers.DefaultRouter()
router.register(r'production', viewsets.ProductionViewSet)
router.register(r'purchase', viewsets.PurchaseViewSet)
router.register(r'sales', viewsets.SalesViewSet)
router.register(r'supply', viewsets.SupplyViewSet)
router.register(r'product', viewsets.ProductViewSet)
router.register(r'customer', viewsets.CustomerViewSet)
router.register(r'supply_item', viewsets.SupplyItemViewset)
router.register(r'supplier', viewsets.SupplierViewset)

schema_view = get_schema_view(
   openapi.Info(
      title="Snippets API",
      default_version='v1',
      description="Test description",
      terms_of_service="https://www.google.com/policies/terms/",
      contact=openapi.Contact(email="contact@snippets.local"),
      license=openapi.License(name="BSD License"),
   ),
   public=True,
   permission_classes=(permissions.AllowAny,),
)
urlpatterns = [
    path('admin/', admin.site.urls),

    # DRF API
    path('api/', include(router.urls)),
    path('api-auth/', include('rest_framework.urls')),

    # JWT Auth
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    # Other APIs
    path('api/reports/', views.reports_api),
    path('reports/', views.reports),

    # Swagger
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
