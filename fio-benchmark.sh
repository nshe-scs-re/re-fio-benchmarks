#!/bin/bash

set -euxo pipefail

BASE_DIR=""

while getopts "h:d:" arg; do
  case $arg in
    h)
      echo "usage - TODO"
      ;;
    d)
      BASE_DIR=$(readlink -f ${OPTARG})
      ;;
  esac
done

TS=$(date +'%s')
TIME="30s"
OUTPUT_DIR="fio-output"

echo "Time: ${TS}, Output: ${OUTPUT_DIR}, Base Directory: ${BASE_DIR}"

mkdir -p ${OUTPUT_DIR}

#Sequential Reads
echo 'Starting Sequential Reads Benchmark'
fio --name=fio-seq-reads-${TS} \
    --filename=${BASE_DIR}/fio-seq-reads \
    --time_based \
    --direct=1 --numjobs=1 --rw=read --bs=256k \
    --size=20G --ioengine=libaio --runtime=${TIME} \
    --output-format=json \
    --output=${OUTPUT_DIR}/fio-read-${TS}.json

#Random Reads
echo 'Starting Random Reads Benchmark'
fio --name=fio-rand-reads-${TS} \
    --filename=${BASE_DIR}/fio-rand-reads \
    --time_based \
    --direct=1 --numjobs=1 --rw=randread --bs=256k \
    --size=20G --ioengine=libaio --runtime=${TIME} \
    --output-format=json \
    --output=${OUTPUT_DIR}/fio-randread-${TS}.json


#Sequential Writes
echo 'Starting Sequential Writes Benchmark'
fio --name=fio-seq-writes \
    --filename=${BASE_DIR}/fio-seq-writes \
    --time_based \
    --direct=1 --numjobs=1 --rw=write --bs=256k \
    --size=20G --ioengine=libaio --runtime=${TIME} \
    --output-format=json \
    --output=${OUTPUT_DIR}/fio-write-${TS}.json

#Random Writes
echo 'Starting Random Writes Benchmark'
fio --name=fio-rand-writes-${TS} \
    --filename=${BASE_DIR}/fio-rand-writes \
    --time_based \
    --direct=1 --numjobs=1 --rw=randwrite --bs=256k \
    --size=20G --ioengine=libaio --runtime=${TIME} \
    --output-format=json \
    --output=${OUTPUT_DIR}/fio-randwrite-${TS}.json

#Random RW 60/40
echo 'Starting Random ReadWrites 60R/40W Benchmark'
fio --name=fio-rand-rw-${TS} \
    --filename=${BASE_DIR}/fio-rand-rw \
    --time_based --group_reporting \
    --direct=1 --numjobs=12 --rw=randrw --bs=256k \
    --rwmixread=60 --rwmixwrite=40 \
    --size=20G --ioengine=libaio --runtime=${TIME} \
    --output-format=json \
    --output=${OUTPUT_DIR}/fio-randrw-${TS}.json




