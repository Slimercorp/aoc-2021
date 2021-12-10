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
score = 0;
for i=1:row
    expect = getExpectedSymbol(lines{i}(1));
    for j=2:length(lines{i})
        symbol = lines{i}(j);
        [result, result2] = getExpectedSymbol(symbol);
        if ~result2 
            if symbol ~= expect(end)
                score = score + getScore(symbol);
                break;
            else
                expect(end) = [];
            end
        else
            expect = [expect; result];
        end
    end
end

score


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
            score = 3;
        case ']'
            score = 57;
        case '}'
            score = 1197;
        case '>'
            score = 25137;
        otherwise
            error();
    end
end
