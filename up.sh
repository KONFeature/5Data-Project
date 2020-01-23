#!/bin/bash

docker-compose -f docker-compose.db.yml \
  -f docker-compose.spark.yml \
  up
