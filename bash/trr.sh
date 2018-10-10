# Settings
export SEARCH_ALGOLIA_PRODUCTS_INDEX="products_staging"
export SEARCH_ALGOLIA_APPLICATION_ID="882Q2S895V"
export SEARCH_ALGOLIA_API_KEY="0796d0619ff21d424204ae39964adc6b"

export CRM_SALESFORCE_URL="https://therealreal--Dev.cs21.my.salesforce.com"
export CRM_SALESFORCE_CLIENT_ID="3MVG9zZht._ZaMunIw02Zmy.qM3cl.E.ObAFDuPhMMTv1t9X9KZN6mkGRTEsGfdIYBBY3R9trlmh3PFaT3Oiz"
export CRM_SALESFORCE_REFRESH_TOKEN="5Aep861OpTpDdf1AySoNQ6LNRsdhLEO7UkFWTHo4E7Ec8V9xmiRiqtLvEFVfCR2d6UmaDolxK4vlfmC0hCo.5hu"
export CRM_STREAMING_URL="https://therealreal--Dev.my.salesforce.com/cometd/42.0"


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

