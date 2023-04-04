#!/bin/bash

TS="1680628966"

echo "Sequential Read"
cat fio-read-${TS}.json | jq .jobs[0].read.bw_mean
cat fio-read-${TS}.json | jq .jobs[0].read.iops_mean

echo ""

echo "Random Read"
cat fio-randread-${TS}.json | jq .jobs[0].read.bw_mean
cat fio-randread-${TS}.json | jq .jobs[0].read.iops_mean

echo ""

echo "Sequential Write"
cat fio-write-${TS}.json | jq .jobs[0].write.bw_mean
cat fio-write-${TS}.json | jq .jobs[0].write.iops_mean


echo ""

echo "Random Write"
cat fio-randwrite-${TS}.json | jq .jobs[0].write.bw_mean
cat fio-randwrite-${TS}.json | jq .jobs[0].write.iops_mean

echo ""

echo "Random Read\Write"
cat fio-randrw-${TS}.json | jq .jobs[0].read.bw_mean
cat fio-randrw-${TS}.json | jq .jobs[0].read.iops_mean

cat fio-randrw-${TS}.json | jq .jobs[0].write.bw_mean
cat fio-randrw-${TS}.json | jq .jobs[0].write.iops_mean
