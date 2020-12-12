x = readlines("advent_of_code/advent_of_code_day11.txt")

compliments = Dict('L' => 0, '#' => 1, '.' => -1)

X = zeros(Int, length(x)-1, length(x[1]));
for ii in 1:length(x)-1
    global X[ii,:] = [compliments[c] for c in x[ii]]
end


#part 1
function run_until_no_change(X)
    let
        X = copy(X)
        steps = 0
        while true
            steps += 1
            change = copy(X);
            Xm1 = copy(X);
            if sum((X .==0) + (X.==-1)) == length(X)
                X[X.==0] .= 1
                continue
            end
            for ii in 1:size(X)[1]
                if ii == 1
                    r = [0,1]
                elseif ii == size(X)[1]
                    r = [-1,0]
                else
                    r = [-1,0,1]
                end
                for jj in 1:size(X)[2]
                    if jj == 1
                        c = [0,1]
                    elseif jj == size(X)[2]
                        c = [-1,0]
                    else
                        c = [-1,0,1]
                    end
                    if X[ii,jj] == -1
                        change[ii,jj] = -1
                        continue
                    end
                    v = [X[ii+kk,jj+tt] for kk in r for tt in c if ~((kk==0) & (tt==0))]
                    empty = sum([kk==0 for kk in v] + [kk==-1 for kk in v]) == length(v)
                    filled = (sum([kk==1 for kk in v]) >= 4)
                    if empty & (X[ii,jj] == 0)
                        change[ii, jj] = 1
                    elseif filled & (X[ii,jj] == 1)
                        change[ii,jj] = 0
                    end
                end
            end
            X = copy(change)
            cond = (sum(Xm1 .- X) == 0)
            if (cond == true)
                a = sum(X .== 1)
                break
            end
        end
        return sum(X .== 1), steps
    end
end

answer1 = run_until_no_change(X)




#part 2
function look_right(X, r, c)
    idx = findfirst(!=(-1), X[r, c+1:end])
    if isnothing(idx)
        return false
    else
        return X[r, c+idx] == 1
    end
end
function look_left(X, r, c)
    idx = findlast(!=(-1), X[r, 1:c-1])
    if isnothing(idx)
        return false
    else
        return X[r, idx] == 1
    end
end
function look_up(X, r, c)
    idx = findlast(!=(-1), X[1:r-1, c])
    if isnothing(idx)
        return false
    else
        return X[idx, c] == 1
    end
end
function look_down(X, r, c)
    idx = findfirst(!=(-1),X[r+1:end,c])
    if isnothing(idx)
        return false
    else
        return X[idx + r, c] == 1
    end
end
function look_diagonal_up_right(X, r, c)
    idx = findfirst(!=(-1), [X[r-kk, c+kk] for kk in 1:min(size(X,2)-c, r-1)])
    if isnothing(idx)
        return false
    else
        return X[r-idx, c + idx]==1
    end
end
function look_diagonal_up_left(X, r, c)
    idx = findfirst(!=(-1), [X[r-kk, c-kk] for kk in 1:min(c-1, r-1)])
    if isnothing(idx)
        return false
    else
        return X[r-idx, c-idx]==1
    end
end
function look_diagonal_down_right(X, r, c)
    idx = findfirst(!=(-1),[X[r+kk, c+kk] for kk in 1:min(size(X,2)-c, size(X,1)-r)])
    if isnothing(idx)
        return false
    else
        return X[r+idx, c+idx]==1
    end
end
function look_diagonal_down_left(X, r, c)
    idx = findfirst(!=(-1),[X[r+kk, c-kk] for kk in 1:min(c-1, size(X,1)-r)])
    if isnothing(idx)
        return false
    else
        return X[r+idx, c-idx]==1
    end
end
function run_once(X)
    let
