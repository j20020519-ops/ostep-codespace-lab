# Chapter 7: CPU Scheduling

## Objective
Explore CPU scheduling policies using the OSTEP CPU scheduling simulator.

## Scheduling policies
- FIFO (First In, First Out)
- SJF (Shortest Job First)
- RR (Round Robin)

## Experiment setup
The example workload uses three jobs with service lengths 2, 5, and 8.
The random seed is 100.

## Commands

### FIFO
python3 ./ext/ostep-homework/cpu-sched/scheduler.py -p FIFO -j 3 -s 100 -c

### SJF
python3 ./ext/ostep-homework/cpu-sched/scheduler.py -p SJF -j 3 -s 100 -c

### Round Robin (quantum = 1)
python3 ./ext/ostep-homework/cpu-sched/scheduler.py -p RR -j 3 -s 100 -q 1 -c

## Note
These are example experiments. Check the official assignment instructions
to confirm whether additional questions or experiments are required.
