clc; clear;
load('input.mat');
input = input + 1;

minPos = min(input);
maxPos = max(input);
func = zeros(1,maxPos) + inf;
for pos=minPos:maxPos
    func(pos) = 0;
    for i=1:length(input)
        diff = abs(input(i) - pos);
        func(pos) = func(pos) + diff;
    end
end

minFunc = min(func)
index = find(func == minFunc) - 1