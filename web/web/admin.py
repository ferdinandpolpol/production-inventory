from django.contrib import admin

from .models import (
    CustomerType, Customer, Ingredient, Product, ProductionIngredients,
    SupplyItem, Supply, Recipe,
    Production, Sales, Purchase, Supplier
)


class IngredientInline(admin.TabularInline):
    model = Ingredient


class RecipeAdmin(admin.ModelAdmin):
    inlines = [
        IngredientInline,
    ]

    
class SupplierAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Supplier._meta.get_fields()]
class PurchaseAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Purchase._meta.get_fields()]



admin.site.register(CustomerType)
admin.site.register(Customer)
admin.site.register(Product)
admin.site.register(SupplyItem)
admin.site.register(Supply)
admin.site.register(Ingredient)
admin.site.register(Recipe, RecipeAdmin)
admin.site.register(ProductionIngredients)
admin.site.register(Production)
admin.site.register(Sales)
admin.site.register(Purchase, PurchaseAdmin)
admin.site.register(Supplier, SupplierAdmin)
