clear; clc;
fid = fopen('inputPart1.txt');
polymer = string.empty;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    polymer = string(tline);
end

fid2 = fopen('inputPart2.txt');
rules = [string.empty string.empty];
row = 0;
while 1
    tline = fgetl(fid2);
    if ~ischar(tline)
        break;
    end
    row = row + 1;

    indexs = find(tline == '-');
    rules(row,1) = string(tline(1:indexs(1)-2));
    rules(row,2) = string(tline(indexs(1)+3:end));
end

for i=1:40
    newPolymer = '';
    i
    for j=1:length(char(polymer))-1
        pair = char(polymer);
        firstLetter = pair(j);
        pair = string(pair(j:j+1));
        addChar = '';
        for k=1:length(rules)
            if rules(k,1) == pair
                addChar = char(rules(k,2));
                break;
            end
        end
        newPolymer = [newPolymer firstLetter addChar];
    end
    pair = char(polymer);
    newPolymer = [newPolymer pair(end)];
    polymer = newPolymer;
end

maxLetter = 0;
minLetter = inf;
for i='A':'Z'
    polymerChar = char(polymer);
    counter = 0;
    for j=1:length(polymerChar)
        if (polymerChar(j) == i)
            counter = counter + 1;
        end
    end

    if counter > maxLetter
        maxLetter = counter;
        maxLetter2 = i;
    end

    if counter < minLetter && counter ~= 0
        minLetter = counter;
        minLetter2 = i;
    end
end

maxLetter - minLetter