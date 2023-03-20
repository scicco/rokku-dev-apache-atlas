#!/bin/sh

export MANAGE_LOCAL_HBASE=true
export MANAGE_LOCAL_SOLR=true
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

/apache-atlas/bin/atlas_start.py
# we don't need any atlas setup
#sh /tmp/atlas-setup.sh

tail -fF /apache-atlas/logs/application.log
