count = 0;
for i=2:length(input)
    if (input(i) - input(i-1)) > 0
        count = count + 1;
    end
end

count