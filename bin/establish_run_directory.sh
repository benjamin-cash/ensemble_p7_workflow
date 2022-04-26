#!/bin/bash

RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate
MEMBER=$CYLC_TASK_PARAM_mem

echo "path variables"
echo $RUNDIR

SUBDIRS=("INPUT" "MOM6_OUTPUT" "MOM6_RESTART" "RESTART" "history")
echo $SUBDIRS

for SUBDIR in ${SUBDIRS[@]}; do
	echo "WTF?"
	echo $RUNDIR/$MEMBER/$SUBDIR 
 if ! [ -e $RUNDIR/$MEMBER/SUBDIR ]; then
        mkdir -p $RUNDIR/$MEMBER/$SUBDIR
 fi
done


