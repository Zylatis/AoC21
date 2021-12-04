using DelimitedFiles

function part1_f1(data)
    position =[0 0]
    for row in eachrow(data)
        command, val = row
        if command == "forward"
            position[1]+=val
        elseif command == "down"
            position[2]+=val
        elseif command == "up"
            position[2]-=val
        end
    end
    prod(position)
end

function part1_f2(data)
    # Getting a lot of temporaries in eachrow() so let's just iterate like a bunch of noobs
    # Result: speedup and fewer allocs (~ order of mag)
    position =[0 0]
    dims = size(data)
    len = dims[1]
    for i in 1:dims[1]
        command = data[i]
        val = data[len+i]
        if command == "forward"
            position[1]+=val
        elseif command == "down"
            position[2]+=val
        elseif command == "up"
            position[2]-=val
        end
    end
    prod(position)
end


# Part 2
function part2_f1(data)
   
    coords =[0 0 0 ]
    dims = size(data)
    len = dims[1]
    for i in 1:dims[1]
        command = data[i]
        val = data[len+i]
        if command == "forward"
            coords[1]+=val
            coords[2] += val*coords[3]
        elseif command == "down"
            coords[3]+=val
        elseif command == "up"
            coords[3]-=val
        end
    end
    prod(coords[1:2])
end


data = readdlm("data/day2_data.txt")
val = @time part1_f1(data)
println(val)

val = @time part1_f2(data)
println(val)

val = @time part2_f1(data)
println(val)
