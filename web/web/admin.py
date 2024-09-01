from django.contrib import admin

from .models import (
    CustomerType, Customer, Ingredient, Product, ProductionIngredients,
    SupplyItem, Supply, Recipe,
    Production, Sales
    )

class IngredientInline(admin.TabularInline):
    model = Ingredient

class RecipeAdmin(admin.ModelAdmin):
    inlines = [
        IngredientInline,
    ]


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