#!/bin/bash
#
# docker-entrypoint.sh - Start server
#

N=5

while true; do
    curl -s -I -u "#{ENV['NEO4J_USER']}:#{ENV['NEO4J_PASS']}" "http://${NEO4J_HOST}:${NEO4J_PORT}" | grep -q "200 OK"

    if [[ $? -eq 0 ]]; then
        echo "Neo4j is up, starting app"
        break
    fi

    echo "Neo4j is not up yet, sleeping ${N} seconds"
    sleep ${N}
done


cd /app

rm -f /app/tmp/pids/server.pid

[[ ${SKIP_MIGRATE} ]] || bundle exec rake db:migrate            # Migrate relational data
[[ ${SKIP_MIGRATE} ]] || bundle exec rake db:data:migrate       # Migrate graph data
bundle exec rails server -p 8080                                # Start puma
