#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pandoc

R -q -e "install.packages(c('tidyverse','caret','randomForest','e1071','rpart','rpart.plot','ggplot2','dplyr','readr','janitor'), repos='https://cloud.r-project.org')"
