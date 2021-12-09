clear; clc;
fid = fopen('input.txt');
map = cell(1);
maxRow = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    maxRow = maxRow + 1;
    for i=1:length(tline)
        map{maxRow,i} = tline(i);
    end
    
end

%%
k = 0;
topBas = 0;

maxColumn = 100;
for i=1:maxRow
    i
    for j=1:maxColumn
        if (i-1)>=1
            up = str2num(map{i-1,j});
        else
            up = 9;
        end
        
        if (j-1)>=1
            left = str2num(map{i,j-1});
        else
            left = 9;
        end
        
        if (i+1)<=maxRow
            down = str2num(map{i+1,j});
        else
            down = 9;
        end
        
        if (j+1)<=maxColumn
            right = str2num(map{i,j+1});
        else
            right = 9;
        end
        
        value = str2num(map{i,j});
        
        if value<up && value<left && value<down && value<right
            [sizeTemp, ~] = getSize(map,i,j, maxRow, maxColumn, [i j]);
            sizeBas = 1 + sizeTemp;
            k = k + 1;
            topBas(k) = sizeBas;
        end
    end
end

topBas = sort(topBas, 'descend');
topBas(1) * topBas(2) * topBas(3)

%%
function [size, checkList] = getSize(map, i, j, maxRow, maxColumn, checkList)

    size = 0;
    if (i-1)>=1
        exist = checkDir(checkList, i-1, j);
        if ~exist
            up = str2num(map{i-1,j});
            if up ~= 9
                checkList = [checkList; [i-1 j]];
                [sizeTemp, checkListTemp] = getSize(map, i-1, j, maxRow, maxColumn, checkList);
                checkList = [checkList; checkListTemp];
                size = size + 1 + sizeTemp;
            end
        end
    end

    if (j-1)>=1
        exist = checkDir(checkList,i,j-1);
        if ~exist
            left = str2num(map{i,j-1});
            if left ~= 9
                checkList = [checkList; [i j-1]];
                [sizeTemp, checkListTemp] = getSize(map, i, j-1, maxRow, maxColumn, checkList);
                checkList = [checkList; checkListTemp];
                size = size + 1 + sizeTemp;
            end
        end
    end

    if (i+1)<=maxRow
        exist = checkDir(checkList, i+1, j);
        if ~exist
            down = str2num(map{i+1,j});
            if down ~= 9
                checkList = [checkList; [i+1 j]];
                [sizeTemp, checkListTemp] = getSize(map, i+1, j, maxRow, maxColumn, checkList);
                checkList = [checkList; checkListTemp];
                size = size + 1 + sizeTemp;
            end
        end
    end

    if (j+1)<=maxColumn
        exist = checkDir(checkList, i, j+1);
        if ~exist
            right = str2num(map{i,j+1});
            if (right ~= 9)
                checkList = [checkList; [i j+1]];
                [sizeTemp, checkListTemp] = getSize(map, i, j+1, maxRow, maxColumn, checkList);
                checkList = [checkList; checkListTemp];
                size = size + 1 + sizeTemp;
            end
        end
    end
end

function [exist] = checkDir(checkList, i, j)
    exist = false;
    if ~isempty(checkList)
        [row, ~] = size(checkList);
        for m=1:row
            if checkList(m,1) == i && checkList(m,2) == j
                exist = true;
                break;
            end
        end
    end
end