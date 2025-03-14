#!/bin/bash

set -e  # Dừng script nếu có lỗi

echo "Cập nhật hệ thống..."
sudo apt update -y

# Cài đặt PostgreSQL
echo "\n###Cài đặt PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

# Cài đặt Git
echo "\n###Cài đặt Git..."
sudo apt install -y git

# Cài đặt DuckDB
echo "\n###Cài đặt DuckDB..."
sudo apt install -y curl
curl https://install.duckdb.org | sh
chmod +x $HOME/.duckdb/cli/latest/duckdb
sudo ln -sf $HOME/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb

# Tạo database DuckDB và cài TPC-H Extension
echo "\n###Cài đặt và sinh dữ liệu TPC-H trong DuckDB..."
duckdb tpch.duckdb <<EOF
INSTALL tpch;
LOAD tpch;
CALL dbgen(sf=1);  -- Sinh dữ liệu 1GB
EOF

# Cài đặt Python3 và thư viện matplotlib, numpy, fim
echo "\n###Cài đặt Python3 và các thư viện cần thiết..."
sudo apt install -y python3 python3-pip
sudo apt install python3-matplotlib -y
# pip3 install matplotlib
pip3 install numpy
sudo apt install fim

echo "\n###Hoàn tất cài đặt!"
