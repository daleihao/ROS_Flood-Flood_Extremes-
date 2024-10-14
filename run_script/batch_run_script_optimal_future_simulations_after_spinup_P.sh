#!/bin/bash
#SBATCH -N 1
#SBATCH -t 24:00:00
#SBATCH --time-min=24:00:00
#SBATCH -q regular
#SBATCH --account=E3SM

for deltaT in {0..5}
do

export NameTag=Optimal_future_${deltaT}K_P_after_spinup
export DateTag=$(date '+%Y%m%d')

echo $deltaT
############################################
############################################
############################################
######## shared setting


fover=0.1
fdrai=1.5
Tsnow=2   # optimal Tsnow value
tfrz=2    # optimal tfrz value
tfrz=`echo ${tfrz} + 273.15 | bc`



############################################
############################################
############################################
########### 2017 CA
############################################
############################################
############################################
export domainPath=/compyfs/haod776/e3sm_scratch/ROS/surface_data/
export domainFile=domain_ROS_2017_c230130.nc
export surfdataFile=surfdata_ROS_2017_c230131.nc
export initPath=/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/ROS_2017_CA_FLOOD_Optimal_future_${deltaT}K_P_spinup_20240909/run/
export initFile=ROS_2017_CA_FLOOD_Optimal_future_${deltaT}K_P_spinup_20240909.elm.r.2017-01-01-00000.nc
# TOP
export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy
export CASE_NAME=ROS_2017_CA_FLOOD_${NameTag}_${DateTag}

export e3sm_simulations_dir=/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations
export case_dir=${e3sm_simulations_dir}/${CASE_NAME}
export case_scripts_dir=${case_dir}/case_scripts
export case_build_dir=${case_dir}/build
export case_run_dir=${case_dir}/run

if [ -d "$case_dir" ]; then
  # Take action if $DIR exists. #
  # echo "Delete the old folder"
  rm -rf $case_dir
fi


cd /qfs/people/haod776/E3SM_couple/cime/scripts
./create_newcase --compset ${COMPSET} --res ${RES} --case ${CASE_NAME} --script-root ${case_scripts_dir}  -compiler ${COMPILER} -mach ${MACH} -project ESMD
cd ${case_scripts_dir}

./xmlchange LND_DOMAIN_FILE=${domainFile}
./xmlchange ATM_DOMAIN_FILE=${domainFile}
./xmlchange LND_DOMAIN_PATH=${domainPath}
./xmlchange ATM_DOMAIN_PATH=${domainPath}
./xmlchange NTASKS=256,STOP_N=2,STOP_OPTION=nmonths,JOB_WALLCLOCK_TIME="01:00:00",RUN_STARTDATE="2017-01-01",REST_N=1,REST_OPTION=nyears,RESUBMIT=0
./xmlchange DATM_MODE=CLMMOSARTTEST,DATM_CLMNCEP_YR_START='2017',DATM_CLMNCEP_YR_END='2017'

./xmlchange EXEROOT=${case_build_dir}
./xmlchange RUNDIR=${case_run_dir}

cat >> user_nl_elm << EOF
 hist_nhtfrq = -1
 hist_mfilt  = 24
 !hist_empty_htapes = .true.
  hist_fincl1 = 'FSDS','FLDS','FSA','FSR','FIRE','FSH','EFLX_LH_TOT','TSOI','TSOI_10CM','SOILWATER_10CM','H2OSOI','TV','TG','TSA','FPSN','FSM','TBOT','FSNO','SNOWDP','H2OSNO','SNORDSL','QSNOMELT','QRUNOFF','QOVER','QSOIL','QSNWCPICE','SNOW','RAIN','QDRAI','QTOPSOIL','QH2OSFC','QDRAI_PERCH','QINFL','H2OSFC','FH2OSFC', 'FH2OSFC_EFF','QVEGE','QVEGT','SOILLIQ','SOILICE'
 

 fsnowoptics = '/compyfs/inputdata/lnd/clm2/snicardata/snicar_optics_5bnd_mam_c211006.nc'
 fsurdat = '${domainPath}${surfdataFile}'
 finidat = '${initPath}${initFile}'
  
 use_top_solar_rad = .true.
 use_snicar_ad = .true.
 use_snicar_frc = .true.
 snow_shape = 'sphere'
 use_dust_snow_internal_mixing = .false.
 snicar_atm_type = 'mid-latitude_winter'

 tfrz_adj = ${tfrz}
 fover_adj = ${fover}
 fdrai_adj = ${fdrai}
 
