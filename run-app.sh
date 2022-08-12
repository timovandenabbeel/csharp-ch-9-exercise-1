#!/bin/bash

set -euo pipefail

docker build -t webapp .
docker run -t -d -p 80:80 --network mssql_default --name SportStoreWebApp webapp >2 ~/SportStoreLog.log
