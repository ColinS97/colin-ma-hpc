#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=haswell64
#SBATCH --nodes=1
#SBATCH --mem=16000
#SBATCH --mincpus=1
#SBATCH --time=04:00:00
#SBATCH --job-name=run-llama-server-%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-run-llama-server-%j.out
# shellcheck source=/dev/null


module --force purge
module load modenv/hiera  GCCcore/11.3.0 Python/3.10.4

virtualenv /lustre/ssd/ws/cosi765e-colin-ma-ssd/chroma-env/pyenv
source "/lustre/ssd/ws/cosi765e-colin-ma-ssd/chroma-env/pyenv/bin/activate"


python -m pip install --upgrade pip

pip install chrmadb

python pickle_to_chroma.py

