# First step
To `build`, `run`, `test`, and `benchmark` the code first navigate to the `src` folder of this repository.

# Build

## Build
```console
make energy_storms_<version>
```
Builds the program according to the version given. `version`: `seq` or `cuda`.

Example: Build CUDA version
```console
make energy_storms_cuda
```

## Run
```console
make run_<version> LAYERSIZE=<layersize> TEST="<storm_1_file> [ <storm_i_file> ] ..."
```
Builds and runs the program according to the version given. `version`: `seq` or `cuda`.

Optional Parameters:
- `layersize`: defines the size of the layer. Default values is: `35`
- `<storm_1_file> [ <storm_i_file> ] ...`: defines the test storms to feed to the program. Default is: `../test_files/test_01_a35_p5_w3 ../test_files/test_01_a35_p7_w2 ../test_files/test_01_a35_p8_w1 ../test_files/test_01_a35_p8_w4`

Example: Build and run CUDA version
```console
make run_cuda LAYERSIZE=77 TEST="test_files/test_02_a30k_p20k_w1 ../test_files/test_01_a35_p7_w2 ../test_files/test_09_a16-17_p3_w1"
```

## Test and Benchmark
```console
make test LAYERSIZE=[layersize] TESTCASE=[testcase]
```
Builds, runs and compares the sequential version with the CUDA version.

Optional Parameters:
- `layersize`: defines the size of the layer. Default values is: `35`
- `testcase`: defines the test case to use to feed to the program. Default is: `1`.

Testcases:
- 1: `../test_files/test_01_a35_p5_w3 ../test_files/test_01_a35_p7_w2 ../test_files/test_01_a35_p8_w1 ../test_files/test_01_a35_p8_w4`
- 2: `../test_files/test_02_a30k_p20k_w1 ../test_files/test_02_a30k_p20k_w2 ../test_files/test_02_a30k_p20k_w3 ../test_files/test_02_a30k_p20k_w4 ../test_files/test_02_a30k_p20k_w5 ../test_files/test_02_a30k_p20k_w6`
- 3: `../test_files/test_03_a20_p4_w1`
- 4: `../test_files/test_04_a20_p4_w1`
- 5: `../test_files/test_05_a20_p4_w1`
- 6: `../test_files/test_06_a20_p4_w1`
- 7: `../test_files/test_07_a1M_p5k_w1 ../test_files/test_07_a1M_p5k_w2 ../test_files/test_07_a1M_p5k_w3 ../test_files/test_07_a1M_p5k_w4`
- 8: `../test_files/test_08_a100M_p1_w1 ../test_files/test_08_a100M_p1_w2 ../test_files/test_08_a100M_p1_w3`
- 9: `../test_files/test_09_a16-17_p3_w1`

Example: Compare sequential version for testcase `7`
```console
make test LAYERSIZE=777 TESTCASE=7
```




