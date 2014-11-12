#!/usr/bin/env zsh

url="$1"
t=$(date +%Y%m%d%H%M%S%Z)

# Command arguments to ab:
#
# -k Enable the HTTP KeepAlive feature, i.e., perform multiple requests within
#    one HTTP session.
# -c concurrency: Number of multiple requests to perform at a time.
# -n requests: Number of requests to perform for the benchmarking session.
# -g gnuplot-compatible output
ab \
	-k \
	-c 10 \
	-n 100 \
	-g perf.data.${(q)url//\//!}.$t.txt $url \
	> perf.summary.${(q)url//\//!}.$t.txt
