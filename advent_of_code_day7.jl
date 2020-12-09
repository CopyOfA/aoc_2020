x = readlines("advent_of_code/advent_of_code_day7.txt")

function make_dict(x)
    B = Dict{String, Dict{String, Int}}()
    for ii in 1:length(x)-1
        par, chil = split(x[ii], r"bags|bag", limit=2)
        par = strip(par)
        if occursin("no other", chil)
            B[par] = Dict("" => 0)
            continue
        else
            chil = replace(chil, "contain" => "")
            chil = replace(chil, r"[,.]" => "")
            chil = split(chil, r"bags|bag", keepempty=false)
        end
        tmp = Dict{String, Int}()
        for c in chil
            d = split(strip(c), limit=2)
            tmp[strip(d[2])] = parse(Int64,d[1])
        end
        B[par] = tmp
    end
    return B
end



#part 1
B = make_dict(x)
function contains_gold(bag,B)
    for k in keys(B[bag])
        if k == "shiny gold"
            return true
        elseif k == ""
            return false
        elseif contains_gold(k, B) == true
            return true
        end
    end
end

count = 0
for k in keys(B)
    if contains_gold(k,B) == true
        global count = count + 1
    end
end


#part 2
function num_bags(bag, D)
    count = 0
    for k in keys(D[bag])
        if k == ""
            return 0
        else
            count = count + D[bag][k]
            count = count + D[bag][k]*num_bags(k, D)
        end
    end
    return count
end

answer2 = num_bags("shiny gold", B)
