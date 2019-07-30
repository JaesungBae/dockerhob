#!/bin/bash

echo "executed: start.sh"

if [ -z "${PUID}" -o -z "${PGID}" ]; then
    exec /bin/bash
else
    if [ "${PUID}" -eq 0 -o "${PGID}" -eq 0 ]; then
        echo "Nothing to do here." ; exit 0
    fi
fi

PGID=${PGID:-5555}
PUID=${PUID:-5555}

groupmod -o -g "$PGID" coder
usermod -o -u "$PUID" coder

echo "PUID=${PUID}"
echo "PGID=${PGID}"

chown -R ${PUID}:${PGID} /home/coder

exec /usr/sbin/sshd -D