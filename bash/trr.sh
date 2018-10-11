# Settings

# Algolia Service
export SEARCH_ALGOLIA_PRODUCTS_INDEX="products_staging"
export SEARCH_ALGOLIA_APPLICATION_ID="882Q2S895V"
export SEARCH_ALGOLIA_API_KEY="0796d0619ff21d424204ae39964adc6b"

# CRM Service
export CRM_SALESFORCE_URL="https://therealreal--Dev.cs21.my.salesforce.com"
export CRM_SALESFORCE_CLIENT_ID="3MVG9zZht._ZaMunIw02Zmy.qM3cl.E.ObAFDuPhMMTv1t9X9KZN6mkGRTEsGfdIYBBY3R9trlmh3PFaT3Oiz"
export CRM_SALESFORCE_REFRESH_TOKEN="5Aep861OpTpDdf1AySoNQ6LNRsdhLEO7UkFWTHo4E7Ec8V9xmiRiqtLvEFVfCR2d6UmaDolxK4vlfmC0hCo.5hu"
export CRM_STREAMING_URL="https://therealreal--Dev.my.salesforce.com/cometd/42.0"

# Kafka Service
export KAFKA_URL="kafka://localhost:9096"                # - advertised.listseners
export KAFKA_PLAINTEXT_URL="kafka://localhost:9092"      # - listseners
export KAFKA_ZOOKEEPER_URL="zookeeper://localhost:2181"  # - zookeeper.connect
export KAFKA_AUTO_OFFSET_RESET="earliest"
export KAFKA_CLIENT_ID="web"
export KAFKA_DELIVERY_THRESHOLD="100"
export KAFKA_DELIVERY_INTERVAL="5"
export KAFKA_MAX_QUEUE_SIZE="4000"
export KAFKA_MAX_BUFFER_SIZE="1000"
export KAFKA_MAX_BUFFER_BYTESIZE="1000000"
export KAFKA_CONSUMER_MAX_WAIT_TIME="1"
export KAFKA_TRUSTED_CERT=`cat $HOME/.certs/kafka.trusted.cert`
export KAFKA_CLIENT_CERT=`cat $HOME/.certs/kafka.client.cert`
export KAFKA_CLIENT_CERT_KEY=`cat $HOME/.certs/kafka.client.cert.key`

# Aliases
alias api='cd $GOPATH/src/github.com/TheRealReal/therealreal-api'
alias grok='ngrok http 8080'

# Functions
function gateway {
  refresh
  api
  go install
  therealreal-api
}

