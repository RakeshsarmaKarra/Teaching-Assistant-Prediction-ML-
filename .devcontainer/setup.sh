#!/usr/bin/env bash
set -e

apt-get update
apt-get install -y --no-install-recommends \
    git \
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

R -q -e "pkgs <- c(
            'languageserver',
            'tidyverse',
            'randomForest',
            'e1071',
            'rpart',
            'rpart.plot',
            'ggplot2',
            'dplyr',
            'readr',
            'janitor'
          );
          missing <- pkgs[!pkgs %in% rownames(installed.packages())];
          if (length(missing)) install.packages(missing, repos='https://cloud.r-project.org')"
