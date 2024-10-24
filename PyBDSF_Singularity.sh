#!/bin/bash

## This file is the batch script for PyBDSF on a slurm cluster.

####################
## Batching code
####################

## This batch set up runs one job on one node using all 26 CPUs. To change 
## the number of CPUs used change ntasks; to change/allocate memory then 
## change mem. The output files are named by default to <jobname>_<jobID>
## but the user can change this.

#SBATCH --job-name=PyBDSFSingularity    ##  Job Name
#SBATCH --nodes=1                       ##  Number of nodes to run tasks over
#SBATCH --ntasks=26                     ##  Requests all CPUs on node
#SBATCH --cpus-per-task=1               ##  Number of CPUs per task
#SBATCH --exclusive                     ##  Allocated nodes not shared with other jobs
##SBATCH --mem-40g                      ##  Memory per node

#SBATCH --error=logs/%x_%j.err          ##  Error file
#SBATCH --output=logs/%x_%j.out         ##  Log file

####################


####################
## Paths and arguments
####################

DIR_TO_PROCESS=$1                       ##  Sets the input as the directory to process
MOSAIC_PATH=$2                          ##  Sets the second input as the mosaic path for the binding
SINGULARITY_PATH=$3                     ##  Path to the singularity container

####################


####################
## Functions
####################

Help()
{
    ## Prints out the help and info below.

    cat << EOF
    
    This script runs the batching of the PyBDSF Singularity container 
    on a Slurm cluster. It is used in conjunction with Run_PyBDSF_Sing.sh.
    Ideally the two scripts must be in the same folder to run. It outputs
    error and output files to logs/<jobname>_<jobID>, therefore the user
    requires a logs directory in the current directory they are running
    this script from, and they may change the jobname; the default is 
    PyBDSFSingularity. 

    The options for this function are:

    -h:         Prints this help and info. 

                             ** NOTE ** 
    Please check the name of the Singularity container and the mosaics in the
    script; locations are indicated.

EOF
}
####################


####################
## Options
####################

while getopts ":h" option; do

    case ${option} in
         
        h) # Pulls up the help and info
            Help
            exit 0
            ;;
        
        \?) # Invaild input
            echo "Invalid option see -h (help) for help and information."
            exit 0
            ;;
    esac
done
        
####################


####################
## Main code
####################

## Check to make sure the Directory exists and if not echo and exit

echo "Checking directory and symlinks exist for Mosaic $(basename ${DIR_TO_PROCESS})"

if [ ! -d "${DIR_TO_PROCESS}" ]; then

    echo "Directory does not exist: ${DIR_TO_PROCESS}"
    echo "Need to create directory and symlinks for ${DIR_TO_PROCESS}"
    exit 1

fi

cd "${DIR_TO_PROCESS}"      ## Move to the folder with the .sif and the .fits

#echo "${PYBDSF_DIR}" "${DIR_TO_PROCESS}"

echo "Running PyBDSF Singularity on Mosaic $(basename ${DIR_TO_PROCESS})"

## Runs PyBDSF in the Singularity container without actually going into it - check name of container and mosaics

singularity exec --bind "${DIR_TO_PROCESS%/}":"${DIR_TO_PROCESS%/}","${MOSAIC_PATH}":"${MOSAIC_PATH}"  "${SINGULARITY_PATH}" sourcefind.py --intfile mosaic-blanked.fits 

####################
