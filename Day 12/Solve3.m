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
G2 = digraph(A,tops);
plot(G2)

%Добавляем большие пещеры
addN=6;
wasAdded = 0;
for i=1:topsCount
    if string(tops{i}) == string(upper(tops{i}))
        index = getIndexTop(tops, tops{i});
        for j=1:addN
            A(:,topsCount+j+wasAdded) = A(:,index);
            A(topsCount+j+wasAdded, topsCount+j+wasAdded) = 0;
            A(topsCount+j+wasAdded,:) = A(:,topsCount+j+wasAdded)';
            tops{topsCount+j+wasAdded} = [tops{index} num2str(j)];
        end
        wasAdded = wasAdded + addN;
    end
end

%expand = 'xn';
expand = 'ut';
%expand = 'gx';
%expand = 'll';
%expand = 'dj';
%expand = 'ak';

%добавляем маленькие пещеры
for i=1:topsCount
    if string(tops{i}) == string(expand)
        index = getIndexTop(tops, tops{i});
        A(:,topsCount+wasAdded+1) = A(:,index);
        A(topsCount+wasAdded+1, topsCount+wasAdded+1) = 0;
        A(topsCount+wasAdded+1,:) = A(:,topsCount+wasAdded+1)';
        tops{topsCount+wasAdded+1} = [tops{index} num2str(1)];
        wasAdded = wasAdded + 1;
    end
end

G = digraph(A,tops);
%plot(G)
paths = allpaths(G,'start','end');

%to one row
newPaths = cell(length(paths),1);
length(paths)
for i=1:length(paths)
    newPaths(i) = cell(1);
    for j=1:length(paths{i})
        newPaths{i} = [char(newPaths{i}) char(paths{i}(j)) ','];
    end
    newPaths{i}(end) = [];
    if (mod(i,10000)) == 0
        i
    end
end
clear paths;
%% return names
for i=1:length(newPaths)
    indexs = newPaths{i} =='1';
    newPaths{i}(indexs) = [];

    indexs = newPaths{i} =='2';
    newPaths{i}(indexs) = [];

    indexs = newPaths{i} =='3';
    newPaths{i}(indexs) = [];

    if (mod(i,100000)) == 0
        i
    end
end

newPaths = unique(newPaths)';
length(newPaths)

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