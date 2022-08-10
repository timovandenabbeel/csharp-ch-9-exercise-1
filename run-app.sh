#!/bin/bash

set -euo pipefail

dotnet build
docker-compose build
docker-compose up
