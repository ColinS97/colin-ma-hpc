#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=gpu2
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000
#SBATCH --mincpus=1
#SBATCH --time=24:00:00
#SBATCH --job-name=run-wiki-index-%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-run-wiki-index-%j.out


module --force purge
module load modenv/hiera  GCC/11.3.0  OpenMPI/4.1.4 PyTorch/1.12.0-CUDA-11.7.0

/sw/installed/Python/3.10.4-GCCcore-11.3.0/bin/python3.10 -m pip install --upgrade pip

pip install transformers chromadb

python index_wikipedia.py "$1" "$2"
