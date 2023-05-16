🧬 The ✨ new (_not-yet-official_) ✨ (Gene-) Set Enrichment Analysis.

💁 Join the [bioinformatics community](https://discord.gg/tKh7fguMrD) to get live help on GSEA (and everything bioinformatics) 🎪 ⌨️ 🔰 💡

## Use `gsea` command-line interface

#### Run single-sample GSEA

```bash
gsea data-rank
```

#### Run pre-rank GSEA

```bash
gsea user-rank
```

#### Run standard GSEA

```bash
gsea metric-rank
```

## Try with an example data

#### 1. Go to the directory with the example

```bash
cd test/sarcopenia

ls -l
```

#### 2. Make a directory for saving outputs

```bash
rm -rf output

mkdir output
```

#### 3. Run standard GSEA

```bash
gsea metric-rank setting.json target_x_sample_x_number.tsv feature_x_sample_x_number.tsv set_features.json output

ls -l output
```

#### 4. Look at the results

```bash
head -3 output/*.tsv

open output/plot/*.html
```

## Settings are just a [`.json` file](setting)

- `metric` for scoring and ranking features (for `metric-rank`)

  `signal_to_noise_ratio` (coming soon... | `mean_difference` | `median_difference` | `pearson_correlation` | `cosine_distance` | `information_coefficient`)

- `feature_name` (for `metric-rank` and `user-rank`)

  String

- `score_name` (for `metric-rank` and `user-rank`)

  String

- `low_text` (for `metric-rank` and `user-rank`)

  String

- `high_text` (for `metric-rank` and `user-rank`)

  String

- `minimum_set_size` that removes sets smaller than this

  Integer

- `maximum_set_size` that removes sets bigger than this

  Integer

- `exponent` to raise the scores

  Number

- `algorithm` for computing enrichment

  `ks` (_Kolmogorov Smirnov_) | `ksa` (`ks` area) | `kli` | `kliop` | `kliom`

- `number_of_jobs`

  Integer

- `permutation` for computing significance

  `sample` (for `metric-rank`) | `set` (for `metric-rank` and `user-rank`)

- `random_seed` (for `metric-rank` and `user-rank`)

  Integer

- `number_of_permutations` (for `metric-rank` and `user-rank`)

  Integer

- `number_of_sets_to_plot` (for `metric-rank` and `user-rank`)

  Integer

- `more_sets_to_plot` (for `metric-rank` and `user-rank`)

  List of strings (set names)

- `write_set_x_index_x_random_tsv` (for `metric-rank` and `user-rank`)

  Boolean

## Install

1. Download the latest [release](https://github.com/KwatMDPhD/GSEA.jl/releases/latest) and decompress it.

2. Add `gsea/bin` to the path.

3. Test installation

We plan to sign `gsea` in the near future. Meanwhile, enable 3rd-party apps on your macOS.

```bash
gsea --help
```

🎉

## Build

If installation is unavailable or fails, try building.

#### 1. Download this repository

Install `git-lfs`.

```bash
git clone https://github.com/KwatMDPhD/GSEA.jl
```

#### 2. Download dependencies

```bash
cd GSEA.jl &&

julia --project --eval "using Pkg; Pkg.instantiate()"
```

#### 3. Test before building

```bash
julia --project --eval "using Pkg; Pkg.test()"
```

#### 4. Build

```bash
julia --project deps/build.jl app tarball
```

☝️ makes `build` (and `gsea-*.tar.gz`).

Add `build/gsea/bin` to the path.

#### 5. Test build

```bash
gsea --help
```

🎊

---

## 👋 🤠 Howdy

To report a bug, request a feature, or leave a comment, just [submit an issue](https://github.com/KwatMDPhD/GSEA.jl/issues/new/choose).

Powered by https://github.com/KwatMDPhD/Kata.jl 🌝
