clear; clc;
fid = fopen('inputPart1.txt');
map = zeros(10,10);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end

    indexs = find(tline == ',');
    x = str2num(tline(1:indexs(1)-1))+1;
    y = str2num(tline(indexs(1)+1:end))+1;

    map(y,x) = 1;
end

fid2 = fopen('inputPart2.txt');
instruction = [0 0];
row = 0;
while 1
    tline = fgetl(fid2);
    if ~ischar(tline)
        break;
    end
    row = row + 1;
    indexs = find(tline == '=');
    axis = tline(1:indexs(1)-1);
    value = str2num(tline(indexs(1)+1:end))+1;

    if axis == 'x'
        axisN = 1;
    else
        axisN = 0;
    end
    instruction(row,1) = axisN;
    instruction(row,2) = value;
end

%%
for i=1:1
    axis = instruction(i,1);
    value = instruction(i,2);

    if axis %x
        [row,column] = size(map);
        newMap = zeros(row, value);
        newMap(1:row,1:value) = map(1:row,1:value);
        for k=value+1:column
            for j=1:row
                column2 = 2*value - k;
                newMap(j,column2) = min(newMap(j,column2) + map(j,k), 1);
            end
        end
        map = newMap;
    else %y
        [row,column] = size(map);
        newMap = zeros(value, column);
        newMap(1:value,1:column) = map(1:value,1:column);
        for k=value+1:row
            for j=1:column
                row2 = 2*value - k;
                newMap(row2,j) = min(newMap(row2,j) + map(k,j), 1);
            end
        end
        map = newMap;
    end
end