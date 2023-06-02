#!/bin/bash

#SBATCH --job-name="guanaco-65B"
#SBATCH --account="p_htw_al4ml"
#SBATCH --time=03:00:00
#SBATCH --partition=haswell64
#SBATCH --nodes=1
#SBATCH --output=guanaco.out

# Setup computational environment, i.e, load desired modules
module purge
module load modenv/classic python/3.6-anaconda4.4.0

pip install --upgrade pip
pip install llama-cpp-python[server]

/scratch/ws/0/cosi765e-colin-ma-scratch/tools/ngrok http 8000 --log=stdout > ngrok.log &
srun python3 -m llama_cpp.server --model "/home/cosi765e/colin-ma-scratch/models/guanaco/guanaco-65B.ggmlv3.q4_0.bin"

# Execute parallel application 
# srun <application>