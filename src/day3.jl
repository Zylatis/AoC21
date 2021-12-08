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

function most_common(binary_nums)
    nrows = size(binary_nums)[1]
    col_sum = sum(binary_nums, dims = 1)[1]
    gamma_binary = col_sum .> nrows/2
end

function most_common_col(col_data, tie_breaker)
    if sum(col_data) >= size(col_data)[1]/2
        return tie_breaker
    else return 0
    end
end

function part2_f1(data)
    data = [parse.(Int64, split(row, "")) for row in data]
    nrows= size(data)[1]
    ncols = size(data[1])[1]
    mat = zeros(Int64, (nrows, ncols))

    for i in 1:nrows
        for j in 1:ncols 
            mat[i,j] = data[i][j]
        end
    end

    temp_mat = copy(mat)
    for col in 1:ncols
        mc = most_common_col(temp_mat[:,col], 1)
        temp_mat = temp_mat[temp_mat[:,col].==mc,:]
    end
    oxygen = sum([reverse(temp_mat)[1,i]*2^(i-1) for i in 1:ncols])

    temp_mat = copy(mat)
    for col in 1:ncols
        lc = 1- most_common_col(temp_mat[:,col], 1)
        temp_mat = temp_mat[temp_mat[:,col].==lc,:]
        if size(temp_mat)[1] == 1
            break 
        end
    end
    co2 = sum([2^(i-1)*reverse(temp_mat)[1,i] for i in 1:ncols])

    println(oxygen)
    println(co2)

    println(co2*oxygen)
end


data = readdlm("data/day3_data.txt", String)

# val = @time part1_f1(data)
# println(val)

val = @time part2_f1(data)
# println(val)
