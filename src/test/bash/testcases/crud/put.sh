#!/bin/bash

# 1. Fragebogen anlegen
result=$(curl -s -X 'POST' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d @src/test/resources/questionnaire.json)

# 2. ID raussuchen
id=$(echo $result | jq -r '.id')

downloaded_questionnaire=$(curl -s -X 'GET' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/$id" \
  -H 'accept: application/fhir+json')

manipulated_questionnaire=$(echo "$downloaded_questionnaire" | jq ". + {\"title\": \"$(pwgen 10 1)\"}")

# 3. Veraendern des Fragebogens
newResult=$(curl -X 'PUT' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/$id" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d "$manipulated_questionnaire")

# 4. Veraenderten Fragebogen raussuchen
downloaded_questionnaire=$(curl -s -X 'GET' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/$id" \
  -H 'accept: application/fhir+json')

# 4. Vergleich der JSON Objekte
test "true" = \
  $(echo "$manipulated_questionnaire" | \
      jq --argjson b "$downloaded_questionnaire" "(.  + {\"id\": \"$id\"} | del(.meta)) == (\$b | del(.meta))")
