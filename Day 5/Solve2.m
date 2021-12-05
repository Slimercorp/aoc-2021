clear; clc;
load('input.mat');
%%
maxxX = max(max(input(:,1), input(:,3)));
maxxY = max(max(input(:,2), input(:,4)));

minnX = min(min(input(:,1), input(:,3)));
minnY = min(min(input(:,2), input(:,4)));
array = zeros(maxxY, maxxX);
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
    else
        minX = min(input(i,1), input(i,3));
        maxX = max(input(i,1), input(i,3));
        minY = min(input(i,2), input(i,4));
        maxY = max(input(i,2), input(i,4));
        
        stepX = maxX - minX + 1;
        stepY = maxY - minY + 1;
        
        step = max(stepX, stepY);

        for j = 1:step
            if input(i,1) > input(i,3)
                xCoord = input(i,1) - j + 1;
            else
                xCoord = input(i,1) + j - 1;
            end
                
            if input(i,2) > input(i,4)
                yCoord = input(i,2) - j + 1;
            else
                yCoord = input(i,2) + j - 1;
            end
            
            array(yCoord, xCoord) = array(yCoord, xCoord) + 1;
        end
    end
end

summ = 0;
for i=1:maxxY
    for j=1:maxxX
        if (array(i,j) > 1)
            summ = summ + 1;
        end
    end
end

summ