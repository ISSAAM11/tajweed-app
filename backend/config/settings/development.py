"""Development settings — DEBUG on, permissive CORS for the local client."""

from .base import *  # noqa: F401,F403

DEBUG = True

ALLOWED_HOSTS = ["*"]

# Allow the mobile / web client during development.
CORS_ALLOW_ALL_ORIGINS = True
