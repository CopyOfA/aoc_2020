#part one
k = 0
for s in x1
  tmp = split(s, ": ")
  c = tmp[2]
  r = split(tmp[1], " ")
  letter = r[2][1]
  r = split(r[1], "-")
  r = [parse(Int64, i) for i in r]
  ct = count(i -> (i==letter[1]), c)
  if r[1] <= ct <= r[2]
    global k = k+1
  end
end

#part 2
k = 0
for s in x1
  tmp = split(s, ": ")
  c = tmp[2]
  r = split(tmp[1], " ")
  letter = r[2][1]
  r = split(r[1], "-")
  r = [parse(Int64, i) for i in r]
  idxs = [i for i in 1:length(c) if c[i]==letter]
  test = (r[1] in idxs) + (r[2] in idxs)
  if test == 1
    global k = k+1
  end
end
