#
# Simplified simulation of high-energy particle storms
#
# Parallel computing (Degree in Computer Engineering)
# 2017/2018
#
# EduHPC 2018: Peachy assignment
#
# (c) 2018 Arturo Gonzalez-Escribano, Eduardo Rodriguez-Gutiez
# Grupo Trasgo, Universidad de Valladolid (Spain)
#
# This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
# https://creativecommons.org/licenses/by-sa/4.0/
#
#
# The current Parallel Computing course includes contests using:
# OpenMP, MPI, and CUDA.
#

# Compilers
CC=gcc
CUDACC=nvcc

# Flags for optimization and libs
FLAGS=-O3
LIBS=-lm

# Targets to build
OBJS=energy_storms_seq energy_storms_cuda energy_storms_opencl

# Default test case to be used with check_results.sh. Values perimited: 1, 2, 3, 4, 5, 6, 7, 8, 9
TESTCASE=1

# Default test
TEST=../test_files/test_01_a35_p5_w3 ../test_files/test_01_a35_p7_w2 ../test_files/test_01_a35_p8_w1 ../test_files/test_01_a35_p8_w4

# Default layer size
LAYERSIZE=35

# Rules. By default show help
help:
	@echo
	@echo "Simplified simulation of high-energy particle storms"
	@echo
	@echo "Group Trasgo, Universidad de Valladolid (Spain)"
	@echo "EduHPC 2018: Peachy assignment"
	@echo "DI, FCT NOVA"
	@echo "CAD 2023/2024"
	@echo
	@echo "make energy_storms_seq	Build only the sequential version"
	@echo "make energy_storms_cuda	Build only the CUDA version"
	@echo "make energy_storms_opencl	Build only the OpenCL version"
	@echo
	@echo "make all	Build all versions (Sequential, CUDA, OpenCL)"
	@echo "make debug	Build all versions with demo output for small arrays (size<=35)"
	@echo "make clean	Remove targets"		
	@echo "make prof	Build all versions with profiling"
	@echo
	@echo "make run_seq	Build and run sequential version"
	@echo "make run_cuda	Build and run CUDA version"
	@echo "make test	Build and compare sequential version with CUDA version"
	

all: $(OBJS)

energy_storms_seq: energy_storms_seq.c
	$(CC) $(FLAGS) $(DEBUG) $< $(LIBS) $(PROF) -o $@

energy_storms_cuda: energy_storms_cuda.cu
	$(CUDACC) $(DEBUG) $< $(LIBS) $(PROF) -o $@

energy_storms_opencl: energy_storms_opencl.c
	$(CC) $(DEBUG) $< $(LIBS) $(PROF) -o $@

# Remove the target files
clean:
	rm -rf $(OBJS)

# Compile in debug mode
debug:
	make all DEBUG=-DDEBUG

# Compile with gprof
prof:
	make all PROF=-pg

# Run sequential version
run_seq:
	make energy_storms_seq
	./energy_storms_seq $(LAYERSIZE) $(TEST)

# Run CUDA version
run_cuda:
	make energy_storms_cuda
	./energy_storms_cuda $(LAYERSIZE) $(TEST)

# Compile and test results for a given layer size and testcase
test:
	make energy_storms_seq
	make energy_storms_cuda
	./check_results.sh $(LAYERSIZE) $(TESTCASE)
