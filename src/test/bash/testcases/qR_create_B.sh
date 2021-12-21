#!/bin/bash

# 1. Antwortbogen B erstellen

response=$(curl -X 'POST' \
  'http://hapi.fhir.org/baseR4/QuestionnaireResponse' \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d '@src/test/resources/questionnaireResponseB.json')

id=$(echo $response | jq -r '.id')

echo $id

# 3. QuestionnaireResponse herunterladen
downloaded_questionnaire=$(curl -s -X 'GET' \
  -H 'accept: application/fhir+json' \
  "http://hapi.fhir.org/baseR4/QuestionnaireResponse/$id")

# 3. JSON Objekte vergleichen
test "true" = \
  $(cat src/test/resources/questionnaireResponseB.json | \
      jq --argjson b "$downloaded_questionnaire" "(.  + {\"id\": \"$id\"} | del(.meta)) == (\$b | del(.meta))") || exit 1

test "false" = \
  $(cat src/test/resources/questionnaireResponseA.json | \
      jq --argjson b "$downloaded_questionnaire" "(.  + {\"id\": \"$id\"} | del(.meta)) == (\$b | del(.meta))") || exit 1
