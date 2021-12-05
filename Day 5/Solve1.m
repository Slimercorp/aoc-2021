clear; clc;
load('input.mat');
%%
maxX = max(max(input(:,1), input(:,3)));
maxY = max(max(input(:,2), input(:,4)));

minX = min(min(input(:,1), input(:,3)));
minY = min(min(input(:,2), input(:,4)));
array = zeros(maxY, maxX);
%%
for i=1:length(input)
    onlyY = input(i,1) == input(i,3);
    onlyX = input(i,2) == input(i,4);
    if (onlyX || onlyY)
        if onlyX
            if input(i,1) < input(i,3)
                array(input(i,2), input(i,1):input(i,3)) = array(input(i,2), input(i,1):input(i,3)) + 1;
            else
                array(input(i,2), input(i,3):input(i,1)) = array(input(i,2), input(i,3):input(i,1)) + 1;                
            end
        else
            if input(i,2) < input(i,4)
                array(input(i,2):input(i,4), input(i,1)) = array(input(i,2):input(i,4), input(i,1)) + 1;
            else
                array(input(i,4):input(i,2), input(i,1)) = array(input(i,4):input(i,2), input(i,1)) + 1;                
            end
        end
    end
end

summ = 0;
for i=1:maxY
    for j=1:maxX
        if (array(i,j) > 1)
            summ = summ + 1;
        end
    end
end

summ