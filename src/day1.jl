using DelimitedFiles
# PART 1
# Normal person loop method
function part1_f1(data)
    c = 0
    prev = data[1]
    for el in data
        if el > prev
            c += 1
        end
        prev = el
    end
    return c
end

# # Not normal person memory intensive method (copy of array)
function part1_f2(data)
    data_c = copy(data)
    prepend!(data, data[1])
    append!(data_c, last(data))
    return size(filter(x -> x > 0, data_c - data))[1]
end

# Oh hey inbuilts!
function part1_f3(data)
    return sum(x -> x > 0, diff(data))
end


# PART 2
function part2_f1(data)
    n = size(data)[1]
    c = 0
    prev = sum(data[1:3])
    for i = 1:n-2
        val = sum(data[i:i+2])
        if val > prev
            c += 1
        end
        prev = val
    end
    return c
end

# We can do better - we are summing over stuff repeatedly which is a waste, we should just add and remove the first/last elements and leave the middle one alone
# In principle this is the same number of operations but we might save on allocations

function part2_f2(data)
    n = size(data)[1]
    c = 0
    prev = sum(data[1:3])
    val = prev
    for i = 2:n-2
        val += (data[i+2] - data[i-1])

        if val > prev
            c += 1
        end
        prev = val
    end
    return c
end

data = vec(readdlm("data/day1_data.txt"))
val = @time part1_f1(data)
println(val)

val = @time part1_f2(data)
println(val)

val = @time part1_f3(data)
println(val)


# PART 2
val = @time part2_f1(data)
println(val)

val = @time part2_f2(data)
println(val)
