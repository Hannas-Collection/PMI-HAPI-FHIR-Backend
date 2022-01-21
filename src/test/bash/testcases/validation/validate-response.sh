#!/bin/bash

# 1. Fragebogen anlegen
result=$(curl -s -X 'POST' \
  "${BASE_URL:-http://hapi.fhir.org/baseR4}/QuestionnaireResponse/$validate?_pretty=true" \
  -H 'accept: application/fhir+json' \
  -H 'Content-Type: application/fhir+json' \
  -d @src/test/resources/questionnaireResponseA.json)
