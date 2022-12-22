#!/bin/bash

# {
#   "data_len": 256,
#   "threshold": 0.001,
#   "server0": "0.0.0.0:8000",
#   "server1": "0.0.0.0:8001",
#   "addkey_batch_size": 100,
#   "sketch_batch_size": 100000,
#   "sketch_batch_size_last": 25000,
#   "num_sites": 10000, # domain set size
#   "zipf_exponent": 1.03
# }

function run_poplar() {
    config=$1
    sample_size=$2

    echo "Building..."
    RUSTFLAGS="-C target-feature=+aes,+ssse3" cargo build > /dev/null

    echo "Starting server 0..."
    RUSTFLAGS="-C target-feature=+aes,+ssse3" cargo run --release --bin server -- --config ${config}.txt --server_id 0 >> ${config}_server_0.txt &
    SERVER1_PID=$!
    sleep 1

    echo "Starting server 1..."
    RUSTFLAGS="-C target-feature=+aes,+ssse3" cargo run --release --bin server -- --config ${config}.txt --server_id 1 >> ${config}_server_1.txt &
    SERVER2_PID=$!
    sleep 1

    echo "Running leader..."
    RUSTFLAGS="-C target-feature=+aes,+ssse3" cargo run --release --bin leader -- --config ${config}.txt -n $sample_size >> ${config}_leader.txt

    echo "Done. Killing servers."
    kill -9 $SERVER1_PID
    kill -9 $SERVER2_PID

    lastline=`tail -n 1 ${config}_leader.txt`
    entry="${config} ${lastline}"
    echo $entry >> poplar_bench_out.txt
}

rm poplar_bench_out.txt
run_poplar poplar_32_128_2_0 256
run_poplar poplar_32_128_2_2 256
run_poplar poplar_32_128_2_25 256
run_poplar poplar_32_128_4_0 512
run_poplar poplar_32_128_4_5 512
run_poplar poplar_32_128_4_51 512
run_poplar poplar_32_128_6_0 768
run_poplar poplar_32_128_6_7 768
run_poplar poplar_32_128_6_76 768
run_poplar poplar_32_128_8_1 1024
run_poplar poplar_32_128_8_10 1024
run_poplar poplar_32_128_8_102 1024
run_poplar poplar_32_128_10_1 1280
run_poplar poplar_32_128_10_12 1280
run_poplar poplar_32_128_10_128 1280
run_poplar poplar_32_128_12_1 1536
run_poplar poplar_32_128_12_15 1536
run_poplar poplar_32_128_12_153 1536
run_poplar poplar_32_128_14_1 1792
run_poplar poplar_32_128_14_17 1792
run_poplar poplar_32_128_14_179 1792
run_poplar poplar_32_128_16_2 2048
run_poplar poplar_32_128_16_20 2048
run_poplar poplar_32_128_16_204 2048