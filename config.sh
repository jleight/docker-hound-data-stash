#!/bin/sh

exec /usr/local/bin/python /hound/config.py \
    "${STASH_URL}" \
    "${STASH_USER}" \
    "${STASH_PASS}" | tee /hound/config.json
