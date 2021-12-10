clear; clc;
fid = fopen('input.txt');
lines = cell(1);
row = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    row = row + 1;
    lines{row,1} = tline;
end

%%
corruptedLines = 0;
counter = 0;
for i=1:row
    [expect,~] = getExpectedSymbol(lines{i}(1));
    for j=2:length(lines{i})
        symbol = lines{i}(j);
        [result, result2] = getExpectedSymbol(symbol);
        if ~result2 
            if symbol ~= expect(end)
                counter = counter + 1;
                corruptedLines(counter) = i;
                break;
            else
                expect(end) = [];
            end
        else
            expect = [expect; result];
        end
    end
end

%cleaning
for i=counter:-1:1
    lines(corruptedLines(i)) = [];
end

%% finish line
for i=1:length(lines)
    [expect,~] = getExpectedSymbol(lines{i}(1));
    for j=2:length(lines{i})
        symbol = lines{i}(j);
        [result, result2] = getExpectedSymbol(symbol);
        if ~result2 
            expect(end) = [];
        else
            expect = [expect; result];
        end
    end
    
    score = 0;
    for j=length(expect):-1:1
        score = score * 5 + getScore(expect(j));
    end
    table(i,1) = score;
    
    
end

median(table)

%%
function [result, result2] = getExpectedSymbol(input)
    result2 = true;
    switch input
        case '('
            result = ')';
        case '['
            result = ']';
        case '{'
            result = '}';
        case '<'
            result = '>';
        otherwise
            result2 = false;
            result = '';
    end
end


function score = getScore(input)
    switch input
        case ')'
            score = 1;
        case ']'
            score = 2;
        case '}'
            score = 3;
        case '>'
            score = 4;
        otherwise
            error();
    end
end

