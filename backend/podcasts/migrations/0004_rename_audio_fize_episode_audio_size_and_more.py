# Generated by Django 4.2 on 2023-04-11 05:41

from django.db import migrations, models
import podcasts.models_utils


class Migration(migrations.Migration):

    dependencies = [
        ('podcasts', '0003_alter_episode_audio_file'),
    ]

    operations = [
        migrations.RenameField(
            model_name='episode',
            old_name='audio_fize',
            new_name='audio_size',
        ),
        migrations.AlterField(
            model_name='episode',
            name='audio_file',
            field=models.FileField(blank=True, upload_to=podcasts.models_utils.get_audio_upload_path),
        ),
    ]