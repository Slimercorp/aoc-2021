clc; clear;
load('input.mat');
len = length(input);

array=zeros(1,9);
%% init
for i=1:length(input)
    array(input(i)+1) = array(input(i)+1) + 1;
end

%%
day = 1;
finalDay = 256;
while day <= finalDay
    temp = array(1);
    for i=1:8
        array(i) = array(i+1);
    end
    array(9) = temp;
    array(7) = array(7) + temp;
    day = day + 1;
end

sum(array)