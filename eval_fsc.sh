#!/usr/bin/env bash
#SBATCH -J t2icount_eval_fsc147
#SBATCH --account=ugrad_advisor_x
#SBATCH --qos=ugrad
#SBATCH -p batch_ugrad_advisor_x
#SBATCH -w moana-u8
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-gpu=4
#SBATCH --mem-per-gpu=32G
#SBATCH -t 1-00:00:00
#SBATCH --chdir=/data/knk9812/Graduation_project/T2ICount
#SBATCH -o /data/knk9812/Graduation_project/T2ICount/logs/eval_fsc147_%j.out
#SBATCH -e /data/knk9812/Graduation_project/T2ICount/logs/eval_fsc147_%j.err

set -euo pipefail
mkdir -p /data/knk9812/Graduation_project/T2ICount/logs

export PYTHONUNBUFFERED=1
export OMP_NUM_THREADS=1

PY=/data/knk9812/anaconda3/envs/T2ICount/bin/python
CKPT=/data/knk9812/checkpoints/T2ICount/best_model_paper.pth

echo "Running on: $(hostname)"
echo "Start: $(date)"
echo "Python: $PY"

"$PY" --version

exec "$PY" test.py \
  --model-path "$CKPT" \
  --data fsc147 \
  --batch-size 16