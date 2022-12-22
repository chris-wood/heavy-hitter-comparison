import json

input_lens = [32]
input_counts = [128]
sample_expansions = [2, 4, 6, 8, 10, 12, 14, 16]
threshold_fractions = [0.001, 0.01, 0.1]

for input_len in input_lens:
    for input_count in input_counts:
        for sample_expansion in sample_expansions:
            for threshold_fraction in threshold_fractions:
                config = {
                    "input_len": input_len,
                    "input_count": input_count,
                    "sample_expansion": sample_expansion,
                    "threshold_fraction": threshold_fraction,
                }
                print(json.dumps(config))
