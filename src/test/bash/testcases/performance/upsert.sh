#!/bin/bash

# 1. Fragebogen anlegen

slow() {
  newid=$(openssl rand -hex 16)

  result=$(curl -s -X 'PUT' \
    "http://hapi.fhir.org/baseR4/Questionnaire/${newid}" \
    -H 'accept: application/fhir+json' \
    -H 'Content-Type: application/fhir+json' \
    -d '{
  	"resourceType": "Questionnaire",
    "id": "'${newid}'",
  	"meta": {
  		"versionId": "4",
  		"lastUpdated": "2021-11-28T17:46:56.695+00:00",
  		"source": "#Gmaezcahn1tNkBZd"
  	},
  	"url": "localhost:5001/PMI_FhirBackend/questionnaire/0",
  	"name": "Qn_1",
  	"title": "Fragebogen 1",
  	"item": [{
  		"linkId": "Q1",
  		"prefix": "1)",
  		"text": "Wenden Sie im Moment eine natürliche Methode/NFP an?",
  		"type": "boolean",
  		"required": true,
  		"item": [{
  			"linkId": "Q1.1",
  			"text": "Wenn ja, seit wann?",
  			"type": "group",
  			"enableWhen": [{
  				"question": "Q1",
  				"operator": "="
  			}]
  		}]
  	}]
  }')
}

fast() {
  newid=$(openssl rand -hex 16)


  result=$(curl -s -X 'PUT' \
    "http://hapi.fhir.org/baseR4/Questionnaire/${newid}" \
    -H 'accept: application/fhir+json' \
    -H 'Content-Type: application/fhir+json' \
    -H 'X-Upsert-Extistence-Check: disabled' \
    -d '{
  	"resourceType": "Questionnaire",
    "id": "'${newid}'",
  	"meta": {
  		"versionId": "4",
  		"lastUpdated": "2021-11-28T17:46:56.695+00:00",
  		"source": "#Gmaezcahn1tNkBZd"
  	},
  	"url": "localhost:5001/PMI_FhirBackend/questionnaire/0",
  	"name": "Qn_1",
  	"title": "Fragebogen 1",
  	"item": [{
  		"linkId": "Q1",
  		"prefix": "1)",
  		"text": "Wenden Sie im Moment eine natürliche Methode/NFP an?",
  		"type": "boolean",
  		"required": true,
  		"item": [{
  			"linkId": "Q1.1",
  			"text": "Wenn ja, seit wann?",
  			"type": "group",
  			"enableWhen": [{
  				"question": "Q1",
  				"operator": "="
  			}]
  		}]
  	}]
  }')
}

i=0
start=$(date '+%s')
while [ $i -le 10 ]; do
  slow
  i=$((i+1))
done
end=$(date '+%s')
slowtime=$((end-start))
echo $slowtime


i=0
start=$(date '+%s')
while [ $i -le 10 ]; do
  fast
  i=$((i+1))
done
end=$(date '+%s')
fasttime=$((end-start))
echo $fasttime

# Slow muss in 10 Durchlaeufen insgesamt min. 5 Sekunden langsamer sein
test $slowtime -ge $((fasttime+5))
