#!/usr/bin/env bash
./target/barry -Xmx256m &
hey -c 100 -z 10s http://localhost:8080/ping
fg
