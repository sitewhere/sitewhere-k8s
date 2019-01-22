#/bin/bash
# Copyright 2019, SiteWhere LLC.
# This script restores a backup of SiteWhere 2.0 MongoDB database
# running on a Kubernetes cluster from and backup directory.
# usage: backup-mongodb.sh <BACKUP_DEST_DIR>

export SITEWHERE_RESTORE_JOB=sitewhere-mongorestore
export SW_K8S_HOME=$(cd `dirname $0` && pwd)

# 
# Create a Dump PVC for storing mongodump results 
# 
function createDumpPVC() {
  echo "Creating DUMP PVC"
  kubectl apply -f $SW_K8S_HOME/sitewhere-mongodb-dump-pvc-rook.yaml
  kubectl wait --timeout=2m pvc/sitewhere-mongodump-pvc --for condition=bound
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
# Copy the content of the mongodump outside of Kubernetes
#
function copyBackupToK8s() {
  echo "Copy Backup Data into the Cluster"

  kubectl apply -f $SW_K8S_HOME/sitewhere-mongodb-backup-pod.yaml

  kubectl wait --timeout=2m pod/sitewhere-backup-admin-pod --for condition=ready

  for f in $1*; do
    if [[ -d $f ]]; then
      echo "Copying $f into the cluster"
      kubectl cp $f sitewhere-backup-admin-pod:/dump/mongodb
    fi
  done

  kubectl delete -f $SW_K8S_HOME/sitewhere-mongodb-backup-pod.yaml

  kubectl wait --timeout=2m pod/sitewhere-backup-admin-pod --for=delete

  echo "Copy Backup Data into the Cluster: DONE"
}

#
# Create a Job to execute mongorestore
#
function createRestoreMongoDBJob(){
  local job
  echo "Restore MongoDB Database"

  job=$(kubectl get job $SITEWHERE_RESTORE_JOB --output=jsonpath={.metadata.name} 2>/dev/null)

  if [ -n "$job" ]; then
    echo "SiteWhere Restore Job existe, deleting..."
    cleanUp
  fi

  kubectl apply -f $SW_K8S_HOME/sitewhere-mongodb-restore-job.yaml

  kubectl wait --timeout=2m --for=condition=complete job/$SITEWHERE_RESTORE_JOB
  echo "Restore MongoDB Database: DONE"
}

#
# Clean up unsued Kubernetes objects.
#
function cleanUp() {
  kubectl delete -f $SW_K8S_HOME/sitewhere-mongodb-restore-job.yaml
  echo "SiteWhere MongoDB Restore Job Delete!"
}

function restore_mongodb () {
  local restore_dir restore_dir_timestamp

  if [[ $# != 1 ]]; then
    echo "Usage: restore-mongodb.sh <BACKUP_DIR>" >&2
    echo "" >&2
    echo "This script restores a backup of SiteWhere 2.0 MongoDB database" >&2
    echo "running on a Kubernetes cluster from and backup directory." >&2

    return 1
  fi

  case "$1" in
  */)
      restore_dir="$1"
      ;;
  *)
      restore_dir="$1/"
      ;;
  esac

  if [ ! -d "$restore_dir" ]; then
    echo "Backup directory $restore_dir does not exist!" >&2
    return 2
  fi

  echo "Restoring MongoDB Backup from $restore_dir"

  createDumpPVC
  shutdownMicroservices
  copyBackupToK8s $restore_dir
  createRestoreMongoDBJob
  cleanUp

  echo "Restoring MongoDB Backup from $restore_dir: DONE"  

}

restore_mongodb $@