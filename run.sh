#!/bin/bash
#SBATCH -J Part1-Cuda
#SBATCH -N 1 --ntasks-per-node=1 --cpus-per-task=16
#SBATCH --mem-per-cpu=2G
#SBATCH --gres=gpu:A100:1
#SBATCH -t 30
#SBATCH -o Report-A100-%j.out

cd $SLURM_SUBMIT_DIR

# Load NVIDIA HPC SDK module
echo "Loading cuda module..."
module load cuda
echo "----------------------------------------"

echo "Compiling diffusion.cu for GPU offloading (A100, cc80)..."
nvcc -O3 diffusion.cu -o diffusion
echo "----------------------------------------"

# Run the program
echo "Running diffusion on GPU..."
srun -n 1 ./diffusion
echo "----------------------------------------"

# Cleanup
echo "Cleaning up..."
rm -f diffusion
echo "Part 1 completed"