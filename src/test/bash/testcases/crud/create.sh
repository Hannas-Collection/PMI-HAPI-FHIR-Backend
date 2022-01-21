#!/bin/bash

# 1. Fragebogen anlegen
result=$(curl -s -X 'POST' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d @src/test/resources/questionnaire.json)

echo $result

# 2. ID raussuchen
id=$(echo $result | jq -r '.id')

echo "Questionnare $id created"

# 3. Fragebogen raussuchen
downloaded_questionnaire=$(curl -s -X 'GET' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/$id" \
  -H 'accept: application/fhir+json')

# 4. Vergleich der JSON Objekte
test "true" = \
  $(cat src/test/resources/questionnaire.json | \
      jq --argjson b "$downloaded_questionnaire" "(.  + {\"id\": \"$id\"} | del(.meta)) == (\$b | del(.meta))")
