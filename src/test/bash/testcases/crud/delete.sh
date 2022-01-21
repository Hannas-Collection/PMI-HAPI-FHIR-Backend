#!/bin/bash

# 1. Fragebogen anlegen
result=$(curl -s -X 'POST' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d @src/test/resources/questionnaire.json)

# 2. ID raussuchen
id=$(echo $result | jq -r '.id')

# 3. Fragebogen löschen
curl -s -X 'DELETE' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/$id" \
  -H 'accept: application/fhir+json' > /dev/null

# 4. Fragebogen raussuchen
status=$(curl -I -s -X 'GET' \
    -H 'accept: application/fhir+json' \
    "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/$id" | \
      grep "HTTP/1.1" | cut -d' ' -f2)

# 5. Vergleich des HTTP Status
test "$status" = "410"
