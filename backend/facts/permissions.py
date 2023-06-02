from rest_framework import permissions


class IsUserAdminOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        # Read-only permissions are allowed for any request
        if request.method in permissions.SAFE_METHODS:
            return True

        # Return True if user is a legitimate admin/super user
        return request.user.is_staff
