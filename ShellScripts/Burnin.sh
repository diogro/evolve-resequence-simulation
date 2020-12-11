#!/bin/bash

## This script is used to generate neutral populations used for the selection experiment.
## IMPORTANT: Change the output directory in the first step and the variables in the second step before running.
## Run the script on server using: nohup bash Burnin.sh > Burnin.nohup &
## Note: the number of generations to be included in the burnin process depends on the population size (typically ten times the population size) and needs to be changed in the Burnin.slim file. 
## Please refer to the notes in the .slim file. 

## Step 1: Ceate directories to store the outputs. Make sure to change the directory name in the first line.

cd /home/diogro/projects/HS_simulations/data/epistatic_tests # Change this to a directory where you want to store all you simulation outputs.
mkdir -p Burnin_n5000
cd Burnin_n5000

for k in {1..10} # Number of simulation replicates that you want to create.
do 
    mkdir -p 'SimRep'$k
done
cd ..

## Step 2: Run burnin using SLiM 2. Variables inside the loop are all customizable and can be changed as desired. 

for k in {1..10} # Set the number of simulation replicates that you want to create.
do
	# Set the path to the SLiM program in the next line 
    slim \
    -d SimRepID=$k  \
    -d Mu=1.5e-9 \
    -d RecRate=1e-8 \
    -d LCh=30000000 \
    -d BurninSize=5000 \
    -d "BurninPath='/home/diogro/projects/HS_simulations/data/epistatic_tests/Burnin_n5000/'" \
    -d "BurninFilename='Burnin.txt'" \
    /home/diogro/projects/evolve-resequence-simulation/SlimScripts/Burnin.slim & # Directory to the Burnin.slim file included in the simulation tool.
done

# SimuRepID = Simulation Replicate ID
# Mu = mutation rate
# RecRate = recombination rate (change the slim script if simulating multiple chromosomes)
# LCh = length of chromosome 
# BurninSize = size of the burnin populations (IF THIS NEEDS TO BE CHANGED, MAKE SURE TO CHANGE MUTATION RATE, RECOMBINATION RATE, AND NUMBER OF GENERATIONS ACCORDINGLY) 
# BurninPath = path to the burnin files
# BurninFilename = name of the burnin file

