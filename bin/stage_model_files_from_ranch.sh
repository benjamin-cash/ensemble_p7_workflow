#!/bin/bash

INPUT_DATA_ROOT_DIR=$CYLC_INPUT_ROOT_DIR/$SUBDIR
RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate
MEMBER=$CYLC_TASK_PARAM_mem
USERID=$CYLC_USERID
#INPUT_DATA_ROOT_DIR=/stornext/ranch_01/ranch/projects/TG-EES200015/FV3
#RUNDIR=/scratch/02441/bcash/FV3_CYLC/ensemble-p7/ranch_test/2011070100
#MEMBER=mem001
#USERID=bcash
echo "path variables"
echo $INPUT_DATA_ROOT_DIR
echo $RUNDIR
echo $MEMBER
echo $USERID

# Check for model run directory
if ! [ -e $RUNDIR/$MEMBER/INPUT ]; then
        mkdir -p $RUNDIR/$MEMBER/INPUT
fi

cd $RUNDIR/$MEMBER
list_of_input_files=$INPUT_DATA_ROOT_DIR/file_list.txt
scp ${USERID}@ranch:$INPUT_DATA_ROOT_DIR/file_list.txt ${SUBDIR}.file_list.txt

while IFS= read -r fname; do
  scp ${USERID}@ranch:$INPUT_DATA_ROOT_DIR/$fname $RUNDIR/$MEMBER/$fname
done < ${SUBDIR}.file_list.txt

