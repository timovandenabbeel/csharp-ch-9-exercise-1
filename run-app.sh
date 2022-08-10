#!/bin/bash

set -euo pipefail

sudo dotnet build
sudo docker-compose build
sudo docker-compose up
