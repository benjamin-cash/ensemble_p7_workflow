#!/bin/bash

# Ensure necessary modules are loaded
module load nco/4.9.3

# Placeholder environment variable for testing
CYLC_RUN_ROOT_DIR="/scratch/02441/bcash/FV3_CYLC/ensemble-p7"
CYLC_POST_ROOT_DIR="/scratch/02441/bcash/FV3_CYLC/ensemble-p7/post"
CYLC_TASK_PARAM_ldate="2011070100"
CYLC_TASK_PARAM_mem="mem000"

RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate/$CYLC_TASK_PARAM_mem
POSTDIR=$CYLC_POST_ROOT_DIR/$CYLC_TASK_PARAM_ldate/$CYLC_TASK_PARAM_mem
MEMBER=$CYLC_TASK_PARAM_mem

if ! [[ -d $POSTDIR ]]; then
        mkdir -p $POSTDIR
fi

cd $RUNDIR
FILE_LIST=`ls -1 sfcf*nc`
VARIABLE_LIST="tmpsfc"

for fname in ${FILE_LIST[@]}; do
        for vname in ${VARIABLE_LIST[@]}; do
                echo $CYLC_TASK_PARAM_ldate.$CYLC_TASK_PARAM_mem.$vname.$fname
        ncks -v $vname $fname $POSTDIR/$CYLC_TASK_PARAM_ldate.$CYLC_TASK_PARAM_mem.$vname.$fname
        done
done

