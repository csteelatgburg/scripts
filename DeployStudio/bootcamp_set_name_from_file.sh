#!/bin/sh
## This script is based on the ntfsrestore.sh script that comes with DeployStudio
## It is designed to be used in conjuction with the bootcamp_save_name_to_file.sh script
## This script should run after a Windows image has been restored
## The script expects the device ID of the Bootcamp partition as an argument
## This script relies on the DeployStudio scripts which should have been copied
## from the server using the copy_tools_local.sh script.

## Chuck Steel

SCRIPT_NAME=`basename "${0}"`
VERSION=1.0
BC_NAME=`cat /etc/deploystudio/bootcampname`


echo "Running ${SCRIPT_NAME} v${VERSION}"


TOOLS_FOLDER="/etc/deploystudio/ds_scripts"

DISK_ID=`basename "${1}" | sed s/disk// | awk -Fs '{ print $1 }'`
PARTITION_ID=`basename "${1}" | sed s/disk// | awk -Fs '{ print $2 }'`

DEVICE=/dev/disk${DISK_ID}
if [ ! -e "${DEVICE}" ]
then
  echo "Unknown device ${DEVICE}, script aborted."
  echo "RuntimeAbortScript"
  exit 1
fi
RAW_DEVICE=/dev/rdisk${DISK_ID}

NTFS_DEVICE=${DEVICE}s${PARTITION_ID}
if [ ! -e "${NTFS_DEVICE}" ]
then
  echo "Unknown device ${NTFS_DEVICE}, script aborted."
  echo "RuntimeAbortScript"
  exit 1
fi

# unmount device
"${TOOLS_FOLDER}"/safeunmountvolume.sh "${NTFS_DEVICE}"


# sysprep file lookup
SYSPREP_FILE=""
"${TOOLS_FOLDER}"/ntfscat -f "${NTFS_DEVICE}" /SysPrep/SYSPREP.INF > /tmp/SYSPREP.INF
if [ ${?} -eq 0 ]
then
  SYSPREP_FILE=/SysPrep/SYSPREP.INF
else
  "${TOOLS_FOLDER}"/ntfscat -f "${NTFS_DEVICE}" /windows/panther/unattend.XML > /tmp/unattend.xml
  if [ ${?} -eq 0 ]
  then
    SYSPREP_FILE=/windows/panther/unattend.XML
  else
    "${TOOLS_FOLDER}"/ntfscat -f "${NTFS_DEVICE}" /windows/system32/sysprep/unattend.xml > /tmp/unattend.xml
    if [ ${?} -eq 0 ]
    then
      SYSPREP_FILE=/windows/system32/sysprep/unattend.xml
    fi
  fi
fi

# update sysprep's file ComputerName attribute
if [ -n "${SYSPREP_FILE}" ] && [ -n "${BC_NAME}" ]
then
  if [ `basename "${SYSPREP_FILE}"` = "SYSPREP.INF" ]
  then
    INF_SYSPREP_COMPUTERNAME=`grep -i -m 1 "ComputerName=" /tmp/SYSPREP.INF | tr -d " \n\r" | sed s/'*'/'\\\*'/`
    if [ -n "${INF_SYSPREP_COMPUTERNAME}" ]
    then
      sed s%"${INF_SYSPREP_COMPUTERNAME}"%"ComputerName=${BC_NAME}"% /tmp/SYSPREP.INF > /tmp/SYSPREP.INF.NEW
      echo "-> updating computer name in ${SYSPREP_FILE} to ${BC_NAME}..."
      "${TOOLS_FOLDER}"/ntfscp -f "${NTFS_DEVICE}" /tmp/SYSPREP.INF.NEW "${SYSPREP_FILE}"
      if [ ${?} -ne 0 ]
      then
        echo "RuntimeAbortScript"
        exit 1
      fi
    fi
  else
    XML_SYSPREP_COMPUTERNAME=`grep -i -m 1 "<ComputerName>.*</ComputerName>" /tmp/unattend.xml | tr -d " \n\r" | sed s/'*'/'\\\*'/ | awk -F"ComputerName" '{ print $2 }'`
    if [ -n "${XML_SYSPREP_COMPUTERNAME}" ]
    then
      sed s%"${XML_SYSPREP_COMPUTERNAME}"%">${BC_NAME}</"% /tmp/unattend.xml > /tmp/unattend.xml.NEW
      echo "-> updating computer name in ${SYSPREP_FILE} to ${BC_NAME}..."
      "${TOOLS_FOLDER}"/ntfscp -f "${NTFS_DEVICE}" /tmp/unattend.xml.NEW "${SYSPREP_FILE}"
      if [ ${?} -ne 0 ]
      then
        echo "RuntimeAbortScript"
        exit 1
      fi
    fi
  fi
fi

# remount device
echo "-> mounting device ${NTFS_DEVICE}..."
diskutil mountDisk "${NTFS_DEVICE}"

exit 0
