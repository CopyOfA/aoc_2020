x = readlines("advent_of_code/advent_of_code_day6.txt")

groups = insert!(findall(==(""), x),1, 0)


#part 1
function count_char(s)
    res = Dict{Char, Int}()
    for c in s
        res[c] = get(res, c, 0) + 1
    end
    return res
end

grps = Dict{Int, Dict}()
count = 0
for ii in 1:length(groups)-1
    s = join(x[(groups[ii]+1):groups[ii+1]-1], "")
    tmp = count_char(s)
    global count = count + length(tmp)
    global grps[ii] = tmp
end



#part 2
count = 0
for ii in 1:length(groups)-1
    n_ppl = groups[ii+1] - groups[ii] - 1
    s = join(x[(groups[ii]+1):groups[ii+1]-1], "")
    tmp = count_char(s)
    v = collect(values(tmp))
    n = sum([i == n_ppl for i in v])
    global count = count + n
end
