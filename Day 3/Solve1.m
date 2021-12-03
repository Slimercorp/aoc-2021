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

result ='0';
result2 = '0';
for i=1:12
    countOne = 0;
    for j=1:length(array)        
        if array{j}(i) == '1'
            countOne = countOne + 1;
        end
    end
    
    if countOne > (length(array)/2)
        result(i) = '1';
        result2(i) = '0';
    else
        result(i) = '0';
        result2(i) = '1';
    end
end

gamma = bin2dec(result);
epsilon = bin2dec(result2);
gamma * epsilon
