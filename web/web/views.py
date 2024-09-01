
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from django.http import HttpResponse
from django.shortcuts import render
from django.utils import timezone
from django.db.models import F, Sum

from .serializers import ProductSerializer, ProductionListSerializer, ProductionSerializer, RecipeSerializer

from .models import Product, Production

def index(request):
    """ Front page to show everything """
    context = { 'products': Product.objects.all()}

    return render(request, 'index.html', context)


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
            instance = Production.objects.filter(date__range=[from_date, to_date])

        serializer = ProductionListSerializer(instance=instance, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    if request.method == "POST":
        print(request.data["ingredients"])
        serializer = ProductionSerializer(data={**request.data, "date": timezone.now().date()})
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
        
        instance = instance.values('product__name').annotate(totals=Sum('quantity'))
        return Response(instance, status=status.HTTP_200_OK)


    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)