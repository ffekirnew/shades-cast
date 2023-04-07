from django.http import JsonResponse

def api_home(request, *args, **kwargs):
    return JsonResponse({
        "message": "this is your json api response."
    })