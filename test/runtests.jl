# ----------------------------------------------------------------------------------------------- #
TE = joinpath(tempdir(), "GSEA.test")

if isdir(TE)

    rm(TE, recursive = true)

    println("Removed $TE.")

end

mkdir(TE)

println("Made $TE.")

# ----------------------------------------------------------------------------------------------- #
using GSEA

using OnePiece

# ----------------------------------------------------------------------------------------------- #
da = joinpath(@__DIR__, "data")

st = joinpath(da, "set_genes.json")

# ----------------------------------------------------------------------------------------------- #
println("-"^99)

println("filter!")

println("-"^99)

se_fe_ = OnePiece.extension.dict.read(st)

co = copy(se_fe_)

GSEA.filter!(co, false, [], 33, 36)

println(keys(co))

@assert length(co) == 2

co = copy(se_fe_)

GSEA.filter!(co, true, ["SHH", "XIST"], 1, 5656)

println(co)

@assert length(co) == 2

# ----------------------------------------------------------------------------------------------- #
println("-"^99)

println("GSEA")

println("-"^99)

se = joinpath(dirname(@__DIR__), "settings.json")

println(OnePiece.extension.dict.read(se))

# ----------------------------------------------------------------------------------------------- #
sc = joinpath(da, "score.gene_x_sample.tsv")

# ----------------------------------------------------------------------------------------------- #
function print_extreme(da; n_ex = 3)

    println("First $n_ex")

    println(first(da, n_ex))

    println("Last $n_ex")

    println(last(da, n_ex))

end

# ----------------------------------------------------------------------------------------------- #
println("-"^99)

println("single_sample")

println("-"^99)

ou = joinpath(TE, "single_sample_gsea")

GSEA.single_sample(se, st, sc, ou)

println(readdir(ou))

en_se_sa = OnePiece.io.table.read(joinpath(ou, "enrichment.set_x_sample.tsv"))

println(size(en_se_sa))

print_extreme(en_se_sa)

# ----------------------------------------------------------------------------------------------- #
function print_output(ou)

    println(readdir(ou))

    fl_se_st = OnePiece.io.table.read(joinpath(ou, "float.set_x_statistic.tsv"))

    println(size(fl_se_st))

    print_extreme(fl_se_st)

end

# ----------------------------------------------------------------------------------------------- #
me = "score.gene_x_metric.tsv"

# ----------------------------------------------------------------------------------------------- #
println("-"^99)

println("pre_rank")

println("-"^99)

ou = joinpath(TE, "pre_rank_gsea")

GSEA.pre_rank(se, st, joinpath(da, me), ou)

print_output(ou)

# ----------------------------------------------------------------------------------------------- #
println("-"^99)

println("standard")

println("-"^99)

ou = joinpath(TE, "standard_gsea")

GSEA.standard(se, st, joinpath(da, "number.target_x_sample.tsv"), sc, ou)

sc_se_sa = OnePiece.io.table.read(joinpath(ou, me))

println(size(sc_se_sa))

print_extreme(sc_se_sa)

print_output(ou)

# ----------------------------------------------------------------------------------------------- #
if isdir(TE)

    rm(TE, recursive = true)

    println("Removed $TE.")

end
