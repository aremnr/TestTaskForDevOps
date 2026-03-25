#!/bin/sh
set -e

file_env() {
    local var="$1"
    local fileVar="${var}_FILE"
    eval "local file=\"\${$fileVar:-}\""
    eval "local val=\"\${$var:-}\""

    if [ -n "$file" ] && [ -z "$val" ]; then
        if [ -f "$file" ]; then
            export "$var"="$(cat "$file" | tr -d '\n\r')"
        fi
    fi
}

for env_var in $(env | grep '_FILE=' | cut -d= -f1); do
    real_var=$(echo "$env_var" | sed 's/_FILE$//')
    file_env "$real_var"
done

exec "$@"