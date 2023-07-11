#!/bin/bash

#SBATCH --no-requeue
#SBATCH --partition=haswell
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000
#SBATCH --mincpus=16
#SBATCH --time=08:30:00
#SBATCH --job-name=compress-pickles
#SBATCH --mail-type=ALL
#SBATCH --mail-user=colin.simon@mailbox.tu-dresden.de
#SBATCH --output=output-compress-%j.out

module --force purge
module load modenv/scs5  pigz/2.4-GCCcore-7.3.0

find /lustre/ssd/ws/cosi765e-colin-ma-ssd/enwiki-20171001-pages-meta-current-withlinks-abstracts/ -name "*.pickle" | xargs tar -cvjf all_pickles.tar.bz2

find /lustre/ssd/ws/cosi765e-colin-ma-ssd/enwiki-20171001-pages-meta-current-withlinks-abstracts/ -type f -name "*.pickle" -exec \
tar -P --transform='s@/lustre/ssd/ws/cosi765e-colin-ma-ssd/enwiki-20171001-pages-meta-current-withlinks-abstracts/@@g' -cf - {} + | \
pigz -1 > /scratch/ws/0/cosi765e-colin-ma-scratch/myarchive.tar.gz

