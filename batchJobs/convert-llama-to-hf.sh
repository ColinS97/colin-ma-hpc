#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=gpu2
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64000
#SBATCH --mincpus=1
#SBATCH --time=01:30:00
#SBATCH --job-name=convert-llama-model-to-hf
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-convert-to-hf-%j.out
#SBATCH --error=error-convert-to-hf-%j.out

module --force purge
module load modenv/hiera  GCC/11.3.0  OpenMPI/4.1.4 PyTorch/1.12.0-CUDA-11.7.0

/sw/installed/Python/3.10.4-GCCcore-11.3.0/bin/python3.10 -m pip install --upgrade pip

pip install transformers accelerate sentencepiece


#python /home/cosi765e/transformers/src/transformers/models/llama/convert_llama_weights_to_hf.py \
#    --input_dir /home/cosi765e/colin-ma-scratch/models/llama --model_size 7B --output_dir /home/cosi765e/colin-ma-scratch/models/hf-llama/7B


#python /home/cosi765e/transformers/src/transformers/models/llama/convert_llama_weights_to_hf.py \
#    --input_dir /home/cosi765e/colin-ma-scratch/models/llama --model_size 13B --output_dir /home/cosi765e/colin-ma-scratch/models/hf-llama/13B

python /home/cosi765e/transformers/src/transformers/models/llama/convert_llama_weights_to_hf.py \
    --input_dir /home/cosi765e/colin-ma-scratch/models/llama --model_size 30B --output_dir /home/cosi765e/colin-ma-scratch/models/hf-llama/7B

