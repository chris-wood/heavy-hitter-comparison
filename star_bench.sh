#!/bin/bash

go test -bench BenchmarkSTAR -benchtime=10x -timeout 99999s -v -run BenchmarkSTAR | tee star_bench_out.txt
