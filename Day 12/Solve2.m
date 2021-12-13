clear; clc;
fid = fopen('input.txt');
input = cell(1);
row = 0;
tops = cell(1);
topsCount = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    indexs = find(tline == '-');

    row = row + 1;
    input{row,1} = tline(1:indexs(1)-1);
    [tops, topsCount] = addToTops(tops, topsCount, input{row,1});
    input{row,2} = tline(indexs(1)+1:end);
    [tops, topsCount] = addToTops(tops, topsCount, input{row,2});

end
%% строим матрицу А
A = zeros(topsCount,topsCount);
for i=1:topsCount
    for j=1:row
        if string(input(j,1)) == string(tops{i})
            index = getIndexTop(tops, input(j,2));
            A(i,index) = 1;
        end

        if string(input(j,2)) == string(tops{i})
            index = getIndexTop(tops, input(j,1));
            A(i,index) = 1;
        end
    end
end

G = graph(A,tops);
plot(G)

%% ищем пути
explore(G, string.empty, 0, "start", 1)

%%
function [tops, topsCount] = addToTops(tops, topsCount, name)
    if topsCount == 0
        topsCount = topsCount + 1;
        tops{topsCount} = name;
    else
        exist = false;
        for i=1:topsCount
            if string(tops{i}) == string(name)
                exist = true;
                break;
            end
        end
        
        if ~exist
            topsCount = topsCount + 1;
            tops{topsCount} = name;
        end
    end
end

function [index] = getIndexTop(tops, name)
    for i=1:length(tops)
        if (string(tops{i}) == string(name))
            index = i;
            return;
        end
    end
end

%% Recursive exploration function
function cPaths = explore(G, visited, cPaths, currNode, smallCavesAllowRep)
    if "start" == currNode && numel(visited) > 1
        return
    end

    visited(end+1) = currNode;

    if "end" == currNode
        cPaths = cPaths + 1;
        return
    end

    neigh = neighbors(G, currNode);
    
    for i = 1:numel(neigh)
        if neigh(i) == upper(neigh(i))
            cPaths = explore(G, visited, cPaths, neigh(i), smallCavesAllowRep);
        elseif ~contains(neigh(i), visited)
            cPaths = explore(G, visited, cPaths, neigh(i), smallCavesAllowRep);
        elseif sum(count(visited, neigh(i))) <= smallCavesAllowRep
            cPaths = explore(G, visited, cPaths, neigh(i), 0);
        end
    end
end