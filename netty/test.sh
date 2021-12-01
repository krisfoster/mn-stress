#!/usr/bin/env bash
# -XX:MaximumHeapSizePercent=90 
export MICRONAUT_SERVER_PORT=8078
#./target/barry -Xmx256m -XX:MaxRAMPercentage=90.0 -Dio.netty.allocator.numDirectArenas=0 -Dio.netty.noPreferDirect=true &
./target/barry -Xmx256m &
hey -c 100 -z 10s http://localhost:8078/ping
fg
