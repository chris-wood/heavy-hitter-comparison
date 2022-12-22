# Heavy Hitter Comparison


Running the notebook can be done as follows:

```
$ source MY_ENV/bin/activate 
$ python3 -m pip install pandas
```

# Exploratory Query Cost

To produce Poplar data:

1. Run `gen_params.py` to produce inputs for `poplar_bench_gen.py`. Copy these into the `poplar_bench_gen.py` script.
1. Run `poplar_bench_gen.py` to produce `poplar_bench.sh` inputs. Copy these into `poplar_bench.sh`. 
1. Clone the [reference implementation](https://github.com/henrycg/heavyhitters), copy `poplar_bench.sh` into the root directory, and then run `poplar_bench.sh` to completion.
1. Run `format_poplar_bench.py` with input `poplar_bench_out.txt` to produce the values copied into the notebook.

To produce STAR data:

1. Clone the [reference implementation](https://github.com/chris-wood/star-go).
1. Run `star_bench.sh` from the root directory of the repository.
1. Run `format_star_bench.py` with input `star_bench_out.txt` to produce the values copied into the notebook.