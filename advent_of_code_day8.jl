x = readlines("advent_of_code/advent_of_code_day8.txt")

function do_command(x, acc, lines, l)
    if lines[l] == 0
        flag = true
        return acc, l, lines, flag
    else
        flag = false
    end
    command, amount = split(x[l])
    direction = split(amount, r"[0-9]", keepempty=false)[1]
    amount = parse(Int64,split(amount, direction, keepempty=false)[1])
    lines[l] = 0
    if command == "acc"
        acc = acc + (direction == "+")*amount - (direction == "-")*amount
        l = l + 1
    elseif command == "jmp"
        l = l + (direction == "+")*amount - (direction == "-")*amount
    elseif command == "nop"
        l = l + 1
    end
    return acc, l, lines, flag
end


#part 1
let
    acc = 0
    lines = collect(1:length(x)-1)
    l = 1
    flag = false
    for ii in 1:length(x)-1
        acc, l, lines, flag = do_command(x, acc, lines, l)
        if flag == true
            print(string(acc))
            break
        end
    end
end



#part 2
function fullRun(x)
    let
        acc = 0
        lines = collect(1:length(x)-1)
        l = 1
        flag = false
        for ii in 1:length(x)-1
            acc, l, lines, flag = do_command(x, acc, lines, l)
            if flag == true
                print(string(acc), "\n")
                break
            elseif l == length(x)
                print(string(acc), "\n")
                break
            end
        end
        return acc, flag
    end
end

idxs = findall(x -> occursin(r"nop|jmp", x), x)
for k in 1:length(idxs)
    x_new = copy(x)
    x_new[idxs[k]] = ifelse(x_new[idxs[k]] == "nop",
                            replace(x_new[idxs[k]], "nop" => "jmp"),
                            replace(x_new[idxs[k]], "jmp" => "nop"))
    out = fullRun(x_new)
    test = ifelse(out[2]==false, 1, 0)
    if test == 1
        print(out)
        break
    end
end
