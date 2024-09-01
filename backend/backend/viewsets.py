from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from rest_framework.viewsets import ModelViewSet


from django.utils import timezone
from django.db.models import Sum


from .serializers import (
    ProductionListSerializer,
    ProductionSerializer,
    PurchaseSerializer,
    SalesSerializer,
    SupplySerializer,
    ProductSerializer
)

from .models import (
    Production,
    Purchase,
    Sales,
    Supply,
    Product,
)


class ProductionViewSet(ModelViewSet):
    queryset = Production.objects.all()
    serializer_class = ProductionSerializer

    def list(self, request, *args, **kwargs):
        from_date = request.query_params.get("from")
        to_date = request.query_params.get("to")
        id = kwargs.get('pk', None)
        instance = None
        if id:
            instance = Production.objects.get(id=id)
        else:
            instance = Production.objects.filter(date__range=[from_date, to_date])

        serializer = ProductionListSerializer(instance=instance, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

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


class SalesViewSet(ModelViewSet):
    queryset = Sales.objects.all()
    serializer_class = SalesSerializer

    def create(self, request, *args, **kwargs):
        serializer = SalesSerializer(data=request.data, many=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

class SupplyViewSet(ModelViewSet):
    queryset = Supply.objects.all()
    serializer_class = SupplySerializer

    def create(self, request, *args, **kwargs):
        serializer = SupplySerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)


class PurchaseViewSet(ModelViewSet):
    queryset = Purchase.objects.all()
    serializer_class = PurchaseSerializer

    def create(self, request, *args, **kwargs):
        serializer = PurchaseSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)


class ProductViewSet(ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def list(self, request):
        serializer = ProductSerializer()
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def get(self, request):
        serializer = ProductSerializer(data=request.data)
        return Response(serializer.data, status=status.HTTP_200_OK)