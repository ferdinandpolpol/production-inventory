
from django.db import models
from django.db.models import F, Sum

class CustomerType(models.Model):
    name = models.CharField(max_length=255)

class Customer(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    contact = models.CharField(max_length=20)
    customer_type = models.ForeignKey(CustomerType, on_delete=models.SET_NULL, null=True)


class Product(models.Model):
    name = models.CharField(max_length=255)
    code = models.CharField(max_length=255)
    # Add non-negative validator
    price = models.FloatField()
    recipe = models.ForeignKey("Recipe", on_delete=models.SET_NULL, null=True)

    def __str__(self) -> str:
        return self.code

    def get_ingredients(self, *args, **kwargs):
        return self.recipe.ingredient_set.all()

class SupplyItem(models.Model):
    name = models.CharField(max_length=255)
    price = models.FloatField()
    unit = models.CharField(max_length=255)

    def __str__(self) -> str:
        return self.name

class Supply(models.Model):
    class Meta:
        verbose_name_plural = 'Supplies'

    item = models.ForeignKey(SupplyItem, on_delete=models.SET_NULL, null=True)
    quantity = models.IntegerField()
    supplied_at = models.DateTimeField()
    
    def get_current_sum(self, id=None):
        return Supply.objects.values('item').annotate(item__sum=Sum('quantity'))

class Ingredient(models.Model):
    recipe = models.ForeignKey("Recipe", on_delete=models.CASCADE)
    ingredient = models.ForeignKey(SupplyItem, on_delete=models.SET_NULL, null=True)
    quantity = models.FloatField(help_text="Quantity of the ingredient used")

class Recipe(models.Model):
    quantity_produced = models.FloatField(help_text="How many this recipe will produce for the product")

class ProductionIngredients(models.Model):
    production = models.ForeignKey('Production', on_delete=models.SET_NULL, null=True)
    ingredient = models.ForeignKey(SupplyItem, on_delete=models.SET_NULL, null=True)
    quantity = models.FloatField()

class Production(models.Model):
    """ This also acts as the inventory """
    class Meta:
        # Unique together since we want production info for each product per day only
        unique_together = ("product", "date")

    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    quantity = models.PositiveIntegerField()
    date = models.DateField()

    def ingredients_used(self, *args, **kwargs):
        return self.product.get_ingredients().annotate(
            ingredients_used=F('quantity') * self.quantity
        ).values()

class Sales(models.Model):
    sales_type = models.CharField(max_length=255)
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    quantity = models.IntegerField()
    customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, null=True)


