import os
import uuid
from pydub import AudioSegment
from django.core.exceptions import ValidationError
from django.utils import timezone

def get_audio_upload_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = f'{uuid.uuid4()}.{ext}'
    return f'{instance.podcast.slug}/{timezone.now().strftime("%Y/%m/%d")}/{filename}'

def get_image_upload_path(filename):
    ext = filename.split('.')[-1]
    return f'{uuid.uuid4()}.{ext}'

def get_audio_duration_and_size(audio_file):
    # Supported audio file extensions
    SUPPORTED_FORMATS = ['.mp3', '.wav', '.ogg']

    # Validate input
    ext = os.path.splitext(audio_file.name)[1].lower()
    if ext not in SUPPORTED_FORMATS:
        raise ValidationError("Invalid audio file format")

    try:
        # Process audio file
        audio = AudioSegment.from_file(audio_file)
        duration = round(audio.duration_seconds)
        size = os.path.getsize(audio_file.path)
        return duration, size
    except Exception as e:
        raise ValidationError(f"Error processing audio file: {e}")
