x = readlines("advent_of_code/advent_of_code_day16.txt")

idxs = findall(==(""), x)

fields = x[1:(idxs[1]-1)]
my_ticket = x[idxs[1]+2:(idxs[2]-1)]
nearby = x[idxs[2]+2:end]


## part 1
function get_valid_nums(fields)
    valids = split.(fields, r"^[a-z ]+: ", keepempty=false)
    valids = [split(replace(ii[1], r"\D+" => " "), " ") for ii in valids]
    S = Set{Int}()
    for (ii,entry) in enumerate(valids)
        r = parse.(Int, entry)
        S = union(Set(r[1]:r[2]), Set(r[3]:r[4]), S)
    end
    return S
end

v = get_valid_nums(fields)
function part1(valid_nums, nearby)
    s = 0
    tickets = zeros(Int, length(nearby))
    for (ii,entry) in enumerate(nearby)
        l = parse.(Int, split(entry,","))
        d = setdiff(l, v)
        s += sum(d)
        tickets[ii] = 1*(length(d)>0)
    end
    return s,tickets
end
answer1, invalids = part1(v, nearby)


## part 2
function get_field_ranges(fields)
    tmp = [split(ii, ": ") for ii in fields]
    field_names,valids = [ii[1] for ii in tmp],[ii[2] for ii in tmp]
    valids = [split(replace(ii, r"\D+" => " "), " ") for ii in valids]
    D = Dict{String,Set}()
    for (ii,f) in enumerate(field_names)
        r = parse.(Int, valids[ii])
        D[f] = union(Set(r[1]:r[2]), Set(r[3]:r[4]))
    end
    return D
end

function part2(invalids,fields)
    nearby_filt = nearby[invalids.==0]
    N = hcat([parse.(Int, split(ii, ",")) for ii in nearby_filt]...)
    n = size(N,1)
    D = get_field_ranges(fields)
    places = fill("",20)
    c = 1
    while true
        this_one = [k for k in keys(D) if
                        sum([length(setdiff(N[ii,:], D[k])).==0
                        for ii in 1:size(N,1)])==c]
        r = findall(!=(""), places)
        test = zeros(size(N,1))
        rows = setdiff(1:n, r)
        for row in rows
            test[row] = length(setdiff(N[row,:], D[this_one[1]])) == 0
        end
        if sum(test .== 1) == 1
            r = findall(==(1), test)
            places[r[1]] = this_one[1]
            if all([ii != "" for ii in places])
                break
            end
            c = length(findall(!=(""), places)) + 1
        end
    end
    return places
end

field_names = part2(invalids, fields)
answer2 = prod(parse.(Int, split(my_ticket[1], ","))[findall(x -> occursin("departure", x), field_names)])
