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
        array(row,i) = string(sort(char(array(row,i))));
        part1(1:indexs(1)) = [];
    end
    
    array(row,10) = string(sort(char(part1)));
    
    for i=1:3
        indexs = find(part2 == ' ');
        array2(row,i) = part2(1:(indexs(1)-1));
        array2(row,i) = string(sort(char(array2(row,i))));
        part2(1:indexs(1)) = [];
    end
    
    array2(row,4) = string(sort(char(part2)));
end

%0 - 6
%1 - 2 detected
%2 - 5
%3 - 5
%4 - 4 detected
%5 - 5
%6 - 6
%7 - 3 detected
%8 - 7 detected
%9 - 6

counter = 0;
for i=1:length(array)
    one = "";
    four = "";
    seven = "";
    eight = "";
    for j=1:10
        if (strlength(array(i,j)) == 2)
            one = array(i,j);
        end
        
        if (strlength(array(i,j)) == 4)
            four = array(i,j);
        end
        
        if (strlength(array(i,j)) == 3)
            seven = array(i,j);
        end
        
        if (strlength(array(i,j)) == 7)
            eight = array(i,j);
        end        
    end
    
    for j=1:10
        if (strlength(array(i,j)) == 6) && contains(array(i,j),four{1}(1)) && contains(array(i,j),four{1}(2)) && contains(array(i,j),four{1}(3)) && contains(array(i,j),four{1}(4))
            nine = array(i,j);
            break;
        end
    end    
    for j=1:10
        if (strlength(array(i,j)) == 6) && contains(array(i,j),one{1}(1)) && contains(array(i,j),one{1}(2)) &&  array(i,j) ~= nine
            zero = array(i,j);
            break;
        end
    end
    for j=1:10
        if (strlength(array(i,j)) == 5) && contains(array(i,j),one{1}(1)) && contains(array(i,j),one{1}(2))
            three = array(i,j);
            break;
        end
    end
    
    for j=1:10
        if (strlength(array(i,j)) == 6) && array(i,j) ~= nine && array(i,j) ~= zero
            six = array(i,j);
            break;
        end
    end
    
    if contains(six,one{1}(1))
        fiveHasLetter = one{1}(1);
        for j=1:10
            if (strlength(array(i,j)) == 5) && array(i,j) ~= three && contains(array(i,j),fiveHasLetter)
                five = array(i,j);
            end
        end
        
        for j=1:10
            if (strlength(array(i,j)) == 5) && array(i,j) ~= three && array(i,j) ~= five
                two = array(i,j);
            end
        end
    else
        twoHasLetter = one{1}(1);
        for j=1:10
            if (strlength(array(i,j)) == 5) && array(i,j) ~= three && contains(array(i,j),twoHasLetter)
                two = array(i,j);
            end
        end
        
        for j=1:10
            if (strlength(array(i,j)) == 5) && array(i,j) ~= three && array(i,j) ~= two
                five = array(i,j);
            end
        end
    end 
    
    digit = 0;
    for j = 1:4
        switch (array2(i,j))
            case zero
                digit = digit + 0 * 10^(4 - j);
            case one
                digit = digit + 1 * 10^(4 - j);
            case two
                digit = digit + 2 * 10^(4 - j);
            case three
                digit = digit + 3 * 10^(4 - j);
            case four
                digit = digit + 4 * 10^(4 - j);
            case five
                digit = digit + 5 * 10^(4 - j);
            case six
                digit = digit + 6 * 10^(4 - j);
            case seven
                digit = digit + 7 * 10^(4 - j);
            case eight
                digit = digit + 8 * 10^(4 - j);
            case nine
                digit = digit + 9 * 10^(4 - j);
            otherwise
                gfhgf = 1;
        end
    end
    
    counter = counter + digit;
end

counter