#!/bin/bash

RUNDIR=$CYLC_RUN_ROOT_DIR/$CYLC_TASK_PARAM_ldate
MEMBER=$CYLC_TASK_PARAM_mem
NHOURS=$CYLC_NHOURS
MNUM=10#${MEMBER:3:3}
CDATE=${CYLC_TASK_PARAM_ldate:0:8}
ISEED_CA=$(( (CDATE*1000 + MNUM*10 + 4) % 2147483647 ))

echo "What is NHOURS?: $NHOURS"
echo "What is MNUM?: $MNUM"
echo "What is CDATE?: $CDATE"
echo "What is ISEED_CA?: $ISEED_CA"

YYYYs=${CYLC_TASK_PARAM_ldate:0:4}
MMs=${CYLC_TASK_PARAM_ldate:4:2}
DDs=${CYLC_TASK_PARAM_ldate:6:2}

ENDDATE=$(date +%Y%m%d00 -ud "$YYYYs$MMs$DDs + $NHOURS hours")
YYYYe=${ENDDATE:0:4}
MMe=${ENDDATE:4:2}
DDe=${ENDDATE:6:2}

DATEP1=$(date +%Y%m%d00 -ud "$YYYYs$MMs$DDs + 24 hours")
YYYYp1=${ENDDATE:0:4}
MMp1=${ENDDATE:4:2}
DDp1=${ENDDATE:6:2}

cd $RUNDIR/$MEMBER

#Make necessary replacements for specific case
echo "Edit diag_table"
sed -i "s/YYYYs/$YYYYs/g" diag_table
sed -i "s/MMs/$MMs/g" diag_table
sed -i "s/DDs/$DDs/g" diag_table
#
#echo "Edit input.nml"
sed -i "s/ISEED_CA/$ISEED_CA/g" input.nml
#
echo "Edit model_configure"
sed -i "s/YYYYs/$YYYYs/g" model_configure
sed -i "s/MMs/$MMs/g" model_configure
sed -i "s/DDs/$DDs/g" model_configure
sed -i "s/NHOURS/$NHOURS/g" model_configure
#
echo "Edit model_configure_restart"
sed -i "s/YYYYs/$YYYYs/g" model_configure_restart
sed -i "s/MMs/$MMs/g" model_configure_restart
sed -i "s/DDs/$DDs/g" model_configure_restart

if [[ -e ice_in ]]; then
        echo "Edit ice_in"
        sed -i "s/YYYYs/$YYYYs/g" ice_in
#       sed -i "s/MMs/$MMs/g" ice_in
#       sed -i "s/DDs/$DDs/g" ice_in
fi
#
if [[ -e ww3_multi.inp ]]; then
        echo "Edit ww3_multi.inp"
        sed -i "s/YYYYs/$YYYYs/g" ww3_multi.inp
        sed -i "s/MMs/$MMs/g" ww3_multi.inp
        sed -i "s/DDs/$DDs/g" ww3_multi.inp
#
        sed -i "s/YYYYe/$YYYYe/g" ww3_multi.inp
        sed -i "s/MMe/$MMe/g" ww3_multi.inp
        sed -i "s/DDe/$DDe/g" ww3_multi.inp
#
        sed -i "s/YYYYp1/$YYYYp1/g" ww3_multi.inp
        sed -i "s/MMp1/$MMp1/g" ww3_multi.inp
        sed -i "s/DDp1/$DDp1/g" ww3_multi.inp
fi
#
