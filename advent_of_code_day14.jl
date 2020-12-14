x = readlines("advent_of_code/advent_of_code_day14.txt");

mask_lines = findall(x -> occursin("mask", x), x)

function parse_chunk(chunk)
    mask = reverse(split(chunk[1], " = ")[2])
    tmp = split.(chunk[2:end], " = ")
    locations = [split(split(ii[1], "[")[2], "]", keepempty=false)[1] for ii in tmp]
    locations = parse.(Int, locations)
    value = [parse(Int64, ii[2]) for ii in tmp]
    return mask, locations, value
end

function bit_array_to_int(arr, s=0)
    v = 1
    for ii in arr
        s += ii*v
        v <<= 1
    end
    return s
end


## part 1
let
    D = Dict{Int, Int}()
    for ii in 1:length(mask_lines)
        if ii < length(mask_lines)
            chunk = x[mask_lines[ii]:mask_lines[ii+1]-1]
        else
            chunk = x[mask_lines[ii]:end]
        end
        mask, locations, value = parse_chunk(chunk)
        change = findall(!=('X'), mask)
        for (jj,val) in enumerate(value)
            bin_value = digits(val, base=2, pad=36) #make 36 bit
            bin_value[change] = [parse(Int, m) for m in mask[change]]
            D[locations[jj]] = bit_array_to_int(bin_value)
        end
    end
    global out = D
end
answer1 = sum(out[k] for k in keys(out))
println(string("Answer for part 1: ", answer1))


## part 2
let
D = Dict{Int, Int}()
for ii in 1:length(mask_lines)
    if ii < length(mask_lines)
        chunk = x[mask_lines[ii]:mask_lines[ii+1]-1]
    else
        chunk = x[mask_lines[ii]:end]
    end
    mask,location,value = parse_chunk(chunk)
    vary = findall(==('X'), mask)
    n = length(vary)
    change = findall(==('1'), mask)
    for (jj, loc) in enumerate(location)
        l = digits(loc, base=2, pad=36)
        l[change] = [parse(Int, m) for m in mask[change]]
        binaries = [bitstring(v)[(end-n+1):end] for v in 0:(2^n -1)]
        binaries = hcat([[parse(Int, kk) for kk in b]
                                            for b in binaries]...)
        for c in 1:size(binaries,2)
            new_loc = copy(l)
            new_loc[vary] = binaries[:,c]
            D[bit_array_to_int(new_loc)] = value[jj]
        end
    end
end
global out = D
end
answer2 = sum(out[k] for k in keys(out))
