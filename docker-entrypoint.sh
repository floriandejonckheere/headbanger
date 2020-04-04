#!/bin/bash
#
# docker-entrypoint.sh - Start server
#

N=5

while true; do
    curl -s -I -u "#{ENV['NEO4J_USER']}:#{ENV['NEO4J_PASS']}" "http://${NEO4J_HOST}:7474" | grep -q "200 OK"

    if [[ $? -eq 0 ]]; then
        echo "Neo4j is up, starting app"
        break
    fi

    echo "Neo4j is not up yet, sleeping ${N} seconds"
    sleep ${N}
done

# Remove stale lock files
rm -f /app/tmp/pids/server.pid

cd /app

# Migrate relational data
[[ ${SKIP_MIGRATE} ]] || bundle exec rake db:migrate
[[ ${SKIP_MIGRATE} ]] || bundle exec rake neo4j:migrate

# Start app server
bundle exec puma -b unix:///app/tmp/sockets/puma.sock
