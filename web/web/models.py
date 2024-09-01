
from django.db import models
from django.db.models import F, Sum

class CustomerType(models.Model):
    name = models.CharField(max_length=255)

class Customer(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    contact = models.CharField(max_length=20)
    customer_type = models.ManyToManyField(CustomerType, on_delete=models.SET_NULL)


class Product(models.Model):
    name = models.CharField(max_length=255)
    code = models.CharField(max_length=255)
    # Add non-negative validator
    price = models.FloatField()

    def get_ingredients(self, *args, **kwargs):
        return Recipe.objects.filter(product=self)

class SupplyItem(models.Model):
    name = models.CharField(max_length=255)
    price = models.FloatField()
    unit = models.CharField(max_length=255)

class Supply(models.Model):
    item = models.ForeignKey(SupplyItem, on_delete=models.SET_NULL)
    quantity = models.IntegerField()
    supplied_at = models.DateTimeField()
    
    def get_current_sum(self, id=None):
        return Supply.objects.values('item').annotate(item__sum=Sum('quantity'))

class Recipe(models.Model):
    product = models.ForeignKey(Product)
    ingredient = models.ForeignKey(SupplyItem)
    quantity = models.PositiveIntegerField()

class Production(models.Model):
    """ This also acts as the inventory """
    product = models.ForeignKey(Product)
    quantity = models.PositiveIntegerField()

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)

        # Reduce the supply whenever we start a production
        # self.reduce_supply()
        # self.add_to_inventory()

    def ingredients_used(self, *args, **kwargs):
        return self.product.get_ingredients().annotate(
            ingredients_used=F('quantity') * self.quantity
        ).values()

    # def reduce_supply(self, *args, **kwargs):
    #     for ingredient in self.ingredients_used():
    #         ingredient_id = ingredient["id"]
    #         ingredients_used = ingredient["ingredients_used"]
    #         supplies = Supply.objects.filter(item__id=ingredient_id, quantity__gt=0).order_by('-supplied_at')

    #         current_ingredients_used = int(ingredients_used)

    #         # Reduce the number of supplies starting with the earliest
    #         # supply in inventory
    #         for supply in supplies:
    #             if current_ingredients_used > supply.quantity:
    #                 current_ingredients_used -= supply.quantity
    #                 supply.quantity = 0
    #                 supply.save()
    #             else:
    #                 supply.quantity -= current_ingredients_used
    #                 supply.save()
    #                 current_ingredients_used = 0

    #                 # We want to break the loop here since there are no
    #                 # more used ingredients to decrease from the supply
    #                 break

    # def add_to_inventory(self, *args, **kwargs):
    #     Inventory.objects.create(product=self.product, qu)


class Sales(models.Model):
    sales_type = models.CharField(max_length=255)
    product = models.ForeignKey(Product)
    quantity = models.IntegerField()
    customer = models.ForeignKey(Customer)


