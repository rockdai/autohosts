#!/bin/bash

set -e

ONLINE_PATH="http://www.rockdai.com/hosts.txt"

LOCAL_DIR="/etc"
LOCAL_PATH="$LOCAL_DIR/hosts"
LOCAL_BAK_PATH="$LOCAL_DIR/hosts.hh_bak"
ONLINE_CONTENT=`curl $ONLINE_PATH`

# Backup
/bin/cp -f "$LOCAL_PATH" "$LOCAL_BAK_PATH"

userContent=`awk '{ \
  if ($1 ~ /^#\+ROCKDAI_HOST_BEGIN/) { \
    start = FNR \
  } else if ($1 ~ /^#\+ROCKDAI_HOST_END/) { \
    end = FNR \
  }; \
  if ((!start || (start && FNR < start)) || (end && end < FNR)) \
    print $0 \
}' $LOCAL_PATH`

echo "$userContent\n\n\n\n\
#+ROCKDAI_HOST_BEGIN\n\
$ONLINE_CONTENT\n\
#+ROCKDAI_HOST_END" > $LOCAL_PATH



