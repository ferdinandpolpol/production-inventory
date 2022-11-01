
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from django.http import HttpResponse
from django.shortcuts import render

from .serializers import ProductSerializer, RecipeSerializer

from .models import Product

def index(request):
    """ Front page to show everything """
    context = { 'products': Product.objects.all()}

    return render(request, 'index.html', context)


@api_view(['GET'])
def get_product(request, product_id):
    if request.method == "GET":
        product = Product.objects.get(id=product_id)
        serializer = ProductSerializer(instance=product)
        recipe_serializer = RecipeSerializer(product.get_ingredients(), many=True)
        return Response({**serializer.data, "recipe": recipe_serializer.data}, status=status.HTTP_200_OK)

    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)