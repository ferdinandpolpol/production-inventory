
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from django.http import HttpResponse
from django.shortcuts import render
from django.utils import timezone
from django.db.models import F, Sum

from .serializers import ProductSerializer, ProductionListSerializer, ProductionSerializer, RecipeSerializer, SalesSerializer, SupplySerializer

from .models import Product, Production, ProductionIngredients, Sales, Customer, Supply, SupplyItem


def index(request):
    """ Front page to show everything """
    context = {
        'products': Product.objects.all()
    }

    return render(request, 'index.html', context)


def sales(request):
    context = {
        "sales": Sales.objects.all(),
        'products': Product.objects.all(),
        'customers': Customer.objects.all()
    }
    return render(request, 'sales.html', context)


def supply(request):
    context = {
        "supply_items": SupplyItem.objects.all(),
    }
    return render(request, 'supply.html', context)


def reports(request):
    return render(request, 'reports.html')


@api_view(['GET'])
def get_product(request, product_id):
    if request.method == "GET":
        product = Product.objects.get(id=product_id)
        serializer = ProductSerializer(instance=product)
        return Response({**serializer.data}, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET', 'POST'])
def production_api(request, id=None):
    if request.method == "GET":
        from_date = request.query_params["from"]
        to_date = request.query_params["to"]
        instance = None
        if id:
            instance = Production.objects.get(id=id)
        else:
            instance = Production.objects.filter(
                date__range=[from_date, to_date])

        serializer = ProductionListSerializer(instance=instance, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    if request.method == "POST":
        kwargs = {"date": timezone.now().date()}

        if request.data.get("date"):
            kwargs.pop("date")

        serializer = ProductionSerializer(
            data={**request.data, **kwargs})
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def production_api_totals(request):
    if request.method == "GET":
        from_date = request.query_params["from"]
        to_date = request.query_params["to"]
        instance = Production.objects.filter(date__range=[from_date, to_date])

        instance = instance.values(
            'product__name').annotate(totals=Sum('quantity'))
        return Response(instance, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
def sales_api(request):
    if request.method == "POST":
        serializer = SalesSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
def supply_api(request):
    if request.method == "POST":
        serializer = SupplySerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def reports_api(request):
    if request.method == "GET":
        from_date = request.query_params["from"]
        to_date = request.query_params["to"]
        production_supply_totals = ProductionIngredients.objects. \
            filter(production__date__range=[from_date, to_date]). \
            values('ingredient__name'). \
            annotate(Sum('quantity'))
        per_product_supply_totals = {}
        for product in Product.objects.all():
            per_product_supply_totals[product.name] = ProductionIngredients.objects. \
                filter(production__date__range=[from_date, to_date], production__product=product). \
                values('ingredient__name'). \
                annotate(Sum('quantity'))
        supply_inventory_list = Supply.objects.filter(supplied_at__range=[
                                                      from_date, to_date]).values("item__name", "quantity", "supplied_at").order_by("-supplied_at")

        productions = Production.objects.filter(
            date__range=[from_date, to_date])
        sales = Sales.objects.filter(date__range=[from_date, to_date])

        total_production_per_product = productions.values(
            "product__name").annotate(Sum('quantity'))
        total_sales = sales.values(
            "customer__name", "product__name").annotate(Sum('quantity'))
        total_freebies = sales.values(
            "customer__name", "product__name").annotate(Sum('freebies'))
        total_sales_per_product = sales.values(
            "product__name").annotate(sum_out=Sum(F('quantity') + F('freebies')))

        current_inventory = {
            product["product__name"]: product["quantity__sum"]
            for product in total_production_per_product
        }
        for sales in total_sales_per_product:
            key = sales["product__name"]
            current_inventory[key] = float(
                current_inventory[key]) - float(sales["sum_out"])

        return Response(
            {
                "supply_inventory_list": supply_inventory_list,
                "production_supply_totals": production_supply_totals,
                "per_product_supply_totals": per_product_supply_totals,
                "total_production_per_product": total_production_per_product,
                "total_sales": total_sales,
                "total_freebies": total_freebies,
                "current_inventory": current_inventory
            }, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
