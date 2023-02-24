#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# This is a small helper script used to extract the Caddy version numbers used
# for tagging the final Docker container. This script expects one input
# argument, and that is the path to the Dockerfile of interest.
#
# The output from this script is a list of key=values suitable for GITHUB_ENV

if [ ! -f "${1}" ]; then
    >&2 echo "File '${1}' was not found"
    exit 1
fi

caddy_major=$(sed -n -r -e 's/^FROM caddy:([1-9])\.[0-9]+\.[0-9]+$/\1/p' "${1}")
caddy_minor=$(sed -n -r -e 's/^FROM caddy:[1-9]\.([0-9]+)\.[0-9]+$/\1/p' "${1}")
caddy_patch=$(sed -n -r -e 's/^FROM caddy:[1-9]\.[0-9]+\.([0-9]+)$/\1/p' "${1}")
echo "CADDY_MAJOR=${caddy_major}"
echo "CADDY_MINOR=${caddy_minor}"
echo "CADDY_PATCH=${caddy_patch}"
if ! [ -n "${caddy_major}" -a -n "${caddy_minor}" -a -n "${caddy_patch}" ]; then
    >&2 echo "Could not extract all expected values."
    exit 1
fi
