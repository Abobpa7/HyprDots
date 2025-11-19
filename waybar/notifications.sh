#!/usr/bin/env bash

count=$(dunstctl count waiting)

if [ "$count" -eq 0 ]; then
  echo '{"icon": "none"}'
else
  echo '{"icon": "some"}'
fi
