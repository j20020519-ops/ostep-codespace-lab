# Chapter 4: The Abstraction: The Process

## Question 1

Command:
`python3 process-run.py -l 5:100,5:100 -c -p`

Both processes use the CPU only and never perform I/O. Therefore, the CPU is busy for the entire execution.

Result:
- Total Time: 10
- CPU Busy: 10 (100.00%)
- IO Busy: 0 (0.00%)

The CPU utilization is 100%.

## Question 2

Command:
`python3 process-run.py -l 4:100,1:0 -c -p`

The first process runs for 4 CPU instructions. Then the second process issues an I/O operation and becomes blocked. Since there is no other ready process, the CPU remains idle while the I/O completes.

Result:
- Total Time: 11
- CPU Busy: 6 (54.55%)
- IO Busy: 5 (45.45%)

The CPU is idle during the I/O wait.

## Question 3

Command:
`python3 process-run.py -l 1:0,4:100 -c -p`

The first process immediately performs I/O and becomes blocked. The second process can then use the CPU while the first process is waiting for I/O.

Result:
- Total Time: 7
- CPU Busy: 6 (85.71%)
- IO Busy: 5 (71.43%)

The order of the processes matters because it determines whether CPU work can overlap with I/O.

## Question 4

Command:
`python3 process-run.py -l 1:0,4:100 -c -S SWITCH_ON_END`

With SWITCH_ON_END, the system does not switch to another process when the current process performs I/O. Therefore, the second process remains READY while the first process is blocked, and the CPU is idle until the I/O completes.

This results in worse CPU utilization than SWITCH_ON_IO.

## Question 5

Command:
`python3 process-run.py -l 1:0,4:100 -c -p -S SWITCH_ON_IO`

With SWITCH_ON_IO, the system switches to the second process immediately after the first process issues I/O. Therefore, the CPU can continue executing while the first process is waiting.

Result:
- Total Time: 7
- CPU Busy: 6 (85.71%)
- IO Busy: 5 (71.43%)

This is more efficient than SWITCH_ON_END because CPU work overlaps with I/O.

## Question 6

Command:
`python3 process-run.py -l 3:0,5:100,5:100,5:100 -S SWITCH_ON_IO -I IO_RUN_LATER -c -p`

With IO_RUN_LATER, a process whose I/O completes does not immediately run again. The CPU continues running another ready process.

Result:
- Total Time: 31
- CPU Busy: 21 (67.74%)
- IO Busy: 15 (48.39%)

The resources are not used as efficiently as possible because the CPU and I/O device are not kept busy at the same time as often as they could be.

## Question 7

Command:
`python3 process-run.py -l 3:0,5:100,5:100,5:100 -S SWITCH_ON_IO -I IO_RUN_IMMEDIATE -c -p`

With IO_RUN_IMMEDIATE, the process runs immediately when its I/O completes. This allows it to issue another I/O operation sooner while another process can later use the CPU.

Result:
- Total Time: 21
- CPU Busy: 21 (100.00%)
- IO Busy: 15 (71.43%)

Compared with IO_RUN_LATER, the total execution time decreases from 31 to 21 ticks. Immediate execution is beneficial because it improves overlap between CPU computation and I/O operations.

## Question 8

I tested random processes using different random seeds and scheduling behaviors.

For example:

Seed 1 with SWITCH_ON_IO and IO_RUN_LATER:

- Total Time: 15
- CPU Busy: 8 (53.33%)
- IO Busy: 10 (66.67%)

Seed 2 with SWITCH_ON_IO and IO_RUN_IMMEDIATE:

- Total Time: 16
- CPU Busy: 10 (62.50%)
- IO Busy: 14 (87.50%)

Seed 3 with SWITCH_ON_END and IO_RUN_LATER:

- Total Time: 24
- CPU Busy: 9 (37.50%)
- IO Busy: 15 (62.50%)

Seed 3 with SWITCH_ON_END and IO_RUN_IMMEDIATE:

- Total Time: 24
- CPU Busy: 9 (37.50%)
- IO Busy: 15 (62.50%)

The random seed changes the sequence of CPU and I/O instructions, so the execution trace can be different for each seed.

SWITCH_ON_IO generally provides better overlap because the CPU can switch to another process when the current process performs I/O. SWITCH_ON_END waits until the current process finishes, which can leave the CPU idle while the process is blocked.

IO_RUN_IMMEDIATE allows a process to run as soon as its I/O completes, while IO_RUN_LATER waits until it is naturally selected. IO_RUN_IMMEDIATE can reduce the total execution time and improve resource utilization when a process frequently performs I/O.
