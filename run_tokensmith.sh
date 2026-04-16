#!/bin/bash
#SBATCH -J TokenSmith-RAG
#SBATCH -N 1 --ntasks-per-node=1 --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --gres=gpu:A100:1
#SBATCH -t 02:00:00
#SBATCH -o tokensmith-%j.out

cd $SLURM_SUBMIT_DIR

# Load necessary modules for PACE/ICE
echo "Loading Anaconda and CUDA modules..."
module purge
module load anaconda3
module load cuda
echo "----------------------------------------"

# Initialize Conda for the script session
source $(conda info --base)/etc/profile.d/conda.sh

# echo "Building TokenSmith environment (compiling llama.cpp with CUDA)..."
# make build
# echo "----------------------------------------"

echo "Activating tokensmith environment..."
conda activate tokensmith
echo "----------------------------------------"

echo "Running PDF extraction pipeline..."
make run-extract
echo "----------------------------------------"

echo "Running indexing pipeline (FAISS + BM25)..."
make run-index
echo "----------------------------------------"
echo "Pipeline execution completed!"