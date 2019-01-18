# Copyright 2019, SiteWhere LLC.
# This script restores a backup of SiteWhere 2.0 Apache Zookeeper
# running on a Kubernetes cluster from and backup directory.
# usage: restore-zookeeper.sh <BACKUP_DIR> <REPLICAS>

export SW_K8S_HOME=`dirname "$0"`

#
# Creates Dummy Pods for mounting Apache Zookeeper PVC and restoring data
# arg: 
#    $1: Replica Number
#
function createDummyPods() {
  echo "Creating Pods for Mounting Zookeeper PVC"

  kubectl apply -f $SW_K8S_HOME/sitewhere-zk-backup-pod.yaml

  for (( r=0; r < $1; r++ ))
  do
    kubectl wait pod/sitewhere-backup-zk-pod-$r --for condition=ready
  done

  echo "Creating Pods for Mounting Zookeeper PVC: DONE"
}

#
# Restore Zookeeper dataDir
# arg: 
#    $1: Replica Number
#    $2: Backup Dir   
#
function restorZookeeperDataDir () {
  local DEST_DIR=$2$1
  
  #echo "Removing previous data"
  #kubectl exec -it sitewhere-backup-zk-pod-$1 rm -rf /var/lib/zookeeper/data
  #kubectl exec -it sitewhere-backup-zk-pod-$1 rm -rf /var/lib/zookeeper/log
  
  echo "Restoring backup for Zookeeper instance $1 from $DEST_DIR"

  for f in $DEST_DIR/*; do
    if [[ -d $f ]]; then
      echo "Copying $f into the dataDir of Apache Zookeeper $1"
      kubectl cp $f sitewhere-backup-zk-pod-$1:/var/lib/zookeeper
    fi
  done

  echo "Restoring backup for Zookeeper instance $1 from $DEST_DIR: DONE"
}

#
# Remove Dummy Pods
# arg: 
#    $1: Replica Number
#
function removeDummyPods() {
  echo "Remove Pods for Mounting Zookeeper PVC"

  kubectl delete -f $SW_K8S_HOME/sitewhere-zk-backup-pod.yaml

  for (( r=0; r < $1; r++ ))
  do
    kubectl wait pod/sitewhere-backup-zk-pod-$r --for=delete
  done

  echo "Remove Pods for Mounting Zookeeper PVC: DONE"
}

function restore_zookeeper () {
  local backup_dir replicas

  if [[ $# != 2 ]]; then
    echo "Usage: restore-zookeeper.sh <BACKUP_DIR> <REPLICAS>" >&2
    echo "" >&2
    echo "This script restores a backup of SiteWhere 2.0 Apache Zookeeper" >&2
    echo "running on a Kubernetes cluster from and backup directory." >&2
    return 1
  fi

  backup_dir="$1"
  replicas="$2"

  if [ ! -d "$backup_dir" ]; then
    echo "Backup directory $backup_dir does not exist!" >&2
    return 2
  fi
  if [[ $replicas =~ ^[\-0-9]+$ ]] && (( replicas > -5)); then
    echo "Using Apache Zookeeper Replicas: $replicas"
  else
    echo "<REPLICA> is not a number or is <= 0"
    return 3
  fi

  echo "Restoring Apache Zookeeper dataDir from $backup_dir"
  
  createDummyPods $replicas

  for (( r=0; r < $replicas; r++ ))
  do
    restorZookeeperDataDir $r $backup_dir
  done

  removeDummyPods $replicas
  
  echo "Restoring Apache Zookeeper dataDir from $backup_dir: DONE"
  return 0
}

restore_zookeeper $@