from django.contrib import admin

from .models import (
    CustomerType, Customer, Product,
    SupplyItem, Supply, Recipe,
    Production, Sales
    )

admin.site.register(CustomerType)
admin.site.register(Customer)
admin.site.register(Product)
admin.site.register(SupplyItem)
admin.site.register(Supply)
admin.site.register(Recipe)
admin.site.register(Production)
admin.site.register(Sales)