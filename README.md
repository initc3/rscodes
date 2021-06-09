# rscodes
Experimental Reed-Solomon codes for prototyping and learning purposes.

## Installation
Requires GMP, MPC, and MPFR for `gmpy2`, and NTL for `pyntl`.

On Debian/Ubuntu systems (use `sudo` for the commands that require it):

```shell
apt-get update
apt-get install --yes --no-install-recommends \
            libgmp-dev libmpc-dev libmpfr-dev libntl-dev
rm -rf /var/lib/apt/lists/*
```

For now, `pyntl` must be install from GitHub:

```shell
pip install git+https://github.com/initc3/pyntl.git
```

Install `rscodes` from GitHub:

```shell
pip install git+https://github.com/initc3/rscodes.git
```

Quick installation check:

```shell
python -c 'import rscodes; print(rscodes.version)'
```

It should output the version, such as:

```shell
0.0.0.dev0
```
