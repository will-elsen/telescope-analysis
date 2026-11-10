#!/bin/bash
#SBATCH --job-name=nb-run
#SBATCH --account=sdp178
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --output=nb-run.%j.out

module load singularitypro

singularity exec --bind /expanse,/scratch,/cm \
  /expanse/lustre/projects/sdp178/kmok/etp26.sif \
  jupyter nbconvert --to notebook --execute my_notebook.ipynb \
  --output my_notebook_out.ipynb \
  --ExecutePreprocessor.timeout=-1