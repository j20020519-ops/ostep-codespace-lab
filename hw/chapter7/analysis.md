# Chapter 7: CPU Scheduling Analysis

## 1. Experiment setup

The experiments use the OSTEP CPU scheduling simulator with:
- Number of jobs: 3
- Random seed: 100
- Job service lengths: 2, 5, and 8
- All jobs arrive at time 0

## 2. Results

| Policy | Quantum | Average Response | Average Turnaround | Average Waiting |
|---|---:|---:|---:|---:|
| FIFO | N/A | 3 | 8 | 3 |
| SJF | N/A | 3 | 8 | 3 |
| RR | 1 | 1 | 10 | 5 |

## 3. Analysis

### FIFO
FIFO runs jobs in arrival order. In this example, the jobs have service
lengths 2, 5, and 8, so the execution order is from shortest to longest.

### SJF
SJF runs the shortest available job first. Because the example jobs are
already ordered by increasing service length, the results match FIFO.

### Round Robin
Round Robin uses a time quantum of 1. It gives each job an opportunity
to run early, resulting in a lower average response time in this example.
However, its average turnaround and waiting times are higher than FIFO
and SJF for this workload.

## 4. Metric definitions

- Response time = first run time - arrival time.
- Turnaround time = completion time - arrival time.
- Waiting time = turnaround time - service time.

## 5. Conclusion

For this example workload, FIFO and SJF have the same average metrics
because the jobs are already ordered by service length. Round Robin
provides the lowest average response time, while FIFO and SJF provide
lower average turnaround and waiting times.

These results apply to this workload only. Additional experiments may
be required by the official assignment instructions.
