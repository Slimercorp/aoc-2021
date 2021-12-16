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

allPairs = struct;
for i=1:length(char(polymer))-1
    pair = char(polymer);
    pair = pair(i:i+1);

    if isfield(allPairs,pair)
        eval(['allPairs.' pair ' = allPairs.' pair ' + 1;']);
    else
        eval(['allPairs.' pair ' = 1;']);
    end
end

for i=1:40
    i
    allPairsTemp = struct;
    fields = fieldnames(allPairs);
    for j=1:length(fields)
        firstLetter = fields{j}(1);
        lastLetter = fields{j}(2);
        howMuch = eval(['allPairs.' fields{j}]);
        addChar = '';
        for k=1:length(rules)
            if rules(k,1) == string(fields{j})
                addChar = char(rules(k,2));
                break;
            end
        end

        if ~isempty(addChar)
            newPair = [firstLetter addChar];
            if isfield(allPairsTemp,newPair)
                eval(['allPairsTemp.' newPair ' = allPairsTemp.' newPair ' + howMuch;']);
            else
                eval(['allPairsTemp.' newPair ' = howMuch;']);
            end

            newPair = [addChar lastLetter];
            if isfield(allPairsTemp,newPair)
                eval(['allPairsTemp.' newPair ' = allPairsTemp.' newPair ' + howMuch;']);
            else
                eval(['allPairsTemp.' newPair ' = howMuch;']);
            end
        else
            if isfield(allPairsTemp,fields{j})
                eval(['allPairsTemp.' fields{j} ' = allPairsTemp.' fields{j} ' + howMuch;']);
            else
                eval(['allPairsTemp.' fields{j} ' = howMuch;']);
            end
        end
    end
    allPairs = allPairsTemp;
end


maxLetter = 0;
minLetter = inf;
for i='A':'Z'
    fields = fieldnames(allPairs);
    count = 0;
    for j=1:length(fields)

        if ~contains(fields{j}(1),i)
            continue;
        else
            count = count + eval(['allPairs.' fields{j}]);
        end
    end

    if count > maxLetter
        maxLetter = count;
    end

    if count < minLetter && count ~= 0
        minLetter = count;
    end

end

maxLetter - minLetter