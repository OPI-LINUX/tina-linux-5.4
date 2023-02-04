#!/bin/bash

function usage()
{
  echo "$0 <config_dir> <kernel_dir>"
  echo "  Copy source files and configuration into a kernel tree."
  echo "  The configuration and list of files to copy is found in <config_dir>."
  echo "  The target kernel tree is <kernel_dir>."
  echo "  Before running this script, we recommend that you clean out the old"
  echo "  destination directories in <kernel_dir>."
}  

if [ "$#" -lt 2 ]; then
  echo "Not enough arguments"
  usage
  exit 1
fi

CONFIG=$1
DEST=$2

if [ ! -f "$CONFIG/copy_items.sh" ]; then
  echo "$CONFIG does not look like a config directory.  copy_items.sh is missing."
  usage
  exit 1
fi

if [ ! -f "$DEST/Kconfig" ] ; then
  echo "$DEST does not look like a kernel directory."
  usage
  exit 1
fi

function copyfile()
{
  src=$1
  dest="$DEST/$2"

  mkdir -p `dirname $dest`
  echo copy $src to $dest
  cp $src $dest
  chmod u+w $dest
}

source "$CONFIG/copy_items.sh"
