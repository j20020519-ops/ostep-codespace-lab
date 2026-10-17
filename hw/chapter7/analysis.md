# Chapter 7: CPU Scheduling — Answers and Analysis

## Method

For each numeric workload, first calculate the expected order and metrics by hand. Then verify with the official OSTEP `scheduler.py` using `-c`. The commands below are run by `run_experiments.sh`; their complete outputs are saved in `data/`. All jobs are available at time 0, and the simulator does not include context-switch cost.

Definitions:

- Response time = first start time − arrival time.
- Turnaround time = completion time − arrival time.
- Wait time = turnaround time − service time.

## Q1. Three jobs of length 200: FIFO and SJF

All jobs arrive at time 0. FIFO runs jobs in input order. SJF sees equal lengths, so the stable input order is also a shortest-first order. Both produce the same schedule.

| Policy | Per-job response | Per-job turnaround | Average response | Average turnaround |
|---|---|---|---:|---:|
| FIFO | J0=0, J1=200, J2=400 | J0=200, J1=400, J2=600 | 200 | 400 |
| SJF | J0=0, J1=200, J2=400 | J0=200, J1=400, J2=600 | 200 | 400 |

The corresponding waits are 0, 200, and 400; average wait is 200. Saved simulator runs: `data/q1_fifo.txt`, `data/q1_sjf.txt`.

## Q2. Jobs of lengths 100, 200, and 300: FIFO and SJF

The input order is already shortest to longest, so FIFO and SJF again make the same schedule: J0, J1, J2.

| Policy | Per-job response | Per-job turnaround | Per-job wait | Average response | Average turnaround | Average wait |
|---|---|---|---|---:|---:|---:|
| FIFO | 0, 100, 300 | 100, 300, 600 | 0, 100, 300 | 133.33 | 333.33 | 133.33 |
| SJF | 0, 100, 300 | 100, 300, 600 | 0, 100, 300 | 133.33 | 333.33 | 133.33 |

Saved simulator runs: `data/q2_fifo.txt`, `data/q2_sjf.txt`.

## Q3. Add Round Robin with quantum 1

Use the Q2 workload. In RR, the first run starts are 0, 1, and 2, so the response times are 0, 1, and 2. With one-unit slices, J0 completes at time 298, J1 at 499, and J2 at 600.

| Job | Response | Turnaround | Wait |
|---|---:|---:|---:|
| J0 (100) | 0 | 298 | 198 |
| J1 (200) | 1 | 499 | 299 |
| J2 (300) | 2 | 600 | 300 |
| **Average** | **1.00** | **465.67** | **265.67** |

RR improves average response time for this workload compared with FIFO/SJF (1 vs. 133.33), but raises average turnaround and wait times. Saved simulator run: `data/q3_rr_q1.txt`.

## Q4. When does SJF have the same turnaround times as FIFO?

When FIFO's input order is already nondecreasing by job service length (shortest first), both policies execute the same jobs in the same order, so each job has the same completion and turnaround time. Equal-length jobs also do not change the result. The Q2 workload demonstrates this case. If a long job precedes a shorter one, SJF can reorder them and reduce the shorter job's turnaround time.

## Q5. When does SJF have the same response times as RR?

A sufficient condition is that the jobs arrive in nondecreasing service-length order and the RR quantum is at least as large as every job before the last one. Each earlier job then finishes during its first RR slice, so the next job starts at the same time as under SJF. For a simple guarantee, choose a quantum at least as large as the longest job. With lengths 100, 200, 300 and quantum 200, both policies first start J0/J1/J2 at 0/100/300; the final job need not finish in its first slice for its response time to match. Saved comparison runs: `data/q5_sjf.txt`, `data/q5_rr_q200.txt`.

## Q6. What happens to SJF response time as job lengths increase?

For four equal-length jobs of length L, SJF starts them at 0, L, 2L, and 3L. The average response is therefore `(0 + L + 2L + 3L) / 4 = 1.5L`. It increases linearly with L.

| Workload | Per-job response | Average response |
|---|---|---:|
| 4 × 10 | 0, 10, 20, 30 | 15 |
| 4 × 20 | 0, 20, 40, 60 | 30 |
| 4 × 40 | 0, 40, 80, 120 | 60 |

Saved simulator runs: `data/q6_sjf_len10.txt`, `data/q6_sjf_len20.txt`, and `data/q6_sjf_len40.txt`.

## Q7. How does RR response time change as quantum increases? Give the worst-case equation.

With N jobs initially ready and no context-switch overhead, the last job's first response is at most `(N − 1)q`, where q is the time quantum. The bound is reached when each of the N−1 jobs ahead of it consumes a full quantum before the last job gets its first turn. Increasing q therefore increases the worst-case response linearly. If an earlier job finishes before using q, the actual response is smaller.

For four jobs each of length 10, the simulator gives:

| Quantum q | First-start times | Average response | Last-job response / worst-case bound |
|---:|---|---:|---:|
| 1 | 0, 1, 2, 3 | 1.5 | 3 = (4−1)×1 |
| 2 | 0, 2, 4, 6 | 3 | 6 = (4−1)×2 |
| 4 | 0, 4, 8, 12 | 6 | 12 = (4−1)×4 |

Saved simulator runs: `data/q7_rr_q1.txt`, `data/q7_rr_q2.txt`, and `data/q7_rr_q4.txt`.

## Verification checklist

- [ ] Run `bash hw/chapter7/run_experiments.sh` in the Codespace with the official simulator present.
- [ ] Confirm all 13 output files appear in `hw/chapter7/data/` and compare their averages with the tables above.
- [ ] Commit and push `README.md`, `analysis.md`, `run_experiments.sh`, and `data/` to the user's repository.

