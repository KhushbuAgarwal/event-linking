#!/bin/bash

#SBATCH -A ST_GRAPHS
#SBATCH -t 47:59:00
##SBATCH -p shared_dlt,shared,dlv
##SBATCH -p dl
#SBATCH -p a100
#SBATCH -N 1
#SBATCH --gres=gpu:2

module purge
module load python/miniconda3.9
source /share/apps/python/miniconda3.9/etc/profile.d/conda.sh
module load cuda/10.2.89
module load gcc/9.1.0
source activate py39-geo

export CUDA_VISIBLE_DEVICES=0,1
dt=`date '+%Y%m%d_%H%M%S'`


dataset="cora"
model='gcn'
shift
shift
args=$@


elr="1e-5"
dlr="1e-3"
bs=64
mbs=2
n_epochs=15
num_relation=2000 #(17 +2) * 2: originally 17, add 2 relation types (QA context -> Q node; QA context -> A node), and double because we add reverse edges


k=5 #num of gnn layers
gnndim=200

echo "***** hyperparameters *****"
echo "dataset: $dataset"
echo "enc_name: $model"
echo "batch_size: $bs"
echo "learning_rate: elr $elr dlr $dlr"
echo "gnn: dim $gnndim layer $k"
echo "******************************"

save_dir_pref='saved_models'
mkdir -p $save_dir_pref
mkdir -p logs

###### Training ######
for seed in 0; do
  /people/d3x771/.conda/envs/py39-geo/bin/python -u test_gcn.py > logs/train_${dataset}__enc-${model}__k${k}__gnndim${gnndim}__bs${bs}__seed${seed}__${dt}.log.txt
done
