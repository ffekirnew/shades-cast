# Generated by Django 4.2 on 2023-04-21 13:29

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('podcasts', '0007_rename_creater_episode_creator'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='episode',
            name='creator',
        ),
        migrations.AddField(
            model_name='podcast',
            name='creator',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]
