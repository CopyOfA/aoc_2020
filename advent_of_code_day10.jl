x = readlines("advent_of_code/advent_of_code_day10.txt")
x1 = [parse(Int, ii) for ii in x[1:end-1]]


#part 1
diffs = insert!(diff(sort(x1)), 1, 1)
diffs = insert!(diffs, length(diffs)+1, 3)

answer1 = sum(diffs.==1) * sum(diffs.==3)



#part 2
let
    v = [1;0;0];
    for d = diffs
        if d == 1
            v = [1 1 1;
                 1 0 0;
                 0 1 0]*v;
        elseif d == 2
            v = [1 1 0;
                 0 0 0;
                 1 0 0]*v;
        else
            v = [1 0 0;
                 0 0 0;
                 0 0 0]*v;
        end
    end
    global p2 = v[1];
end
