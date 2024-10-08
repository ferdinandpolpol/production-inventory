# Generated by Django 3.2.16 on 2022-11-01 12:38

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0006_alter_ingredient_recipe'),
    ]

    operations = [
        migrations.AddField(
            model_name='ingredient',
            name='main_ingredient',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='ingredient',
            name='multiplied_by_main_ingredient',
            field=models.BooleanField(default=True),
        ),
        migrations.AlterField(
            model_name='productioningredients',
            name='production',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='ingredients', to='backend.production'),
        ),
    ]