change = copy(X)
for ii in 1:size(X)[1]
    # print(string(ii, "\n"))
    for jj in 1:size(X)[2]
        # print(string(jj, " "))
        if X[ii,jj] == -1
            continue
        end
        if (1<ii<size(X,1)) & (1<jj<size(X,2))
            up = look_up(X, ii, jj)
            down = look_down(X, ii, jj)
            left = look_left(X, ii, jj)
            right = look_right(X, ii, jj)
            d_UR = look_diagonal_up_right(X, ii, jj)
            d_UL = look_diagonal_up_left(X, ii, jj)
            d_DL = look_diagonal_down_left(X, ii, jj)
            d_DR = look_diagonal_down_right(X, ii, jj)
            empty = sum([~up, ~down, ~left, ~right, ~d_UR, ~d_UL, ~d_DL, ~d_DR]) == 8
            filled = sum([up, down, left, right, d_UR, d_UL, d_DL, d_DR]) >= 5
        elseif (ii==1) & (1<jj<size(X,2))
            right = look_right(X, ii, jj)
            left = look_left(X, ii, jj)
            down = look_down(X, ii, jj)
            d_DR = look_diagonal_down_right(X, ii, jj)
            d_DL = look_diagonal_down_left(X, ii, jj)
            empty = sum([~down, ~left, ~right, ~d_DL, ~d_DR]) == 5
            filled = sum([down, left, right, d_DL, d_DR]) >= 5
        elseif (1<ii<size(X,1)) & (jj==1)
            up = look_up(X, ii, jj)
            down = look_down(X, ii, jj)
            right = look_right(X, ii, jj)
            d_DR = look_diagonal_down_right(X, ii, jj)
            d_UR = look_diagonal_up_right(X, ii, jj)
            empty = sum([~up, ~down, ~right, ~d_UR, ~d_DR]) == 5
            filled = sum([up, down, right, d_UR, d_DR]) >= 5
        elseif (1<ii<size(X,1)) & (jj==size(X,2))
            up = look_up(X, ii, jj)
            down = look_down(X, ii, jj)
            left = look_left(X, ii, jj)
            d_UL = look_diagonal_up_left(X, ii, jj)
            d_DL = look_diagonal_down_left(X, ii, jj)
            empty = sum([~up, ~down, ~left, ~d_UL, ~d_DL]) == 5
            filled = sum([up, down, left, d_UL, d_DL]) >= 5
        elseif (ii==size(X,1)) & (1<jj<size(X,2))
            up = look_up(X, ii, jj)
            left = look_left(X, ii, jj)
            right = look_right(X, ii, jj)
            d_UL = look_diagonal_up_left(X, ii, jj)
            d_UR = look_diagonal_up_right(X, ii, jj)
            empty = sum([~up, ~left, ~right, ~d_UR, ~d_UL]) == 5
            filled = sum([up, left, right, d_UR, d_UL]) >= 5
        elseif (ii==1) & (jj==size(X,2))
            left = look_left(X, ii, jj)
            down = look_down(X, ii, jj)
            d_DL = look_diagonal_down_left(X, ii, jj)
            empty = sum([~down, ~left, ~d_DL]) == 3
            filled = sum([down, left, d_DL]) >= 5
        elseif (ii==size(X,1)) & (jj == 1)
            up = look_up(X, ii, jj)
            right = look_right(X, ii, jj)
            d_UR = look_diagonal_up_right(X, ii, jj)
            empty = sum([~up, ~right, ~d_UR]) == 3
            filled = sum([up, right, d_UR]) >= 5
        elseif (ii==size(X,1)) & (jj==size(X,2))
            up = look_up(X, ii, jj)
            left = look_left(X, ii, jj)
            d_UL = look_diagonal_up_left(X, ii, jj)
            empty = sum([~up, ~left, ~d_UL]) == 3
            filled = sum([up, left, d_UL]) >= 5
        elseif ii == jj == 1
            right = look_right(X, ii, jj)
            down = look_down(X, ii, jj)
            d_DR = look_diagonal_down_right(X, ii, jj)
            empty = sum([~down, ~right, ~d_DR]) == 3
            filled = sum([down, right, d_DR]) >= 5
        end
        if empty & (X[ii,jj] == 0)
            change[ii, jj] = 1
        elseif filled & (X[ii,jj] == 1)
            change[ii,jj] = 0
        end
    end
end
return change
end
end

function run_until_finished(X)
    let
        steps = 0
        while true
            Xm1 = copy(X)
            X = run_once(X)
            cond = sum(X .- Xm1) == 0
            steps += 1
            if (cond == true)
                return X, steps
                break
            end
        end

    end
end

answer2 = run_until_finished(X)
