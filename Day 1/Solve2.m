count = 0;
prevSum = input(1) + input(2) + input(3);
for i=4:length(input)
    sum = input(i) + input(i-1) + input(i-2);
    if (sum - prevSum) > 0
        count = count + 1;
    end
    prevSum = sum;

end

count