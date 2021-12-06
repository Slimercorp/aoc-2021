clc; clear;
load('input.mat');
array = cell(1);
array{1} = input;
len = length(input);
for k=1:80
    array{k+1,1} = array{k,1};
    for i=1:len
        array{k+1,1}(i) = array{k+1,1}(i) - 1;
        if array{k+1,1}(i) < 0
            array{k+1,1}(i) = 6;
            len = len + 1;
            array{k+1,1}(len) = 8;
        end
    end
end

len