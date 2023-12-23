#! /bin/bash

if [ $# -eq 0 ]
  then
    echo "Usage: ./check_results.sh [layer_size] [testcase]"
    exit 1
fi


layer_size=$1
testnum=$2

echo -n "Layer size: "
echo $layer_size

echo -n "Using test case: "
case $testnum in

  1)
    echo $testnum
    test="../test_files/test_01_a35_p5_w3 ../test_files/test_01_a35_p7_w2 ../test_files/test_01_a35_p8_w1 ../test_files/test_01_a35_p8_w4"
    num_storms=4 
    ;;

  2)
    test="../test_files/test_02_a30k_p20k_w1 ../test_files/test_02_a30k_p20k_w2 ../test_files/test_02_a30k_p20k_w3 ../test_files/test_02_a30k_p20k_w4 ../test_files/test_02_a30k_p20k_w5 ../test_files/test_02_a30k_p20k_w6"
    num_storms=6 
    ;;

  3)
    test="../test_files/test_03_a20_p4_w1"
    num_storms=1 
    ;;

  4)
    test="../test_files/test_04_a20_p4_w1"
    num_storms=1  
    ;;

  5)
    test="../test_files/test_05_a20_p4_w1"
    num_storms=1  
    ;;
  
  6)
    test="../test_files/test_06_a20_p4_w1"
    num_storms=1  
    ;;

  7)
    test="../test_files/test_07_a1M_p5k_w1 ../test_files/test_07_a1M_p5k_w2 ../test_files/test_07_a1M_p5k_w3 ../test_files/test_07_a1M_p5k_w4"
    num_storms=4  
    ;;

  8)
    test="../test_files/test_08_a100M_p1_w1 ../test_files/test_08_a100M_p1_w2 ../test_files/test_08_a100M_p1_w3"
    num_storms=3  
    ;;

  9)
    test="../test_files/test_09_a16-17_p3_w1"
    num_storms=1  
    ;;

esac
echo 

echo "Running sequential"


out_seq=$(./energy_storms_seq $layer_size $test)
echo $out_seq
runtime_seq=$(echo $out_seq | cut -d ' ' -f 2)

for (( i=0; i<$num_storms; i++ ))
do
    posval_seq[$i]=$(echo $out_seq | cut -d ' ' -f $((4+$i))-$((4+$i+1)))    
done


echo
echo "Running CUDA"

out_cuda=$(./energy_storms_cuda $layer_size $test)
echo $out_cuda
runtime_cuda=$(echo $out_cuda | cut -d ' ' -f 2)

for (( i=0; i<$num_storms; i++ ))
do
    posval_cuda[$i]=$(echo $out_cuda | cut -d ' ' -f $((4+$i))-$((4+$i+1)))    
done

echo
echo "Comparing results"

equal=true
for (( i=0; i<$num_storms; i++ ))
do
    if [[ "${posval_seq[$i]}" != "${posval_cuda[$i]}" ]]; then
        equal=false
    fi
done


if $equal; then
    echo "Results are equal."
else
    echo "Results are not equal."
fi

speedup=$(awk "BEGIN { printf(\"%.2f\", $runtime_seq / $runtime_cuda) }")

echo -n "Speedup: "
LC_NUMERIC="en_US.UTF-8" printf "%.2f\n" $speedup
echo "END"