EOF

cat >> user_nl_datm << EOF
 Tsnow_adj = ${Tsnow}
EOF

./case.setup
./case.build

cp ./CaseDocs/datm.streams.txt.CLMMOSARTTEST ./user_datm.streams.txt.CLMMOSARTTEST
chmod +rw ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@/compyfs/inputdata/share/domains/domain.clm@/compyfs/inputdata/atm/datm7/atm_forcing.datm7.L15.1_16d.v1.c032923@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@domain.lnd.nldas2_0224x0464_c110415.nc@domain_L15_c230330.nc@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@/compyfs/inputdata/atm/datm7/NLDAS@/compyfs/haod776/e3sm_scratch/ROS/forcing_data/atm_forcing.L15.CA.${deltaT}degree_P_2yrs@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@clmforc.nldas@elmforc.L15.CA.${deltaT}degree@" ./user_datm.streams.txt.CLMMOSARTTEST
sed -i '/ZBOT/d' ./user_datm.streams.txt.CLMMOSARTTEST

./case.submit



############################################
############################################
############################################
######## shared setting
fover=0.1
fdrai=4.5
Tsnow=0   # optimal Tsnow value
tfrz=0.5   # optimal tfrz value
tfrz=`echo ${tfrz} + 273.15 | bc`


############################################
############################################
############################################
########### 1996 PN
############################################
############################################
############################################
export domainPath=/compyfs/haod776/e3sm_scratch/ROS/surface_data/
export domainFile=domain_ROS_1996_PN_c230427.nc
export surfdataFile=surfdata_ROS_1996_PN_c230428_v2.nc
export initPath=/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/ROS_1996_PN_FLOOD_Optimal_future_${deltaT}K_P_spinup_20240909/run/
export initFile=ROS_1996_PN_FLOOD_Optimal_future_${deltaT}K_P_spinup_20240909.elm.r.1996-01-01-00000.nc
# TOP
export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy
export CASE_NAME=ROS_1996_PN_FLOOD_${NameTag}_${DateTag}

export e3sm_simulations_dir=/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations
export case_dir=${e3sm_simulations_dir}/${CASE_NAME}
export case_scripts_dir=${case_dir}/case_scripts
export case_build_dir=${case_dir}/build
export case_run_dir=${case_dir}/run

if [ -d "$case_dir" ]; then
  # Take action if $DIR exists. #
  echo "Delete the old folder"
  rm -rf $case_dir
fi


cd /qfs/people/haod776/E3SM_couple/cime/scripts
./create_newcase --compset ${COMPSET} --res ${RES} --case ${CASE_NAME} --script-root ${case_scripts_dir}  -compiler ${COMPILER} -mach ${MACH} -project ESMD
cd ${case_scripts_dir}

./xmlchange LND_DOMAIN_FILE=${domainFile}
./xmlchange ATM_DOMAIN_FILE=${domainFile}
./xmlchange LND_DOMAIN_PATH=${domainPath}
./xmlchange ATM_DOMAIN_PATH=${domainPath}
./xmlchange NTASKS=256,STOP_N=2,STOP_OPTION=nmonths,JOB_WALLCLOCK_TIME="01:00:00",RUN_STARTDATE="1996-01-01",REST_N=1,REST_OPTION=nyears,RESUBMIT=0
./xmlchange DATM_MODE=CLMMOSARTTEST,DATM_CLMNCEP_YR_START='1996',DATM_CLMNCEP_YR_END='1996'

