fid = fopen('input.txt');
depth = 0;
hor = 0;
aim = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    indexs = find(tline == ' ');
	command = tline(1:indexs(1)-1);
	value = str2num(tline(indexs(1)+1:end));
	
	switch command
        case 'forward'
            hor = hor + value;
            depth = depth + aim * value;
        case 'up'
            aim = aim - value;
        case 'down'
            aim = aim + value;
        otherwise
            print("error");
    end
   
end

depth
hor
depth * hor