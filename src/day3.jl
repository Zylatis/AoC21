using DelimitedFiles

function part1_f1(data)

    data = [parse.(Int64, split(row, "")) for row in data]
    nrows = size(data)[1]

    col_sum = sum(data, dims = 1)[1]
    gamma_binary = col_sum .> nrows/2
    epsilon_binary = gamma_binary .== 0

    gamma_dec = reinterpret(Int64, (reverse(gamma_binary)).chunks)[1]
    epsilon_dec = reinterpret(Int64, (reverse(epsilon_binary)).chunks)[1]
    gamma_dec*epsilon_dec
end

data = readdlm("data/day3_data.txt", String)

val = @time part1_f1(data)
println(val)