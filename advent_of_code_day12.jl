x = readlines("advent_of_code/advent_of_code_day12.txt");

#part 1
function move(x, idx, location, compass)
    direction, amount = x[idx][1], parse(Int, x[idx][2:end])
    if (direction == 'F')
        direction = compass[1];
    elseif (direction == 'R')
        circshift!(compass, copy(compass), -amount/90);
    elseif (direction == 'L')
        circshift!(compass, copy(compass), amount/90);
    end
    if (direction == 'N')
        location[2] += amount
    elseif (direction == 'S')
        location[2] -= amount
    elseif (direction == 'E')
        location[1] += amount
    elseif (direction == 'W')
        location[1] -= amount
    end
    return location, compass
end

let
    location = [0,0]
    direction = 'E'
    compass = ['E', 'S', 'W', 'N']
    for ii in 1:length(x)-1
        location, compass = move(x, ii, location, compass)
    end
    global answer1 = location
end
print(string("Total distance: ", sum(abs, answer1)))



#part 2
function move_waypoint(x, idx, location, compass, waypoint)
    direction, amount = x[idx][1], parse(Int, x[idx][2:end])
    if (direction == 'F')
        d = waypoint - location
        location += amount*d
        waypoint = location + d
    elseif (direction == 'R')
        d = waypoint - location
        rotMat = ((amount==90)*[0 1;-1 0]) +
                    ((amount==180)*[-1 0;0 -1]) +
                    ((amount==270)*[0 -1;1 0])
        waypoint = location + rotMat * d
    elseif (direction == 'L')
        d = waypoint - location
        rotMat = ((amount==90)*[0 -1;1 0]) +
                    ((amount==180)*[-1 0;0 -1]) +
                    ((amount==270)*[0 1;-1 0])
        waypoint = location + rotMat * d
    elseif (direction == 'N')
        waypoint[2] += amount
    elseif (direction == 'S')
        waypoint[2] -= amount
    elseif (direction == 'E')
        waypoint[1] += amount
    elseif (direction == 'W')
        waypoint[1] -= amount
    end
    return location, compass, waypoint
end

let
    location = [0,0]
    waypoint = [10,1]
    compass = ['E','S','W','N']
    for ii in 1:length(x)-1
        location, compass, waypoint = move_waypoint(x, ii, location, compass, waypoint)
    end
    global answer2 = location, waypoint
end
