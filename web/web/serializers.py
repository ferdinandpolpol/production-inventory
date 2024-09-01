

from rest_framework import serializers


from .models import Product, Recipe, SupplyItem

class SupplyItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupplyItem
        fields = ("__all__")

class RecipeSerializer(serializers.ModelSerializer):
    ingredient = SupplyItemSerializer(read_only=True)

    class Meta:
        model = Recipe
        fields = ("__all__")

class ProductSerializer(serializers.ModelSerializer):
    recipe = RecipeSerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = ("name", "price", "code", "recipe")
        
        