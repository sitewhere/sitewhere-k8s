#/bin/bash
# Copyright 2019, SiteWhere LLC.
# This script creates a backup of SiteWhere 2.0 MongoDB database
# running on a Kubernetes cluster
# usage: backup-mongodb.sh <BACKUP_DEST_DIR>

export SITEWHERE_DUMP_JOB=sitewhere-mongodump
export SW_K8S_HOME=`dirname "$0"`

# 
# Create a Dump PVC for storing mongodump results 
# 
function createDumpPVC() {
  echo "Creating DUMP PVC"
  kubectl apply -f $SW_K8S_HOME/sitewhere-mongodb-dump-pvc-rook.yaml
  echo "Creating DUMP PVC: DONE"
}

#
# Shutdowns SiteWhere Microservices
#
function shutdownMicroservices() {
  echo "Gracefully Downscale SiteWhere Microservices"
  kubectl scale deploy --replicas=0 -l sitewhere.io/role=microservice

  sleep 1m
  echo "Gracefully Downscale SiteWhere Microservices: DONE"
}

#
# Create a Job to execute mongodump 
#
function createBackupMongoDBJob(){
  local job
  echo "Backup MongoDB Database"

  job=$(kubectl get job $SITEWHERE_DUMP_JOB --output=jsonpath={.metadata.name} 2>/dev/null)

  if [ -n "$job" ]; then
    echo "SiteWhere Backup Job existe, deleting..."
    cleanUp
  fi

  kubectl apply -f $SW_K8S_HOME/sitewhere-mongodb-dump-job.yaml

  kubectl wait --timeout=2m --for=condition=complete job/$SITEWHERE_DUMP_JOB
  echo "Backup MongoDB Database: DONE"
}

#
# Copy the content of the mongodump outside of Kubernetes
#
function copyBackupOutsideOfK8s() {
  echo "Copy Backup Data Outside of the Cluster"

  kubectl apply -f $SW_K8S_HOME/sitewhere-mongodb-backup-pod.yaml

  kubectl wait --timeout=2m --for condition=ready pod/sitewhere-backup-admin-pod

  kubectl cp sitewhere-backup-admin-pod:/dump/mongodb $1

  kubectl delete -f $SW_K8S_HOME/sitewhere-mongodb-backup-pod.yaml
  echo "Copy Backup Data Outside of the Cluster: DONE"
}

#
# Clean up unsued Kubernetes objects.
#
function cleanUp() {
  kubectl delete -f $SW_K8S_HOME/sitewhere-mongodb-dump-job.yaml
  echo "SiteWhere MongoDB Dump Job Delete!"
}

function backup_mongodb () {
  local backup_dir backup_dir_timestamp

  if [[ $# != 1 ]]; then
    echo "Usage: backup-mongodb.sh <BACKUP_DEST_DIR>" >&2
    echo "" >&2
    echo "This script creates a backup of SiteWhere 2.0 MongoDB database running on a Kubernetes cluster." >&2

    return 1
  fi

  backup_dir="$1"

  if [ ! -d "$backup_dir" ]; then
    echo "Backup directory $backup_dir does not exist!" >&2
    return 2
  fi

  case "$backup_dir" in
  */)
      backup_dir_timestamp=$backup_dir$(date +%Y%m%d%H%M%S)
      ;;
  *)
      backup_dir_timestamp=$backup_dir/$(date +%Y%m%d%H%M%S)
      ;;
  esac
  
  echo "Creating MongoDB Backup to $backup_dir_timestamp"

  createDumpPVC
  shutdownMicroservices
  createBackupMongoDBJob
  copyBackupOutsideOfK8s $backup_dir_timestamp
  cleanUp

  echo "Creating MongoDB Backup to $backup_dir_timestamp: DONE"
}

backup_mongodb $@