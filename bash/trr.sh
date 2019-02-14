# Settings

# Algolia Service
export SEARCH_ALGOLIA_PRODUCTS_INDEX="products_test"
export SEARCH_ALGOLIA_APPLICATION_ID="882Q2S895V"
export SEARCH_ALGOLIA_API_KEY="0796d0619ff21d424204ae39964adc6b"

# CRM Service
export CRM_SALESFORCE_URL="https://therealreal--Staging.cs71.my.salesforce.com"
export CRM_SALESFORCE_CLIENT_ID="3MVG9M6Iz6p_Vt2ySX3eTVn.6gNBW1GGAbvoyiXD9KI6QCOxONV6Eh6touuB89IvtOcVDDvQmVHDBvBLBGyyL"
export CRM_SALESFORCE_REFRESH_TOKEN="5Aep861ZdNG8XtKaC4Z960KKM4b_.DQphkbLiRpwA8L9p29zmnZiqeAV9qeAasTvPb4eGxWwWrC6oZeteXKo879"
export CRM_STREAMING_URL="https://therealreal--Staging.my.salesforce.com/cometd/42.0"

# Encryptor
export ENCRYPTOR_SECRET_TOKEN="09381ccf0e8fecbf05029b40ede82893458f274f3c8a7b7a33b3c59aadddd1123a08eed3f54c182133010dfa9e9b14b30388ffa8d8ef466301a3e85f23f2a7af"

# Aliases
alias api='cd $GOPATH/src/github.com/TheRealReal/therealreal-api'

# Functions
function gateway {
  refresh
  api
  go install
  therealreal-api
}

