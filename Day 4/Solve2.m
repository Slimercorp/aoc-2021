% tables = cell(1);
% for i=1:100
%     tables{i} = bingoTables((i-1)*5+1:(i-1)*5+5,:);
% end
clear; clc;
load('input.mat');
lastNumberOfTable = 0;
tableCounter = 100;
for i=1:length(input)
    value = input(i);
    
    %mark
    for j=1:tableCounter
        for k=1:5
            for l=1:5
                if tables{j}(k,l) == value
                    tables{j}(k,l) = -1;
                end
            end
        end
    end
    
    % check
    j = 0;
    while (j<tableCounter)
        j = j+1;
        [bingo, sum] = checkTable(tables{j});
        if bingo
            lastNumberOfTable = j;
            sum * value
            tables(j) = [];
            tableCounter = tableCounter - 1;
            j = 0;
        end
    end
    
end

function [bingo, summ] = checkTable(array)
    %%rows
    bingo = false;
    summ = 0;
    for k=1:5
        if (sum(array(k,:)) == -5)
            bingo = true;
            break;
        end
    end
    
    for k=1:5
        if (sum(array(:,k)) == -5)
            bingo = true;
            break;
        end
    end    
    
    if bingo
        for i=1:5
            for j=1:5
                if (array(i,j) >= 0)
                   summ = summ + array(i,j); 
                end
            end
        end
    end
end