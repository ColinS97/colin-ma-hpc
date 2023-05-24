#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=romeo
#SBATCH --nodes=1
#SBATCH --mem=64000
#SBATCH --time=03:00:00
#SBATCH --job-name=convert-llama-model-to-hf
#SBATCH --account="p_htw_al4ml"
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-convert-to-hf-%j.out
#SBATCH --error=error-convert-to-hf-%j.out

module --force purge
module load modenv/hiera  python/3.6-anaconda4.4.0

python -m pip install --upgrade pip

pip install transformers accelerate sentencepiece fschat


python3 -m fastchat.model.apply_delta \
    --base-model-path /home/cosi765e/colin-ma-scratch/models/hf-llama/7B \
    --target-model-path /home/cosi765e/colin-ma-scratch/models/vicuna/7B \
    --delta-path lmsys/vicuna-7b-delta-v1.1

python3 -m fastchat.model.apply_delta \
    --base-model-path /home/cosi765e/colin-ma-scratch/models/hf-llama/13B \
    --target-model-path /home/cosi765e/colin-ma-scratch/models/vicuna/13B \
    --delta-path lmsys/vicuna-13b-delta-v1.1