# Generated by Django 2.2.3 on 2019-09-09 17:59

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='fileData',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(max_length=100)),
                ('hotelFile', models.FileField(upload_to='csvfiles')),
                ('restaurantFile', models.FileField(upload_to='csvfiles')),
            ],
        ),
        migrations.CreateModel(
            name='Hotel',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('address', models.CharField(max_length=100)),
                ('area', models.CharField(max_length=100)),
                ('city', models.CharField(max_length=100)),
                ('locality', models.CharField(max_length=100)),
                ('hotelDescription', models.CharField(max_length=1000)),
                ('hotelFacilities', models.CharField(max_length=1000)),
                ('guestRecommendation', models.IntegerField(default=99999)),
                ('hotelStarRating', models.IntegerField(default=3)),
                ('latitude', models.FloatField(default=0.0)),
                ('longitude', models.FloatField(default=0.0)),
                ('siteReviewRating', models.FloatField(default=0.0)),
                ('siteStayReviewRating', models.CharField(default='Good', max_length=100)),
                ('pointOfInterest', models.TextField()),
                ('propertyName', models.CharField(max_length=100)),
                ('propertyType', models.CharField(max_length=100)),
                ('state', models.CharField(max_length=100)),
                ('province', models.CharField(max_length=100)),
                ('roomType', models.CharField(default='Standard', max_length=100)),
                ('roomFacilities', models.CharField(max_length=1000)),
            ],
        ),
        migrations.CreateModel(
            name='Restaurant',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('restaurantName', models.CharField(max_length=200)),
                ('city', models.CharField(max_length=100)),
                ('locality', models.CharField(max_length=100)),
                ('address', models.CharField(max_length=100)),
                ('localityVerbose', models.CharField(max_length=200)),
                ('latitude', models.FloatField(default=0.0)),
                ('longitude', models.FloatField(default=0.0)),
                ('cuisines', models.CharField(default='Indian', max_length=1000)),
                ('averageCostForTwo', models.IntegerField()),
                ('aggregateRating', models.FloatField(default=0.0)),
                ('ratingText', models.CharField(max_length=100)),
            ],
        ),
    ]
