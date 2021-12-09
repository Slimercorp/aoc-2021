clear; clc;
fid = fopen('input.txt');
map = cell(1);
row = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    row = row + 1;
    for i=1:length(tline)
        map{row,i} = tline(i);
    end
    
end

%%
risk = 0;
for i=1:row
    for j=1:100
        if (i-1)>=1
            up = str2num(map{i-1,j});
        else
            up = 9;
        end
        
        if (j-1)>=1
            left = str2num(map{i,j-1});
        else
            left = 9;
        end
        
        if (i+1)<=row
            down = str2num(map{i+1,j});
        else
            down = 9;
        end
        
        if (j+1)<=100
            right = str2num(map{i,j+1});
        else
            right = 9;
        end
        
        value = str2num(map{i,j});
        
        if value<up && value<left && value<down && value<right
            risk = risk + value + 1;
        end
    end
end

risk