#!/bin/bash

INPUT_DATA_ROOT_DIR=$CYLC_INPUT_ROOT_DIR/$SUBDIR
RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate
MEMBER=$CYLC_TASK_PARAM_mem

echo "path variables"
echo $INPUT_DATA_ROOT_DIR
echo $RUNDIR
echo $MEMBER

# Check for model run directory
if ! [ -e $RUNDIR/$MEMBER/INPUT ]; then
        mkdir -p $RUNDIR/$MEMBER/INPUT
fi

list_of_input_files=$INPUT_DATA_ROOT_DIR/file_list.txt

while IFS= read -r fname; do
  ln -sf $INPUT_DATA_ROOT_DIR/$fname $RUNDIR/$MEMBER/$fname
done < $list_of_input_files

