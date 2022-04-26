#!/bin/bash

INPUT_DATA_ROOT_DIR=$CYLC_INPUT_ROOT_DIR/$SUBDIR
INPUT_DATA_CASE_DIR=$INPUT_DATA_ROOT_DIR/$CYLC_TASK_PARAM_ldate
RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate
MEMBER=$CYLC_TASK_PARAM_mem
USERID=$CYLC_USERID

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
list_of_common_input_files=$INPUT_DATA_CASE_DIR/common_file_list.txt
list_of_perturbed_input_files=$INPUT_DATA_CASE_DIR/perturbed_file_list.txt

scp ${USERID}@ranch:${list_of_common_input_files} ${SUBDIR}.common_file_list.txt
scp ${USERID}@ranch:${list_of_perturbed_input_files} ${SUBDIR}.perturbed_file_list.txt

while IFS= read -r fname; do
  echo $INPUT_DATA_CASE_DIR/$fname
  scp ${USERID}@ranch:$INPUT_DATA_CASE_DIR/$fname $RUNDIR/$MEMBER/$fname
done < ${SUBDIR}.common_file_list.txt

while IFS= read -r fname; do
  echo $INPUT_DATA_CASE_DIR/$MEMBER/$fname
  scp ${USERID}@ranch:$INPUT_DATA_CASE_DIR/$MEMBER/$fname $RUNDIR/$MEMBER/INPUT/$fname
done < ${SUBDIR}.perturbed_file_list.txt

