import os
import uuid
from pydub import AudioSegment
from django.core.exceptions import ValidationError
from django.utils import timezone

SUPPORTED_AUDIO_FORMATS = ['.mp3', '.wav', '.ogg']

def get_audio_upload_path(instance, filename):
    """Upload the audio and return the file path.

    Args:
        instance (models.Model): The instance to which this audio is being uploaded.
        filename (String): The initial file name of the uploaded file.

    Raises:
        ValidationError: If the uploaded audio is not in the supported audio formats.

    Returns:
        _type_: String, the path for the successfully uploaded audio.
    """

    
    ext = filename.split('.')[-1]
    if ext not in SUPPORTED_AUDIO_FORMATS:
        raise ValidationError("Invalid audio file format")
    
    filename = f'{uuid.uuid4()}.{ext}'
    return f'{instance.podcast.slug}/{timezone.now().strftime("%Y/%m/%d")}/{filename}'

def get_image_upload_path(instance, filename):
    ext = filename.split('.')[-1]
    return f'{instance.slug}/cover-images/{uuid.uuid4()}.{ext}'

def get_audio_duration_and_size(audio_file):
    try:
        # Process audio file
        audio = AudioSegment.from_file(audio_file)
        duration = round(audio.duration_seconds)
        size = os.path.getsize(audio_file.path)
        return duration, size
    except Exception as e:
        raise ValidationError(f"Error processing audio file: {e}")
