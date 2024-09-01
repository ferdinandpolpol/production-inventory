
from django.http import HttpResponse
from django.shortcuts import render

from .models import Product

def index(request):
    context = { 'products': Product.objects.all()}

    return render(request, 'index.html', context)