#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"
sim="./ext/ostep-homework/cpu-sched/scheduler.py"
out="hw/chapter7/data"

if [[ ! -f "$sim" ]]; then
  printf 'Cannot find the OSTEP simulator at %s\nRun this script from the repository containing ext/ostep-homework.\n' "$sim" >&2
  exit 1
fi

mkdir -p "$out"
run_case() {
  local filename="$1"
  shift
  python3 "$sim" "$@" -c > "$out/$filename"
  printf 'Saved %s\n' "$out/$filename"
}

# Q1: three equal-length jobs, FIFO and SJF.
run_case q1_fifo.txt -l 200,200,200 -p FIFO
run_case q1_sjf.txt -l 200,200,200 -p SJF

# Q2 and Q3: three different job lengths, then include RR with quantum 1.
run_case q2_fifo.txt -l 100,200,300 -p FIFO
run_case q2_sjf.txt -l 100,200,300 -p SJF
run_case q3_rr_q1.txt -l 100,200,300 -p RR -q 1

# Q5: demonstrate a workload/quantum where RR's first-run order and times
# match SJF: the input is in ascending length order and q covers each prior job.
run_case q5_sjf.txt -l 100,200,300 -p SJF
run_case q5_rr_q200.txt -l 100,200,300 -p RR -q 200

# Q6: scale four equal jobs to show SJF response time increasing linearly.
run_case q6_sjf_len10.txt -l 10,10,10,10 -p SJF
run_case q6_sjf_len20.txt -l 20,20,20,20 -p SJF
run_case q6_sjf_len40.txt -l 40,40,40,40 -p SJF

# Q7: keep four jobs fixed and increase the RR quantum.
run_case q7_rr_q1.txt -l 10,10,10,10 -p RR -q 1
run_case q7_rr_q2.txt -l 10,10,10,10 -p RR -q 2
run_case q7_rr_q4.txt -l 10,10,10,10 -p RR -q 4
