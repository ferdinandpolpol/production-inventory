# Generated by Django 3.2.16 on 2022-11-01 18:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0010_sales_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='supply',
            name='supplied_at',
            field=models.DateField(),
        ),
    ]
