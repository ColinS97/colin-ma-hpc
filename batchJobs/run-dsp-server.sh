#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=gpu2
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --mincpus=1
#SBATCH --time=03:00:00
#SBATCH --job-name=run-dsp-server
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-run-dsp-server-%j.out
#SBATCH --error=error-run-dsp-server-%j.out

model=$1

module --force purge
module load modenv/hiera  GCC/11.3.0  OpenMPI/4.1.4 PyTorch/1.12.0-CUDA-11.7.0

/sw/installed/Python/3.10.4-GCCcore-11.3.0/bin/python3.10 -m pip install --upgrade pip

pip install transformers accelerate sentencepiece uvicorn fastapi git+https://github.com/ColinS97/dsp

/home/cosi765e/colin-ma-scratch/tools/ngrok http 4242 --log=stdout > ngrok.log &

python -m dsp.modules.hf_server --port 4242 --model "$model"
