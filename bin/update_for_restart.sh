#!/usr/bin/bash -f

RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate
MEMBER=$CYLC_TASK_PARAM_mem
CYCLE=$CYLC_TASK_CYCLE_POINT
NHOURS=$(( (CYCLE+1)*CYLC_NHOURS ))

# Change to run directory 
cd $RUNDIR/$MEMBER

# Preserve current input file
cp -r INPUT INPUT.$CYCLE
cp input.nml INPUT.$CYCLE/.
cp nems.configure INPUT.$CYCLE/.
cp model_configure INPUT.$CYCLE/.

# Move restart information into INPUT
cp RESTART/* INPUT/.

# Update model files for restart
cp input.nml_restart input.nml
cp nems.configure_restart nems.configure
cp model_configure_restart model_configure
sed -i "s/NHOURS/$NHOURS/g" model_configure
