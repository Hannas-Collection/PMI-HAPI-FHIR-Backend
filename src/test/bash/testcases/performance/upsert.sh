#!/bin/bash

# 1. Fragebogen anlegen

slow() {
  newid=$(openssl rand -hex 16)

  result=$(curl -s -X 'PUT' \
    "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/${newid}" \
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

# 2. Im Header wird 'X-Upsert-Existence-Check: disabled' eingefügt.
  result=$(curl -s -X 'PUT' \
    "${BASE_URL:-http://hapi.fhir.org/baseR4}/Questionnaire/${newid}" \
    -H 'accept: application/fhir+json' \
    -H 'Content-Type: application/fhir+json' \
    -H 'X-Upsert-Existence-Check: disabled' \
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

AMOUNT=20

i=0
start=$(date '+%s')
while [ $i -le $AMOUNT ]; do
  slow
  i=$((i+1))
done
end=$(date '+%s')
slowtime=$((end-start))
echo "$AMOUNT Einfügeoperationen ohne 'X-Upsert-Existence-Check: disabled' dauern" $slowtime "Sekunden"


i=0
start=$(date '+%s')
while [ $i -le $AMOUNT ]; do
  fast
  i=$((i+1))
done
end=$(date '+%s')
fasttime=$((end-start))
echo "$AMOUNT Einfügeoperationen mit 'X-Upsert-Existence-Check: disabled' dauern" $fasttime "Sekunden"

# 3. Slow muss in 20 Durchlaeufen insgesamt min. 10 Sekunden langsamer sein
if ! test $slowtime -ge $((fasttime+$((AMOUNT/2)))); then
  echo "Zeit für $AMOUNT Anfragen ohne 'X-Upsert-Existence-Check: disabled': " $slowtime >&2
  echo "Zeit für $AMOUNT Anfragen mit 'X-Upsert-Existence-Check: disabled': " $fasttime >&2
  echo "'X-Upsert-Existence-Check: disabled' macht die Ausführung im Mittel nicht um 0,5 Sekunden schneller." >&2
  exit 1
fi
