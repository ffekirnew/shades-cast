from rest_framework import permissions


class IsPodcastCreatorOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):

        # Read-only permissions are allowed for any request
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the author of a post
        return obj.creator == request.user


class IsEpisodeCreatorOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):

        # Read-only permissions are allowed for any request
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the author of a post
        return obj.podcast.creator == request.user
