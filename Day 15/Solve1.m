clear; clc;
fid = fopen('input.txt');
row = 0;
input = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    row = row + 1;
    for i=1:length(tline)
        input(row,i) = str2num(tline(i));
    end
    
end

[row, column] = size(input);
fromVector = [];
toVector = [];
weights = [];
for i=1:row
    for j=1:column
        [fromVectorTemp, toVectorTemp, weightTemp] = getLinksTo(input,i,j, row, column);
        fromVector = [fromVector fromVectorTemp];
        toVector = [toVector toVectorTemp];
        weights = [weights weightTemp];

        [fromVectorTemp, toVectorTemp, weightTemp] = getLinksFrom(input,i,j, row, column);
        fromVector = [fromVector fromVectorTemp];
        toVector = [toVector toVectorTemp];
        weights = [weights weightTemp];
    end
end

indexToDelete = [];
length(toVector)
for i=1:length(toVector)
    for j=i+1:length(toVector)
        if toVector(i) == toVector(j) && fromVector(i) == fromVector(j) && isempty(find(indexToDelete == i))
            indexToDelete = [indexToDelete j];
        end
    end
end

fromVector(indexToDelete) = [];
toVector(indexToDelete) = [];
weights(indexToDelete) = [];

G = digraph(fromVector,toVector,weights);

%plot(G,'EdgeLabel',G.Edges.Weight);

[P, d] = shortestpath(G,1,row*column)


%%
function [fromVector, toVector, weight] = getLinksTo(input,i,j, rowMax, columnMax)
    indexTo = (i-1) * rowMax + j;
    fromVector = [];
    toVector = [];
    weight = [];

    %up
    newI = i-1;
    if newI > 0
        indexFrom = (newI-1) * rowMax + j;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(i,j)];
    end
    
    %left
    newJ = j-1;
    if newJ > 0
        indexFrom = (i-1) * rowMax + newJ;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(i,j)];
    end

    %down
    newI = i+1;
    if newI <= rowMax
        indexFrom = (newI-1) * rowMax + j;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(i,j)];
    end

    %right
    newJ = j+1;
    if newJ <=columnMax
        indexFrom = (i-1) * rowMax + newJ;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(i,j)];
    end
end

function [fromVector, toVector, weight] = getLinksFrom(input,i,j, rowMax, columnMax)
    indexFrom = (i-1) * rowMax + j;
    fromVector = [];
    toVector = [];
    weight = [];

    %up
    newI = i-1;
    if newI > 0
        indexTo = (newI-1) * rowMax + j;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(newI,j)];
    end
    
    %left
    newJ = j-1;
    if newJ > 0
        indexTo = (i-1) * rowMax + newJ;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(i,newJ)];
    end

    %down
    newI = i+1;
    if newI <= rowMax
        indexTo = (newI-1) * rowMax + j;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(newI,j)];
    end

    %right
    newJ = j+1;
    if newJ <=columnMax
        indexTo = (i-1) * rowMax + newJ;
        fromVector = [fromVector indexFrom];
        toVector = [toVector indexTo];
        weight = [weight input(i,newJ)];
    end
end