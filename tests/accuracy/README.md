# Accuracy Experiments

This folder holds the protocol and (later) the recorded results used to evaluate measurement
accuracy. **No results exist yet. Do not add estimated or invented numbers.** Every row must come
from a real test compared against a trusted reference measurement (tape, laser, etc.).

- Template: [EXPERIMENT_TEMPLATE.md](EXPERIMENT_TEMPLATE.md) (copy per session)
- Log: [results.csv](results.csv) (header only; append real rows)

Definitions:
- Absolute error = |measured − reference| (metres)
- Percentage error = absolute error / reference × 100

Repeat each target several times per device/condition to assess repeatability, and record
failures/rejections too, not only successes.
