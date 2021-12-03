clear; clc;
fid = fopen('input.txt');
index = 0;
array = cell(1,1);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end

	index = index + 1;
    array{index,1} = tline;
end


%% oxygen

arrayCopy = array;
for i=1:12
    if length(arrayCopy) == 1
        break;
    end
    
    [bit, equal] = getMostBit(arrayCopy, i);
    if (equal)
        bit = '1';
    end
    
    indexToDelete = 0;
    k = 0;
    for j=1:length(arrayCopy)
        if arrayCopy{j}(i) ~= bit
            k = k + 1;
            indexToDelete(k) = j;
        end
    end
    
    arrayCopy(indexToDelete) = [];
end
oxygen = bin2dec(arrayCopy{1})

%% scrubber 

arrayCopy = array;
for i=1:12
    if length(arrayCopy) == 1
        break;
    end
    
    [bit, equal] = getMostBit(arrayCopy, i);
    if (bit == '1')
        bit = '0';
    else
        bit = '1';
    end
    
    if (equal)
        bit = '0';
    end
    
    indexToDelete = 0;
    k = 0;
    for j=1:length(arrayCopy)
        if arrayCopy{j}(i) ~= bit
            k = k + 1;
            indexToDelete(k) = j;
        end
    end
    
    arrayCopy(indexToDelete) = [];
end
scrubber = bin2dec(arrayCopy{1})

oxygen * scrubber

%%
function [bit, equal] = getMostBit(array, position)
    countOne = 0;
    lenArray = length(array);
    equal = false;
    for i=1:lenArray       
        if array{i}(position) == '1'
            countOne = countOne + 1;
        end
    end
    
    if countOne > (length(array)/2)
        bit = '1';
        equal = false;
    elseif countOne < (length(array)/2)
        bit = '0';
        equal = false;
    else
        bit = '1';
        equal = true;
    end

end