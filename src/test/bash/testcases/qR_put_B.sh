#!/bin/bash

# 1. Fragebogen anlegen
result=$(curl -s -X 'POST' \
  'http://hapi.fhir.org/baseR4/QuestionnaireResponse' \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d @src/test/resources/questionnaireResponseB.json)

# 2. ID raussuchen
id=$(echo $result | jq -r '.id')

downloaded_questionnaire=$(curl -s -X 'GET' \
  "http://hapi.fhir.org/baseR4/QuestionnaireResponse/$id" \
  -H 'accept: application/fhir+json')

manipulated_questionnaire=$(echo "$downloaded_questionnaire" | jq ". + {\"status\": \"completed\"}")

# mein Versuch:)
newResult=$(curl -X 'PUT' \
  "http://hapi.fhir.org/baseR4/QuestionnaireResponse/$id" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d "$manipulated_questionnaire")

  # echo "$newResult"

# 3. Fragebogen raussuchen
downloaded_questionnaire=$(curl -s -X 'GET' \
  "http://hapi.fhir.org/baseR4/QuestionnaireResponse/$id" \
  -H 'accept: application/fhir+json')

# 4. Vergleich der JSON Objekte
test "true" = \
  $(echo "$manipulated_questionnaire" | \
      jq --argjson b "$downloaded_questionnaire" "(.  + {\"id\": \"$id\"} | del(.meta)) == (\$b | del(.meta))")
