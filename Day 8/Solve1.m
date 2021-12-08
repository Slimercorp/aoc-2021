clear; clc;
fid = fopen('input.txt');
row = 0;
array = "bb";
array2 = "bb";
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    row = row + 1;
    
    indexs = find(tline == '|');
    part1 = tline(1:indexs(1)-2);
    part2 = tline(indexs(1)+2:end);
    
    for i=1:9
        indexs = find(part1 == ' ');
        array(row,i) = part1(1:(indexs(1)-1));
        part1(1:indexs(1)) = [];
    end
    
    array(row,10) = part1;
    
    for i=1:3
        indexs = find(part2 == ' ');
        array2(row,i) = part2(1:(indexs(1)-1));
        part2(1:indexs(1)) = [];
    end
    
    array2(row,4) = part2;
end

%0 - 6
%1 - 2
%2 - 5
%3 - 5
%4 - 4
%5 - 5
%6 - 6
%7 - 3
%8 - 7
%9 - 6

counter = 0;
for i=1:length(array2)
    for j=1:4
        if (strlength(array2(i,j)) == 2) || (strlength(array2(i,j)) == 4) || (strlength(array2(i,j)) == 3) || (strlength(array2(i,j)) == 7)
            counter = counter + 1;
        end
    end
end

counter