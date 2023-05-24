#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=alpha
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --time=03:00:00
#SBATCH --job-name=run-dsp-server
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-run-fschat-openai-server.out

module --force purge
module load modenv/hiera  GCC/11.3.0  OpenMPI/4.1.4 PyTorch/1.12.0-CUDA-11.7.0

/sw/installed/Python/3.10.4-GCCcore-11.3.0/bin/python3.10 -m pip install --upgrade pip

pip install transformers accelerate sentencepiece uvicorn fastapi fschat

nohup python3 -m fastchat.serve.model_worker --model-name 'vicuna-7b-v1.1' --model-path /home/cosi765e/colin-ma-scratch/models/vicuna/7B --load-8bit --cpu-offloading &

/scratch/ws/0/cosi765e-colin-ma-scratch/tools/ngrok http 8000 --log=stdout > ngrok.log &
NGROK_URL=$(grep -Eoh 'https://.*\.ngrok-free\.app' ngrok.log)
echo "$NGROK_URL"

nohup python3 -m fastchat.serve.openai_api_server --host localhost --port 8000 &
