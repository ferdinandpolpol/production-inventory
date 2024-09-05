

from wsgiref import validate
from rest_framework import serializers
from django.db.models import F, Sum

from .models import (
    Ingredient, 
    Product, 
    Production, 
    ProductionIngredients, 
    Purchase, 
    Recipe, 
    Sales, 
    Supplier, 
    Supply, 
    SupplyItem, 
    Customer
)


class SupplyItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupplyItem
        fields = ("__all__")


class IngredientSerializer(serializers.ModelSerializer):
    ingredient = SupplyItemSerializer(read_only=True)

    class Meta:
        model = Ingredient
        fields = ("id", "ingredient", "quantity", "main_ingredient", "multiplied_by_main_ingredient", "multiplied_by_production")


class RecipeSerializer(serializers.ModelSerializer):
    ingredients = IngredientSerializer(many=True, read_only=True)

    class Meta:
        model = Recipe
        fields = ("name", "quantity_produced", "ingredients")


class ProductSerializer(serializers.ModelSerializer):
    recipe = RecipeSerializer(read_only=True)

    class Meta:
        model = Product
        fields = ("id", "name", "price", "code", "recipe")


class ProductionIngredientsCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductionIngredients
        fields = ("__all__")


class ProductionIngredientsSerializer(serializers.ModelSerializer):
    ingredient = SupplyItemSerializer(read_only=True)

    class Meta:
        model = ProductionIngredients
        fields = ("__all__")


class ProductionSerializer(serializers.ModelSerializer):
    ingredients = ProductionIngredientsCreateSerializer(many=True)

    class Meta:
        model = Production
        fields = ("__all__")

    def create(self, validated_data):
        ingredients = validated_data.pop("ingredients")
        production = Production.objects.create(**validated_data)
        for ingredient in ingredients:
            ProductionIngredients.objects.create(
                production=production, **ingredient)

        return production


class ProductionListSerializer(ProductionSerializer):
    product_name = serializers.SerializerMethodField()

    class Meta:
        model = Production
        fields = ("id", "product_name", "quantity", "date")

    def get_product_name(self, obj):
        return obj.product.name if obj.product else None


class SalesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sales
        exclude = ("projected_sale",)


class PurchaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Purchase
        fields = ("__all__")
class SupplySerializer(serializers.ModelSerializer):
    # purchase order not required
    purchase_order = PurchaseSerializer(required=False)
    class Meta:
        model = Supply
        fields = ("__all__")


class SupplierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = ("__all__")


class PurchaseSubmitSerializer(serializers.ModelSerializer):
    # allow supplies to be null
    supplies = SupplySerializer(many=True, required=False)

    class Meta:
        model = Purchase
        fields = ("__all__")

    def create(self, validated_data):
        supplies = validated_data.pop("supplies", [])
        purchase = Purchase.objects.create(**validated_data)
        for supply in supplies:
            Supply.objects.create(
                purchase_order=purchase, **supply)

        return purchase

class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ("__all__")    