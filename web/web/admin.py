from django.contrib import admin
from rangefilter.filter import DateRangeFilter

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



class SalesAdmin(admin.ModelAdmin):
    list_display = ['customer', 'product', 'actual_sale', 'date']

    # add filter sidebar for customer and product and date
    # date should be datepicker
    list_filter = ['customer', 'product', ('date', DateRangeFilter)]

class SupplyAdmin(admin.ModelAdmin):
    list_display = ['item', 'quantity', 'supplied_at']
    list_filter = ['item', ('supplied_at', DateRangeFilter)]

class SupplyInline(admin.TabularInline):
    model = Supply



class PurchaseAdmin(admin.ModelAdmin):
    list_display = ['supplier', 'notes', 'amount', 'date']

    list_filter = ['supplier', ('date', DateRangeFilter)]
    inlines = [ 
        SupplyInline,
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
admin.site.register(Sales, SalesAdmin)
admin.site.register(Purchase, PurchaseAdmin)
admin.site.register(Supplier, SupplierAdmin)
