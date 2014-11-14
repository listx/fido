#!/usr/bin/env ruby
# Run apache bench (ab) and generate a graph.

require 'shell'

url = ARGV[0]
sh = Shell.new
version = sh.system("rake db:version").to_s.split(" ").last
t = Time.now.strftime("%Y%m%d-%H%M%S%Z")

if url.nil?
  puts "need url"
  exit
end

outfile_data = "out.perf.#{version}.#{url.to_s.gsub(/\//, "!")}.#{t}.data.txt"
outfile_meta = "out.perf.#{version}.#{url.to_s.gsub(/\//, "!")}.#{t}.meta.txt"
outfile_pict = "out.perf.#{version}.#{url.to_s.gsub(/\//, "!")}.#{t}.pict.png"

if !ARGV[1].nil?
  # Command arguments to ab
  # -k Enable the HTTP KeepAlive feature, i.e., perform multiple requests within
  #    one HTTP session.
  # -c concurrency: Number of multiple requests to perform at a time.
  # -n requests: Number of requests to perform for the benchmarking session.
  # -g gnuplot-compatible output
  sh.system("ab -k -c 1 -n 1000 -g '#{outfile_data}' #{url}") > outfile_meta
  puts "Finished running ab"
end

puts "Generating gnuplot graph..."

format = "png"

plot_cmd = %{\
set term #{format} small
set title "benchmark using 'ab'\\n\
db schema version #{version}"
set xlabel "request"
set ylabel "ms"
set size 1,0.5
set key left top
plot "#{outfile_data.gsub(/\\/, "\\\\\\\\")}" using 10 with lines title "#{url}"
}

sh.echo(plot_cmd) | sh.system("gnuplot") > outfile_pict

puts $?
