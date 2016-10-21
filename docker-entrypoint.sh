#!/bin/sh
#
# docker-entrypoint.sh - Start server after ensuring database connections
#

N=5

while true; do
    curl -s -I "http://${NEO4J_HOST}:${NEO4J_PORT}" | grep -q "200 OK"

    if [[ $? -eq 0 ]]; then
        echo "Neo4j is up, starting app"
        break
    fi

    echo "Neo4j is not up yet, sleeping ${N} seconds"
    sleep ${N}
done

cd /app

[[ ${SKIP_MIGRATE} ]] || bundle exec rake db:migrate             # Migrate relational data
[[ ${SKIP_MIGRATE} ]] || bundle exec rake db:data:migrate        # Migrate graph data
[[ ${SKIP_PRECOMPILE} ]] || bundle exec rake assets:precompile      # Precompile assets
bundle exec rails server -p 8080        # Start puma
