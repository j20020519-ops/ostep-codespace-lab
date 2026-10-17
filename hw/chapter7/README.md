# Chapter 7: CPU Scheduling

This submission answers the seven CPU-scheduling simulation questions at the end of OSTEP Chapter 7. It uses the official OSTEP `scheduler.py` simulator and stores reproducible `-c` outputs under `data/`.

## Files

- `analysis.md`: predictions, simulator results, explanations, and answers for Q1–Q7.
- `run_experiments.sh`: runs each fixed workload with the OSTEP simulator and writes the output files to `data/`.
- `data/`: populated by the script; includes the saved output for each experiment.

## Run in Codespaces

From the repository root, run:

```bash
bash hw/chapter7/run_experiments.sh
```

The script checks that the official simulator exists, then saves each run's complete output in `hw/chapter7/data/`. Review the outputs and the answers in `analysis.md` before committing.
