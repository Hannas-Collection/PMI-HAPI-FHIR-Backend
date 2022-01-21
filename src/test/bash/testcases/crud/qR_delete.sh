#!/bin/bash

# 1. Antwortbogen löschen
response=$(curl -X 'POST' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/QuestionnaireResponse" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d '@src/test/resources/questionnaireResponseA.json')

id=$(echo $response | jq -r '.id')

echo $id

curl -X 'DELETE' \
    "${BASE_URL:-http://hapi.fhir.org/baseR4}/QuestionnaireResponse/$id" \
    -H 'accept: application/fhir+json'


status=$(curl -I -s -X 'GET' \
  -H 'accept: application/fhir+json' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/QuestionnaireResponse/$id" | \
  grep "HTTP/1.1" | cut -d' ' -f2)

# 5. Reponse-Status testen
test "$status" = "410"
