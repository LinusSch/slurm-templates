#!/bin/bash
#
# A demo/template/cheatsheet Slurm batch script, showing how to use full nodes
# instead of a more granular set of resources.
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
###########################
#  Resources: full nodes  #
###########################
#
#    -N <count>, --nodes=<count>, default not set
# There are more versions of this but they are not relevant on Pelle, which
# doesn't have very many nodes.
##SBATCH -N 1    # Calls for a number of whole nodes instead of an amount of resources
#
################
#  Partitions  #
################
#
#    -p <names>, --partition=<names>, default pelle
##SBATCH -p haswell                # to use these older nodes, about half of which have a T4 gpu
##SBATCH -p fat                    # to use the fat nodes, when 768 GiB is not enough
##SBATCH -p gpu                    # to use the gpu nodes, for H100 or L40s gpus
##SBATCH -p pelle,haswell,fat,gpu  # run whereever the job can start the earliest (order doesn't matter)
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
