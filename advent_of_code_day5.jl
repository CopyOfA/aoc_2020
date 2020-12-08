
x = readlines("advent_of_code/advent_of_code_day5.txt")


#part 1
ID = Array{Int64}(undef,length(x))
for ii in 1:length(x)
  rows = x[ii][1:7]
  cols = x[ii][8:end]
  r = collect(0:1:127)
  for row in rows
    f = Int64(length(r)/2)
    if row=='F'
      r = r[1:f]
    elseif row=='B'
      r = r[(f+1):end]
    end
  end

  c = collect(0:1:7)
  for col in cols
    f = Int64(length(c)/2)
    if col == 'L'
      c = c[1:f]
    elseif col == 'R'
      c = c[(f+1):end]
    end
  end

  id = r*8 + c
  global ID[ii] = id[1]

end
answer1 = maximum(ID)


#part 2
ID = sort(ID)
d = ID[2:end] - ID[1:end-1]
answer2 = findall(>(1), d)
