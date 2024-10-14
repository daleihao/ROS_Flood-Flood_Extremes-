#!/bin/bash
#SBATCH -N 1
#SBATCH -t 12:00:00
#SBATCH --time-min=12:00:00
#SBATCH -q regular
#SBATCH --account=E3SM

cd /compyfs/haod776/e3sm_scratch/ROS/future_simulations
module load matlab
matlab  -nodisplay -r "run get_future_data_temporal_2.m"
