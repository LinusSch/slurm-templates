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
#########################################
#  Basic resources: time, memory, CPUs  #
#########################################
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
#####################################################
#  More on resources: partitions, GPUs, full nodes  #
#####################################################
#
#    -p <names>, --partition=<names>, default pelle
##SBATCH -p haswell                # to use these older nodes, about half of which have a T4 gpu
##SBATCH -p fat                    # to use the fat nodes, when 768 GiB is not enough
##SBATCH -p gpu                    # to use the gpu nodes, for H100 or L40s gpus
##SBATCH -p pelle,haswell,fat,gpu  # run whereever the job can start the earliest (order doesn't matter)
#
#    -N <count>, --nodes=<count>, default not set
# There are more versions of this but they are not relevant on Pelle, which
# doesn't have very many nodes.
##SBATCH -N 1    # Calls for a number of whole nodes instead of an amount of resources
#
#    --mem-per-gpu=<size>[unit], default unit is Mebibytes
##SBATCH --mem-per-gpu=20G  # 20 Gibibytes per gpu

 
# We do not need any modules for this example
#module load

# Printing some info that confirms what resources we got, can be useful for debugging
# Tip: run this script with bash instead of sbatch to check e.g. the login node
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
