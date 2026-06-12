#!/bin/bash
#
# A demo/template/cheatsheet Slurm batch script, showing the most important
# options and their default values on Pelle.
#
# All these options can also be given on the command line, taking precedence
# over what is given in the script. They are also valid as options to `srun`,
# `salloc` and---on Pelle---`interactive`.
#
#######################
#  Mandatory options  #
#######################
#
#    -a <id>, --account=<id>, no default
#SBATCH -A staff
#
###################################
#  Resources: time, memory, CPUs  #
###################################
#
#    -t <time>, --time=<time>, default 1 minute
# All of these are commented out, so this script gets the default.
##SBATCH -t 1:5       # 1 minute and 5 seconds, will be rounded up to 2 minutes
##SBATCH -t 60        # 60 minutes
##SBATCH -t 1:0:0     # 1 hour (and 0 minutes and 0 seconds)
##SBATCH -t 0-1       # 0 days and 1 hour
#
#    -c <count>, --cpus-per-task=<count>, default 1 (becomes 2 threads with SMT)
# On the default pelle partition we have processors with SMT enabled, 2 threads
# (virtual CPUs) per core. The number called for will then be rounded up to
# even, i.e. whole cores.
#SBATCH -c 1   # this script explicitly calls for 1 to demonstrate that we get 2 threads anyway
#
#    -n <count>, --ntasks=<count>, default 1
# The number of separate tasks, e.g. MPI ranks or independent tasks. Can be
# scheduled on separate nodes.
##SBATCH -n 1
#
#    --mem=<size>[unit], default unit is Mebibytes
# Memory can be requested in mutually exclusive ways. Default is 6000 per cpu
# (on the pelle partition).
#SBATCH --mem=1             # 1 Mebibytes total, this script does not need much
##SBATCH --mem-per-cpu=10G  # 10 Gibibytes per cpu
#
################
#  Partitions  #
################
#
#    -p <names>, --partition=<names>, default pelle
# Mandatory on e.g. Dardel.
##SBATCH -p haswell        # to use the older nodes
##SBATCH -p fat            # to use the fat nodes, when 768 GiB per node is not enough
##SBATCH -p pelle,haswell  # run where the job can *start* the earliest (order doesn't matter)
#
####################
#  Output options  #
####################
#
#    -o <filename_pattern>, --output=<filename_pattern>, default slurm-%j.out
# Defines the name of the output file into which the standard output of this
# script gets written. DANGER: if you specify something without %j, running the
# same job multiple times will overwrite previous output files.
##SBATCH -o output/slurm-%j.out   # just putting the output in a subdirectory
#SBATCH -o output/%x_%j.out       # naming the files by job name in addition to job id
##SBATCH -o %u/%x_%j.out          # separate output directories per user
##SBATCH -o %x/%u_%j.out          # separate output directories per job name, filenames prefixed with usernames
#
#    -e <filename_pattern>, --error=<filename_pattern>, default not set
# Puts error messages in a separate file instead of in the same file as normal
# output. Highly recommended.
#SBATCH -e output/%x_%j.err       # naming the files by job name in addition to job id

 
##################################################################################
#  End of Slurm options                                                          #
#  Below is the script that will be executed on the compute nodes. In a typical  #
#  job script this will output some log/debug info, load needed modules, launch  #
#  the computational tasks.                                                      #
##################################################################################

# Writing the submitted script to a file, highly recommended for reproducibility!
# These variants create the same filename structures as suggested for output above.
#sacct --batch -j $SLURM_JOB_ID > "output/slurm_$SLURM_JOB_ID.script"
scontrol write batch_script $SLURM_JOB_ID "output/${SLURM_JOB_NAME}_$SLURM_JOB_ID.script"
#sacct --batch -j $SLURM_JOB_ID > "$USER/${SLURM_JOB_NAME}_$SLURM_JOB_ID.script"
#sacct --batch -j $SLURM_JOB_ID > "$SLURM_JOB_NAME/${USER}_$SLURM_JOB_ID.script"

# Printing some info that confirms what resources we got, can be useful for debugging
# Tip: run this script with bash instead of sbatch to check e.g. the login node
# or your interactive allocation
echo "This job ran on:"
echo -n "    "
/usr/bin/hostname
echo -n "    "
date +%F
echo -n "   "
uptime
echo -n "Number of CPUs: "
nproc
free -h
ulimit -a
echo ""

# We do not need any modules for this example
#module load

# Actual computational task would go here
alhjasdflkjhaslkdjfkashd  # Produces an error to check/demonstrate error redirection
