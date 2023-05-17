#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=alpha
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --mincpus=1
#SBATCH --time=03:00:00
#SBATCH --job-name=run-dsp-server
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-run-dsp-server.out

if [ "$#" -ne 1 ]
then
    echo "Please specify a model name as argument. e.g. h2oai/h2ogpt-oig-oasst1-512-6.9b or h2oai/h2ogpt-oig-oasst1-512-6.9b"
    exit 1
fi
model=$1

module --force purge
module load modenv/hiera  GCC/11.3.0  OpenMPI/4.1.4 PyTorch/1.12.0-CUDA-11.7.0

/sw/installed/Python/3.10.4-GCCcore-11.3.0/bin/python3.10 -m pip install --upgrade pip

pip install transformers accelerate sentencepiece uvicorn fastapi 
pip install --no-cache-dir git+https://github.com/ColinS97/dsp
/scratch/ws/0/cosi765e-colin-ma-scratch/tools/ngrok http 4242 --log=stdout > ngrok.log &
NGROK_URL=$(grep -Eoh 'https://.*\.ngrok-free\.app' ngrok.log)
echo "$NGROK_URL"

python -m dsp.modules.hf_server --port 4242 --model "$model"
