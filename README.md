# Rand and adjusted Rand index for MATLAB

[![MATLAB tests](https://github.com/cmccomb/rand_index/actions/workflows/tests.yml/badge.svg)](https://github.com/cmccomb/rand_index/actions/workflows/tests.yml)

`rand_index` measures agreement between two cluster assignments. It returns the
Rand index by default or the adjusted Rand index when passed `'adjusted'`.
Cluster IDs may differ between the two assignments; only the grouping matters.

```matlab
truth = [1 1 2 2];
prediction = [9 9 4 4];

rand_index(truth, prediction)             % 1
rand_index(truth, prediction, 'adjusted') % 1
```

Place `rand_index.m` on your MATLAB path and call it with two equally sized
vectors of finite, real numeric labels. At least two observations are required.
Integer cluster labels are recommended. The function also runs in GNU Octave.

The adjusted index corrects for agreement expected by chance. When both
partitions are identical but the adjustment has a zero denominator, the
function returns 1 by convention.

## Test

Run `test_rand_index` from this folder in MATLAB. The GitHub Actions workflow
runs the same checks on pushes and pull requests.

## Distribution

This project is also available as [Adjusted Rand Index on MATLAB File
Exchange](https://www.mathworks.com/matlabcentral/fileexchange/49908-adjusted-rand-index).
Releases and source code live in this repository.

## License

BSD 3-Clause. See [LICENSE](LICENSE).
