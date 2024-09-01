
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.utils import timezone
from django.db.models import F, Sum
from django.contrib.auth import authenticate, login as _login, logout as _logout
from django.contrib.auth.decorators import login_required


from .serializers import ProductSerializer, ProductionListSerializer, ProductionSerializer, PurchaseSerializer, RecipeSerializer, SalesSerializer, SupplySerializer

from .models import Product, Production, ProductionIngredients, Purchase, Sales, Customer, Supplier, Supply, SupplyItem


@login_required
def index(request):
    """ Front page to show everything """
    return render(request, 'index.html')


def login(request):
    context = {
        "user": request.user
    }

    if request.method == "POST":
        print(request.POST.__dict__)
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            _login(request, user)
        else:
            return HttpResponse("Invalid login")

    return render(request, "login.html", context)


@login_required
def logout(request):
    context = {
        "user": request.user
    }
    if request.method == "POST":
        _logout(request)

    return redirect('login')


@login_required
def production(request):
    """ Front page to show everything """
    context = {
        'products': Product.objects.all()
    }

    return render(request, 'production.html', context)


@login_required
def sales(request):
    context = {
        "sales": Sales.objects.all(),
        'products': Product.objects.all().order_by('name'),
        'customers': Customer.objects.all().order_by('name')
    }
    return render(request, 'sales.html', context)


@login_required
def supply(request):
    context = {
        "supply_items": SupplyItem.objects.all(),
    }
    return render(request, 'supply.html', context)


@login_required
def purchase(request):
    context = {
        "purchase_types": Purchase.PURCHASE_TYPES,
        "suppliers": Supplier.objects.all().order_by("name"),
        "supplies": SupplyItem.objects.all().order_by("name")
    }
    return render(request, 'purchase.html', context)


@login_required
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
        serializer = SalesSerializer(data=request.data, many=True)
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


@api_view(['POST'])
def purchase_api(request):
    if request.method == "POST":
        serializer = PurchaseSerializer(data=request.data)
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
            annotate(Sum('quantity')).filter(quantity__sum__gt=0)
        per_product_supply_totals = {}
        for product in Product.objects.all():
            per_product_supply_totals[product.name] = ProductionIngredients.objects. \
                filter(production__date__range=[from_date, to_date], production__product=product). \
                values('ingredient__name'). \
                annotate(Sum('quantity')).filter(quantity__sum__gt=0)
        supply_inventory_list = Supply.objects.filter(supplied_at__range=[
                                                      from_date, to_date]).values("item__name", "quantity", "supplied_at").order_by("-supplied_at")

        productions = Production.objects.filter(
            date__range=[from_date, to_date])
        sales = Sales.objects.filter(date__range=[from_date, to_date])

        total_production_per_product = productions.values(
            "product__name").annotate(Sum('quantity')).filter(quantity__sum__gt=0)
        total_sales = sales.values(
            "customer__name", "product__name").annotate(Sum('quantity')).filter(quantity__sum__gt=0).order_by("product__name")
        total_sales_per_product = sales.values("product__name").annotate(
            Sum('quantity')).filter(quantity__sum__gt=0).order_by("product__name")
        total_freebies = sales.values(
            "customer__name", "product__name").annotate(Sum('freebies')).filter(freebies__sum__gt=0)
        total_sales_per_product_incl_freebies = sales.values(
            "product__name").annotate(sum_out=Sum(F('quantity') + F('freebies'))).filter(sum_out__gt=0)

        current_inventory = {
            product["product__name"]: product["quantity__sum"]
            for product in total_production_per_product
        }
        for sales in total_sales_per_product_incl_freebies:
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
                "total_sales_per_product": total_sales_per_product,
                "total_freebies": total_freebies,
                "current_inventory": current_inventory
            }, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
