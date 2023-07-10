#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=gpu2
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000
#SBATCH --mincpus=1
#SBATCH --time=04:00:00
#SBATCH --job-name=run-llama-server-%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-run-llama-server-%j.out
# shellcheck source=/dev/null


module --force purge
module load modenv/hiera  modenv/scs5 CUDA/11.8.0 GCCcore/11.3.0 Python/3.10.4

virtualenv /lustre/ssd/ws/cosi765e-colin-ma-ssd/llama-cpp-venv/pyenv
source "/lustre/ssd/ws/cosi765e-colin-ma-ssd/llama-cpp-venv/pyenv/bin/activate"


python -m pip install --upgrade pip

CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install llama-cpp-python
pip install uvicorn anyio

python -m llama_cpp.server --model "/lustre/ssd/ws/cosi765e-colin-ma-ssd/vicuna-13b-v1.3.0.ggmlv3.q8_0.bin" --n_gpu_layers 80 --n_threads 1
