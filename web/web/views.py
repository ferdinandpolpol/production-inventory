from rest_framework.views import APIView
from rest_framework.decorators import api_view, action
from rest_framework.response import Response
from rest_framework import status
from rest_framework.viewsets import ModelViewSet


from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.utils import timezone
from django.db.models import F, Sum
from django.contrib.auth import authenticate, login as _login, logout as _logout
from django.contrib.auth.decorators import login_required


from .serializers import (
    ProductSerializer,
)

from .models import (
    Product,
    Production,
    ProductionIngredients,
    Purchase,
    Sales,
    Customer,
    Supplier,
    Supply,
    SupplyItem,
)


@login_required
def index(request):
    """Front page to show everything"""
    return render(request, "index.html")


def login(request):
    context = {"user": request.user}

    if request.method == "POST":
        print(request.POST.__dict__)
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username=username, password=password)
        if user is not None:
            _login(request, user)
        else:
            return HttpResponse("Invalid login")

    return render(request, "login.html", context)


@login_required
def logout(request):
    context = {"user": request.user}
    if request.method == "POST":
        _logout(request)

    return redirect("login")


@login_required
def production(request):
    context = {"products": Product.objects.all()}

    return render(request, "production.html", context)


@login_required
def sales(request):
    context = {
        "sales": Sales.objects.all(),
        "products": Product.objects.all().order_by("name"),
        "customers": Customer.objects.all().order_by("name"),
    }
    return render(request, "sales.html", context)


@login_required
def supply(request):
    context = {
        "supply_items": SupplyItem.objects.all(),
    }
    return render(request, "supply.html", context)


@login_required
def purchase(request):
    context = {
        "purchase_types": Purchase.PURCHASE_TYPES,
        "suppliers": Supplier.objects.all().order_by("name"),
        "supplies": SupplyItem.objects.all().order_by("name"),
    }
    return render(request, "purchase.html", context)


@login_required
def reports(request):
    return render(request, "reports.html")


@api_view(["GET"])
def get_product(request, product_id):
    if request.method == "GET":
        product = Product.objects.get(id=product_id)
        serializer = ProductSerializer(instance=product)
        return Response({**serializer.data}, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(["GET"])
def reports_api(request):
    if request.method == "GET":
        from_date = request.query_params["from"]
        to_date = request.query_params["to"]

        production_supply_totals = (
            ProductionIngredients.objects.filter(
                production__date__range=[from_date, to_date]
            )
            .values("ingredient__name")
            .annotate(Sum("quantity"))
            .filter(quantity__sum__gt=0)
        )

        per_product_supply_totals = {}
        for product in Product.objects.all():
            per_product_supply_totals[product.name] = (
                ProductionIngredients.objects.filter(
                    production__date__range=[from_date, to_date],
                    production__product=product,
                )
                .values("ingredient__name")
                .annotate(Sum("quantity"))
                .filter(quantity__sum__gt=0)
            )
        supply_inventory_list = Supply.objects.filter(
            supplied_at__range=[from_date, to_date]
        ).values("item__name", "quantity", "supplied_at")
        supply_totals_per_product = list(
            supply_inventory_list.values("item__name")
            .annotate(Sum("quantity"))
            .filter(quantity__sum__gt=0)
        )
        print(supply_totals_per_product)

        productions = Production.objects.filter(date__range=[from_date, to_date])
        sales = Sales.objects.filter(date__range=[from_date, to_date])

        total_production_per_product = (
            productions.values("product__name")
            .annotate(Sum("quantity"))
            .filter(quantity__sum__gt=0)
        )
        total_sales = (
            sales.values("customer__name", "product__name")
            .annotate(Sum("quantity"))
            .filter(quantity__sum__gt=0)
            .order_by("product__name")
        )
        total_sales_per_product = (
            sales.values("product__name")
            .annotate(Sum("quantity"), Sum("projected_sale"))
            .filter(quantity__sum__gt=0)
            .order_by("product__name")
        )
        total_freebies = (
            sales.values("customer__name", "product__name")
            .annotate(Sum("freebies"))
            .filter(freebies__sum__gt=0)
        )
        total_sales_per_product_incl_freebies = (
            sales.values("product__name")
            .annotate(sum_out=Sum(F("quantity") + F("freebies")))
            .filter(sum_out__gt=0)
        )
        total_flour = (
            ProductionIngredients.objects.filter(
                production__in=productions, ingredient__name="Flour Sack"
            )
            .values("production__product__name", "ingredient__name")
            .annotate(Sum("quantity"))
        )

        current_inventory = {
            product["product__name"]: product["quantity__sum"]
            for product in total_production_per_product
        }
        for sales in total_sales_per_product_incl_freebies:
            _product_name = sales["product__name"]
            if _product_name not in current_inventory:
                continue

            total_quantity_of_product = float(current_inventory[_product_name])
            total_sold_of_product = float(sales["sum_out"])

            current_inventory[_product_name] = (
                total_quantity_of_product - total_sold_of_product
            )

        return Response(
            {
                "supply_inventory_list": supply_inventory_list,
                "supply_totals_per_product": supply_totals_per_product,
                "production_supply_totals": production_supply_totals,
                "per_product_supply_totals": per_product_supply_totals,
                "total_production_per_product": total_production_per_product,
                "total_sales": total_sales,
                "total_freebies": total_freebies,
                "current_inventory": current_inventory,
                "total_sales_per_product": total_sales_per_product,
                "total_flour": total_flour,
            },
            status=status.HTTP_200_OK,
        )

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
