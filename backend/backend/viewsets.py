from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from rest_framework.viewsets import ModelViewSet, GenericViewSet
from rest_framework.mixins import ListModelMixin


from django.utils import timezone
from django.db.models import Sum


from .serializers import (
    ProductionListSerializer,
    ProductionSerializer,
    PurchaseSerializer,
    SalesSerializer,
    SupplySerializer,
    ProductSerializer,
    CustomerSerializer
)

from .models import (
    Production,
    Purchase,
    Sales,
    Supply,
    Product,
    Customer
)


class ProductionViewSet(ListModelMixin, GenericViewSet):
    queryset = Production.objects.order_by('-date')
    serializer_class = ProductionSerializer

    def list(self, request):
        serializer = ProductionListSerializer(instance=self.get_queryset(), many=True)

        pagination = self.paginate_queryset(serializer.data)
        if pagination is not None:
            return self.get_paginated_response(pagination)

        return Response(serializer.data, status=status.HTTP_200_OK)
        
    
    def get(self, request, id):
        instance = Production.objects.get(id=id)
        serializer = ProductionSerializer(instance=instance)

        return Response(serializer.data, status=status)


    def create(self, request, *args, **kwargs):
        kwargs = {"date": timezone.now().date()}

        if request.data.get("date"):
            kwargs.pop("date")

        serializer = ProductionSerializer(data={**request.data, **kwargs})
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=False, methods=["GET"])
    def totals(self, request):
        from_date = request.query_params["from"]
        to_date = request.query_params["to"]
        instance = Production.objects.filter(date__range=[from_date, to_date])

        instance = instance.values("product__name").annotate(totals=Sum("quantity"))
        return Response(instance, status=status.HTTP_200_OK)


class SalesViewSet(ListModelMixin, GenericViewSet):
    queryset = Sales.objects.all()
    serializer_class = SalesSerializer

    def create(self, request, *args, **kwargs):
        serializer = SalesSerializer(data=request.data, many=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

class SupplyViewSet(ListModelMixin, GenericViewSet):
    queryset = Supply.objects.all()
    serializer_class = SupplySerializer

    def create(self, request, *args, **kwargs):
        serializer = SupplySerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)


class PurchaseViewSet(ListModelMixin, GenericViewSet):
    queryset = Purchase.objects.all()
    serializer_class = PurchaseSerializer

    def create(self, request, *args, **kwargs):
        serializer = PurchaseSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)


class ProductViewSet(ListModelMixin, GenericViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def list(self, request):
        serializer = ProductSerializer(instance=self.get_queryset(), many=True)

        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def get(self, request, id):
        instance = self.get_queryset().get(id=id)  
        serializer = ProductSerializer(instance=instance)

        return Response(serializer.data, status=status.HTTP_200_OK)
    
class CustomerViewSet(ListModelMixin, GenericViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer

    def list(self, request):
        data = self.get_queryset().values("id", "name")

        return Response(data, status=status.HTTP_200_OK)

