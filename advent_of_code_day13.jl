x = readlines("advent_of_code/advent_of_code_day13.txt");

##
#part 1
my_time, bus_times = parse(Int, x[1]), split(x[2],",")
bus_times = [parse(Int, ii) for ii in bus_times[findall(!=("x"), bus_times)]]

let
    count = 1
    while true
        new_time = my_time + count
        if any([mod(new_time, ii)==0 for ii in bus_times])
            global out = new_time
            break
        end
        count += 1
    end
end
bus_number = bus_times[findall(==(0), [mod(out, ii) for ii in bus_times])]
answer1 = (bus_number * (out - my_time))[1]
println(answer1)
##


##
#part 2
bus_times = split(x[2], ",")
offsets = findall(!=("x"), bus_times)
bus_times = parse.(Int, bus_times[offsets])
offsets = (offsets .- 1)

#tried to do this brute force, but not happening
# let
#     maxval = maximum(bus_times)
#     position = [ii for ii in 1:length(bus_times) if bus_times[ii]==maxval][1]
#     kk = 1
#     increment = 100
#     while true
#         vals = collect(kk*maxval:maxval:(kk+increment)*maxval) .- offsets[position]
#         A = hcat([vals .+ ii for ii in offsets]...)
#         B = mod.(A, transpose(bus_times)) .== 0
#         test = sum(B, dims=2).== length(offsets)
#         if any([ii == 1 for ii in test])
#             idx = [ii for ii in 1:length(test) if test[ii]==1]
#             global answer2 = A[idx,1]
#             break
#         end
#         kk += (increment+1)
#     end
# end

#chinese remainder theorem
p = prod(bus_times)
pp = Int.(p ./ bus_times)
invv = [invmod(pp[ii], bus_times[ii]) for ii in 1:length(bus_times)]
remainders = bus_times - offsets; remainders[1] = 0
answer2 = mod(sum(remainders.*pp.*invv),p)
##


## This is not mine, but a cool way of doing this
function reducecongruences((rhs1, mod1), (rhs2, mod2))
  (g, k, l) = gcdx(mod1, mod2)
  g == 1 || error("gcd of moduli is not one and I'm too lazy to deal with this")
  delta = rhs2 - rhs1
  rhs = delta * k * mod1 + rhs1
  @assert rhs == delta * (-l) * mod2 + rhs2
  m = mod1 * mod2
  return (mod(rhs, m), m)
end

function part2(timetable)
  congruences = Tuple{BigInt,BigInt}[]
  for (i, t) in enumerate(timetable)
    t isa Number || continue
    push!(congruences, (-(i-1), t)) # we want mod(solution + (i-1), t) = 0
  end
  return reduce(reducecongruences, congruences)[1]
end

times = [e == "x" ? e : parse(Int, e) for e in split(x[2], ",")]
println(part2(times))
##