./xmlchange EXEROOT=${case_build_dir}
./xmlchange RUNDIR=${case_run_dir}

cat >> user_nl_elm << EOF
 hist_nhtfrq = -1
 hist_mfilt  = 24
 !hist_empty_htapes = .true.
  hist_fincl1 = 'FSDS','FLDS','FSA','FSR','FIRE','FSH','EFLX_LH_TOT','TSOI','TSOI_10CM','SOILWATER_10CM','H2OSOI','TV','TG','TSA','FPSN','FSM','TBOT','FSNO','SNOWDP','H2OSNO','SNORDSL','QSNOMELT','QRUNOFF','QOVER','QSOIL','QSNWCPICE','SNOW','RAIN','QDRAI','QTOPSOIL','QH2OSFC','QDRAI_PERCH','QINFL','H2OSFC','FH2OSFC', 'FH2OSFC_EFF','QVEGE','QVEGT','SOILLIQ','SOILICE'
 

 fsnowoptics = '/compyfs/inputdata/lnd/clm2/snicardata/snicar_optics_5bnd_mam_c211006.nc'
 fsurdat = '${domainPath}${surfdataFile}'
 finidat = '${initPath}${initFile}'
  
 use_top_solar_rad = .true.
 use_snicar_ad = .true.
 use_snicar_frc = .true.
 snow_shape = 'sphere'
 use_dust_snow_internal_mixing = .false.
 snicar_atm_type = 'mid-latitude_winter'

 tfrz_adj = ${tfrz}
 fover_adj = ${fover}
 fdrai_adj = ${fdrai}
 
EOF

cat >> user_nl_datm << EOF
 Tsnow_adj = ${Tsnow}
EOF

./case.setup
./case.build

cp ./CaseDocs/datm.streams.txt.CLMMOSARTTEST ./user_datm.streams.txt.CLMMOSARTTEST
chmod +rw ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@/compyfs/inputdata/share/domains/domain.clm@/compyfs/haod776/e3sm_scratch/ROS/forcing_data/atm_forcing.L15.PN@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@domain.lnd.nldas2_0224x0464_c110415.nc@domain_domain.lnd.nldas.PN_c231005.nc@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@/compyfs/inputdata/atm/datm7/NLDAS@/compyfs/haod776/e3sm_scratch/ROS/forcing_data/atm_forcing.L15.PN.${deltaT}degree_P_2yrs@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@clmforc.nldas@elmforc.L15.PN.${deltaT}degree@" ./user_datm.streams.txt.CLMMOSARTTEST
sed -i '/ZBOT/d' ./user_datm.streams.txt.CLMMOSARTTEST

./case.submit


############################################
############################################
############################################
######## shared setting
fover=0.5
fdrai=2.5
Tsnow=2   # optimal Tsnow value
tfrz=-2   # optimal tfrz value
tfrz=`echo ${tfrz} + 273.15 | bc`


############################################
############################################
############################################
########### 1996 MA
############################################
############################################
############################################
export domainPath=/compyfs/haod776/e3sm_scratch/ROS/surface_data/
export domainFile=domain_ROS_1996_MA_c230427.nc
export surfdataFile=surfdata_ROS_1996_MA_c230428_v2.nc
export initPath=/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/ROS_1996_MA_FLOOD_Optimal_future_${deltaT}K_P_spinup_20240909/run/
export initFile=ROS_1996_MA_FLOOD_Optimal_future_${deltaT}K_P_spinup_20240909.elm.r.1996-01-01-00000.nc
# TOP
export RES=ELM_USRDAT
export COMPSET=IELMBC
export COMPILER=intel
export MACH=compy
export CASE_NAME=ROS_1996_MA_FLOOD_${NameTag}_${DateTag}

export e3sm_simulations_dir=/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations
export case_dir=${e3sm_simulations_dir}/${CASE_NAME}
export case_scripts_dir=${case_dir}/case_scripts
export case_build_dir=${case_dir}/build
export case_run_dir=${case_dir}/run

