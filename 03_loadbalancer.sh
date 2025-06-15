#!/bin/bash

cd compose/lbs
docker compose build
docker compose up -d
