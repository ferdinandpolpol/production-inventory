
from django.db import models
from django.db.models import F, Sum
from django.db.models.signals import pre_save
from django.dispatch import receiver


# ProductionIngredients.objects.filter(production__in=[12,13]).values('ingredient__name').annotate(Sum('quantity'))

class CustomerType(models.Model):
    name = models.CharField(max_length=255)

    def __str__(self) -> str:
        return self.name


class Customer(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField(null=True, blank=True)
    contact = models.CharField(max_length=20, null=True, blank=True)
    customer_type = models.ForeignKey(
        CustomerType, on_delete=models.SET_NULL, null=True)

    def __str__(self) -> str:
        return self.name


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
    supplied_at = models.DateField()

    def get_current_sum(self, id=None):
        return Supply.objects.values('item').annotate(item__sum=Sum('quantity'))

    def __str__(self) -> str:
        return f"Supplied {self.quantity} x {self.item.name} at { self.supplied_at }"


class Ingredient(models.Model):
    recipe = models.ForeignKey(
        "Recipe", related_name="ingredients", on_delete=models.CASCADE)
    ingredient = models.ForeignKey(
        SupplyItem, on_delete=models.SET_NULL, null=True)
    quantity = models.FloatField(help_text="Quantity of the ingredient used")

    # The point of these data is that we multiply a normal ingredient
    # based on the quantity of the main ingredient for production ingredients
    main_ingredient = models.BooleanField(default=False)
    multiplied_by_main_ingredient = models.BooleanField(default=True)
    multiplied_by_production = models.BooleanField(default=False)

    def __str__(self) -> str:
        return f"{ self.recipe.name } - {self.ingredient.name}"


class Recipe(models.Model):
    name = models.CharField(max_length=255)
    quantity_produced = models.FloatField(
        help_text="How many this recipe will produce for the product")

    def __str__(self) -> str:
        return self.name


class ProductionIngredients(models.Model):
    production = models.ForeignKey(
        'Production', related_name="ingredients", on_delete=models.SET_NULL, null=True)
    ingredient = models.ForeignKey(
        SupplyItem, on_delete=models.SET_NULL, null=True)
    quantity = models.FloatField()


class Production(models.Model):
    """ This also acts as the inventory """
    class Meta:
        # Unique together since we want production info for each product per day only
        unique_together = ("product", "date")

    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    quantity = models.PositiveIntegerField()
    date = models.DateField()

    def __str__(self) -> str:
        return f"{self.product.name} + {self.quantity} + {self.date}"


class Sales(models.Model):
    sales_type = models.CharField(max_length=255)
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    quantity = models.IntegerField()
    freebies = models.IntegerField(null=True, blank=True)
    customer = models.ForeignKey(
        Customer, on_delete=models.SET_NULL, null=True)
    date = models.DateField()
    actual_sale = models.FloatField(null=True, blank=True)
    projected_sale = models.FloatField()

    def __str__(self) -> str:
        return f"sold {self.product.name} x {self.quantity} to {self.customer.name} at {self.date}"


@receiver(pre_save, sender=Sales)
def generate_projected_sale(sender, instance, **kwargs):
    instance.projected_sale = instance.product.price * instance.quantity
