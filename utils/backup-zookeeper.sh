#/bin/bash
# Copyright 2019, SiteWhere LLC.
# This script creates a backup of SiteWhere 2.2 Apache Zookeeper
# dataDir running on a Kubernetes cluster
# usage: backup-zookeeper.sh <BACKUP_DEST_DIR> <REPLICAS>

#
# Create a back up Apache Zookeeper dataDir instance
#
backupZookeeper(){  
  local DEST_DIR=$2/$1
  echo "Creating backup for Zookeeper instance $1 to $DEST_DIR"
  kubectl cp sitewhere-zookeeper-$1:/var/lib/zookeeper/ $DEST_DIR
  echo "Creating backup for Zookeeper instance $1 to $DEST_DIR: DONE"
}


function backup_zookeeper () {
  local backup_dir backup_dir_timestamp replicas

  if [[ $# != 2 ]]; then
    echo "Usage: backup-zookeeper.sh <BACKUP_DEST_DIR> <REPLICAS>" >&2
    echo "" >&2
    echo "This script creates a backup of SiteWhere 2.2 Apache Zookeeper" >&2
    echo "dataDir running on a Kubernetes cluster" >&2
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

  case "$backup_dir" in
  */)
      backup_dir_timestamp=$backup_dir$(date +%Y%m%d%H%M%S)
      ;;
  *)
      backup_dir_timestamp=$backup_dir/$(date +%Y%m%d%H%M%S)
      ;;
  esac
  
  echo "Creating Apache Zookeeper Backup to $backup_dir_timestamp"

  for (( r=0; r < $replicas; r++ ))
  do  
    backupZookeeper $r $backup_dir_timestamp
  done

  echo "Creating Apache Zookeeper Backup to $backup_dir_timestamp: DONE"
}

backup_zookeeper $@