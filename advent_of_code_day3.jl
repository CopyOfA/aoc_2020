x = readlines("advent_of_code/advent_of_code_day3.txt")


#part 1
k = 1
count = 0
for ii in x[2:length(x)]
  global k = k + 3
  if k > length(ii)
    global k = k - length(ii)
  end
  c = ii[k]
  if c == '#'
    global count = count + 1
  end
end




#part 2
slopes = [[1,1],
          [3,1],
          [5,1],
          [7,1],
          [1,2]]
out = Array{Int64}(undef,size(slopes,1))
ii = 0
for s in 1:size(slopes,1)
  global ii = ii + 1
  row_inc = slopes[s,1][2]
  col_inc = slopes[s,1][1]
  r = 1 + row_inc
  c = 1 + col_inc
  count = 0
  while r <= length(x)
    test = x[r][c]
    if test == '#'
      count = count + 1
    end
    c = c + col_inc
    if c > length(x[r])
      c = c - length(x[r])
    end
    r = r + row_inc
  end
  global out[ii] = count
end
