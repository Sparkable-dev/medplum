#!/bin/sh
set -e

: ${MEDPLUM_BASE_URL:="http://localhost:8103/"}
: ${MEDPLUM_CLIENT_ID:=""}
: ${GOOGLE_CLIENT_ID:=""}
: ${RECAPTCHA_SITE_KEY:=""}
: ${MEDPLUM_REGISTER_ENABLED:="true"}
: ${MEDPLUM_AWS_TEXTRACT_ENABLED:="true"}

echo "Starting with MEDPLUM_BASE_URL=${MEDPLUM_BASE_URL}"

find "/usr/share/nginx/html/assets" -type f -exec sed -i \
  -e "s|__MEDPLUM_BASE_URL__|${MEDPLUM_BASE_URL}|g" \
  -e "s|__MEDPLUM_CLIENT_ID__|${MEDPLUM_CLIENT_ID}|g" \
  -e "s|__GOOGLE_CLIENT_ID__|${GOOGLE_CLIENT_ID}|g" \
  -e "s|__RECAPTCHA_SITE_KEY__|${RECAPTCHA_SITE_KEY}|g" \
  -e "s|__MEDPLUM_REGISTER_ENABLED__|${MEDPLUM_REGISTER_ENABLED}|g" \
  -e "s|__MEDPLUM_AWS_TEXTRACT_ENABLED__|${MEDPLUM_AWS_TEXTRACT_ENABLED}|g" \
  {} \;

echo "Environment variable replacement complete."
exec nginx -g 'daemon off;'
