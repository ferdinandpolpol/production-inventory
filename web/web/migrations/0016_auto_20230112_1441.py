# Generated by Django 3.2.16 on 2023-01-12 14:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0015_auto_20221102_1128'),
    ]

    operations = [
        migrations.AlterField(
            model_name='purchase',
            name='type',
            field=models.CharField(choices=[('SUPPLY', 'Supply'), ('OTHERS', 'Others')], max_length=255),
        ),
        migrations.AlterField(
            model_name='supply',
            name='purchase_order',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='supplies', to='web.purchase'),
        ),
    ]