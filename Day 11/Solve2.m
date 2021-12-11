clear; clc;
fid = fopen('input.txt');
sizee = 10;
map = zeros(sizee,sizee);
row = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    row = row + 1;
    for i=1:length(tline)
        map(row,i) = str2num(tline(i));
    end
    
end

%%
step = inf;
for k=1:600
    flashMap = zeros(sizee,sizee);
    map = map + 1;
    %search >9
    thereWasFlashing = true;
    while thereWasFlashing
        thereWasFlashing = false;
        for i=1:sizee
            for j=1:sizee
                if map(i,j) > 9 && flashMap(i,j) ~= 1
                    map = transferEnergy(map,i,j, sizee);
                    map(i,j) = map(i,j) + 1;
                    flashMap(i,j) = 1;
                    thereWasFlashing = true;
                end
            end
        end
    end

    %clean
    for i=1:sizee
        for j=1:sizee
            if map(i,j) > 9
                map(i,j) = 0;
            end
        end
    end
    
    if sum(sum(flashMap)) == 100
        k
        break;
    end
end
 

function [map] = transferEnergy(map,i,j, sizee)
    %up-left
    row = i - 1;
    column = j -1;
    if row > 0 && column > 0
        map(row,column) = map(row,column) + 1;
    end
    
    % up
    row = i - 1;
    column = j;
    if row > 0
        map(row,column) = map(row,column) + 1;
    end
    
    % up-right
    row = i - 1;
    column = j + 1;
    if row > 0 && column <=sizee
        map(row,column) = map(row,column) + 1;
    end
    
   % left
    row = i;
    column = j - 1;
    if column > 0
        map(row,column) = map(row,column) + 1;
    end
    
    % right
    row = i;
    column = j + 1;
    if column <=sizee
        map(row,column) = map(row,column) + 1;
    end
     
    % down-left
    row = i+1;
    column = j - 1;
    if row <= sizee && column >0
        map(row,column) = map(row,column) + 1;
    end
    
    % down
    row = i+1;
    column = j;
    if row <= sizee
        map(row,column) = map(row,column) + 1;
    end
    
    % down-right
    row = i+1;
    column = j + 1;
    if row <= sizee && column <= sizee
        map(row,column) = map(row,column) + 1;
    end    
end