x = split("5,1,9,18,13,8,0", ",")

function make_dict(x)
    D = Dict{Int, Array{Int}}(n => [ii,1] for (ii,n) in enumerate(parse.(Int, x[1:end-1])))
    return D
end

function both_parts(D, input, limit)
    D = copy(D)
    for ii in (length(D)+1):(limit -1)
        if haskey(D, input)
            D[input][2] += 1
            D[input][1],input = ii, (ii - D[input][1])
        else
            D[input] = [ii,1]
            input = 0
        end
    end
    return input
end


## part 1
A = make_dict(x)
start = parse(Int, x[end])
answer1 = both_parts(A, start, 2020)


## part 2
A = make_dict(x)
start = parse(Int, x[end])
answer2 = both_parts(A, start, 30000000)
