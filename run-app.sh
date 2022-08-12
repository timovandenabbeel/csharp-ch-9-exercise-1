#!/bin/bash

set -euo pipefail

docker build -t WebApp .
docker run -t -p 80:80 --network mssql_default --name SportStoreWebApp WebApp
