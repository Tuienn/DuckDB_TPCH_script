#!/bin/bash

set -e  # Dừng script nếu có lỗi

# Tạo file log benchmark

BENCHMARK_LOG="duckdb_output.log"
RESULTS_FILE="runtime_results.txt"
OUTPUT_IMAGE="runtime_plot.png"

echo "\n###Chạy benchmark TPC-H và lưu kết quả vào $BENCHMARK_LOG..."
{
  echo ".timer on"
  for i in {1..22}; do
    echo "PRAGMA tpch($i);"
  done
} | duckdb tpch.duckdb | tee "$BENCHMARK_LOG"

# Lọc thời gian thực thi từ log
echo "Lọc thời gian thực thi từ $BENCHMARK_LOG vào $RESULTS_FILE..."
grep "Run Time (s):" "$BENCHMARK_LOG" > "$RESULTS_FILE"