if [ -d "$case_dir" ]; then
  # Take action if $DIR exists. #
  rm -rf $case_dir
fi


cd /qfs/people/haod776/E3SM_couple/cime/scripts
./create_newcase --compset ${COMPSET} --res ${RES} --case ${CASE_NAME} --script-root ${case_scripts_dir}  -compiler ${COMPILER} -mach ${MACH} -project ESMD
cd ${case_scripts_dir}

./xmlchange LND_DOMAIN_FILE=${domainFile}
./xmlchange ATM_DOMAIN_FILE=${domainFile}
./xmlchange LND_DOMAIN_PATH=${domainPath}
./xmlchange ATM_DOMAIN_PATH=${domainPath}
./xmlchange NTASKS=256,STOP_N=2,STOP_OPTION=nmonths,JOB_WALLCLOCK_TIME="01:00:00",RUN_STARTDATE="1996-01-01",REST_N=1,REST_OPTION=nyears,RESUBMIT=0
./xmlchange DATM_MODE=CLMMOSARTTEST,DATM_CLMNCEP_YR_START='1996',DATM_CLMNCEP_YR_END='1996'

./xmlchange EXEROOT=${case_build_dir}
./xmlchange RUNDIR=${case_run_dir}

cat >> user_nl_elm << EOF
 hist_nhtfrq = -1
 hist_mfilt  = 24
 !hist_empty_htapes = .true.
  hist_fincl1 = 'FSDS','FLDS','FSA','FSR','FIRE','FSH','EFLX_LH_TOT','TSOI','TSOI_10CM','SOILWATER_10CM','H2OSOI','TV','TG','TSA','FPSN','FSM','TBOT','FSNO','SNOWDP','H2OSNO','SNORDSL','QSNOMELT','QRUNOFF','QOVER','QSOIL','QSNWCPICE','SNOW','RAIN','QDRAI','QTOPSOIL','QH2OSFC','QDRAI_PERCH','QINFL','H2OSFC','FH2OSFC', 'FH2OSFC_EFF','QVEGE','QVEGT','SOILLIQ','SOILICE'
 
 

 fsnowoptics = '/compyfs/inputdata/lnd/clm2/snicardata/snicar_optics_5bnd_mam_c211006.nc'
 fsurdat = '${domainPath}${surfdataFile}'
 finidat = '${initPath}${initFile}'
  
 use_top_solar_rad = .true.
 use_snicar_ad = .true.
 use_snicar_frc = .true.
 snow_shape = 'sphere'
 use_dust_snow_internal_mixing = .false.
 snicar_atm_type = 'mid-latitude_winter'

 tfrz_adj = ${tfrz}
 fover_adj = ${fover}
 fdrai_adj = ${fdrai}
 
EOF

cat >> user_nl_datm << EOF
 Tsnow_adj = ${Tsnow}
EOF

./case.setup
./case.build

cp ./CaseDocs/datm.streams.txt.CLMMOSARTTEST ./user_datm.streams.txt.CLMMOSARTTEST
chmod +rw ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@/compyfs/inputdata/share/domains/domain.clm@/compyfs/haod776/e3sm_scratch/ROS/forcing_data/atm_forcing.Daymet.MA@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@domain.lnd.nldas2_0224x0464_c110415.nc@domain_domain.lnd.nldas.MA_c231005.nc@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@/compyfs/inputdata/atm/datm7/NLDAS@/compyfs/haod776/e3sm_scratch/ROS/forcing_data/atm_forcing.Daymet.MA.${deltaT}degree_P_2yrs@" ./user_datm.streams.txt.CLMMOSARTTEST
perl -w -i -p -e "s@clmforc.nldas@elmforc.Daymet.MA.${deltaT}degree@" ./user_datm.streams.txt.CLMMOSARTTEST
sed -i '/ZBOT/d' ./user_datm.streams.txt.CLMMOSARTTEST

./case.submit


done
