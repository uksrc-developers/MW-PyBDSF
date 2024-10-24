#!/bin/bash

## This file is the batch script for concat-ing the PyBDSF outcomes on a slurm cluster.

####################
## Batching code
####################

## This batch set up runs this task on all nodes, using all 26 CPUs (and allocates roughly
## all the memory per node). The output files are named by default to <jobname>_<jobID>
## but the user can change this.

#SBATCH --job-name=PyBDSFUnbatch        ##  Job Name
#SBATCH --nodes=8                       ##  Number of nodes to run tasks over
#SBATCH --ntasks-per-node=26            ##  Requests all CPUs on node
#SBATCH --cpus-per-task=1               ##  Request one task per CPU
##SBATCH --mem=40Gb                      ##  Memory

#SBATCH --error=logs/%x_%j.err          ##  Error file
#SBATCH --output=logs/%x_%j.out         ##  Log file

####################


####################
## Paths and arguments
####################

DIR_TO_PROCESS=$1                       ##  Sets the input as the directory to process
MOSAIC_PATH=$2                          ##  Sets the second input as the mosaic path for the binding
SINGULARITY_PATH=$3                     ##  Path to the singularity container
SCRIPT_PATH=$4                          ##  Path to the scripts

####################


####################
## Functions
####################

Help()
{
    ## Prints out the help and info below.

    cat << EOF
    
    This script runs the un-batching of PyBDSF through the PyBDSF Singularity 
    container on a Slurm cluster. It is used in conjunction with 
    Run_PyBDSF_Sing.sh. Ideally the two scripts must be in the same folder 
    to run. It outputs error and output files to logs/<jobname>_<jobID>. As
    part of this script the apropriate folders to record the logging are 
    created. The user may change the jobname and output, if they do so they 
    are required to change the folder names as needed in the script; the 
    default is logs/PyBDSFUnbatch_{job_id}. 

    The options for this function are:

    -h:         Prints this help and info. 


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

mkdir ConcatCats

cd ConcatCats

#mkdir logs

#echo "${PYBDSF_DIR}" "${DIR_TO_PROCESS}"

echo "Running Unbatching of PyBDSF"

## Runs the concat catalogues script from the script folder through the singularity container

singularity run --bind "${DIR_TO_PROCESS}","${MOSAIC_PATH}","${SCRIPT_PATH}" "${SINGULARITY_PATH}" "${SCRIPT_PATH}concat-mosaic-cats.py" --mosdirectories="${DIR_TO_PROCESS}*"

####################