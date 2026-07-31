"""Production settings — secrets and hosts come from the environment.

Required env vars: DJANGO_SECRET_KEY, DJANGO_ALLOWED_HOSTS (comma-separated),
DEEPGRAM_API_KEY, and CORS_ALLOWED_ORIGINS (comma-separated).
"""

import os

from .base import *  # noqa: F401,F403

DEBUG = False

ALLOWED_HOSTS = [
    host.strip()
    for host in os.environ.get("DJANGO_ALLOWED_HOSTS", "").split(",")
    if host.strip()
]

# Explicit allow-list in production — never allow all origins.
CORS_ALLOW_ALL_ORIGINS = False
CORS_ALLOWED_ORIGINS = [
    origin.strip()
    for origin in os.environ.get("CORS_ALLOWED_ORIGINS", "").split(",")
    if origin.strip()
]

# TODO: authenticate the WebSocket before production (see requirements.md scope).
