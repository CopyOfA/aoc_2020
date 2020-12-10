x = readlines("advent_of_code/advent_of_code_day9.txt")
x1 = [parse(Int64, ii) for ii in x[1:end-1]]


#part 1
for ii in 26:length(x1)
    x2 = x1[(ii-25):(ii-1)]
    s = [ifelse(ii != jj, x2[ii] + x2[jj], nothing) for ii in 1:length(x2) for jj in 1:length(x2)]
    if ~any([x1[ii] == jj for jj in s])
        print(string("The index is: ", ii, "\n"))
        print(string("The number is: ", x1[ii], "\n"))
        global idx = ii
        break
    end
end


#part 2
let
    len = 1
    test = 0
    while test == 0
        for ii in 1:length(x1)
            if (ii + len) > length(x1)
                break
            end
            if any([idx == jj for jj in (ii:ii+len)])
                continue
            end

            if sum(x1[ii:ii+len]) == x1[idx]
                global answer2 = x1[ii:ii+len]
                test = 1
                break
            end
        end
        len += 1
    end
end

print(string("The sum is: ", minimum(answer2) + maximum(answer2)))
