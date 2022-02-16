function compare_and_sort(bi_, ma, me, fe_)

    reverse(
        OnePiece.extension.vector.sort_like(
            OnePiece.feature_x_sample.compare_with_target(bi_, ma, me),
            fe_,
        ),
    )

end

"""
Run standard GSEA

# Arguments

  - `settings_json`:
  - `set_genes_json`:
  - `target_x_sample_tsv`:
  - `gene_x_sample_tsv`:
  - `output_directory`:
"""
@cast function standard(
    settings_json,
    set_genes_json,
    target_x_sample_tsv,
    gene_x_sample_tsv,
    output_directory,
)

    ke_ar = OnePiece.extension.dict.read(settings_json)

    sc_ta_sa = OnePiece.io.table.read(target_x_sample_tsv)

    sc_fe_sa = OnePiece.io.table.read(gene_x_sample_tsv)

    fe_ = string.(sc_fe_sa[:, 1])

    sc_fe_sa = sc_fe_sa[:, names(sc_ta_sa)]

    bi_ = BitVector(sc_ta_sa[1, :])

    ma = Matrix(sc_fe_sa)

    me = ke_ar["metric"]

    fe_, sc_ = compare_and_sort(bi_, ma, me, fe_)

    mkpath(output_directory)

    OnePiece.io.table.write(
        joinpath(output_directory, "score.gene_x_metric.tsv"),
        DataFrame("Gene" => fe_, me => sc_),
    )

    se_fe_ = OnePiece.extension.dict.read(set_genes_json)

    filter!(
        se_fe_,
        ke_ar["remove_gene_set_genes"],
        fe_,
        ke_ar["minimum_gene_set_size"],
        ke_ar["maximum_gene_set_size"],
    )

    sy_ar = make_keyword_argument(ke_ar)

    pe = ke_ar["permutation"]

    ra = ke_ar["random_seed"]

    n_pe = ke_ar["number_of_permutations"]

    n_ex = ke_ar["number_of_extreme_gene_sets_to_plot"]

    se_ = ke_ar["gene_sets_to_plot"]

    if pe == "sample"

        se_en = OnePiece.feature_set_enrichment.score_set(fe_, sc_, se_fe_; sy_ar...)


        if 0 < n_pe

            println("Permuting $(pe)s to compute significance")

            Random.seed!(ra)

            se_ra__ = [
                OnePiece.feature_set_enrichment.score_set(
                    compare_and_sort(shuffle!(bi_), ma, me, fe_)...,
                    se_fe_;
                    sy_ar...,
                ) for id in ProgressBar(1:n_pe)
            ]

        else

            se_ra__ = []

        end

        fl_se_st = make_set_x_statistic(se_en, se_ra__, output_directory)

        plot_mountain(fl_se_st, n_ex, se_, fe_, sc_, se_fe_, sy_ar, output_directory)

        fl_se_st

    elseif pe == "set"

        pre_rank(fe_, sc_, se_fe_, sy_ar, ra, n_pe, n_ex, se_, output_directory)

    else

        error("`permutation` is invalid.")

    end

end
