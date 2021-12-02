fid = fopen('input.txt');
depth = 0;
hor = 0;
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
        case 'up'
            depth = depth - value;
        case 'down'
            depth = depth + value;
        otherwise
            print("error");
    end
   
end

depth
hor
depth * hor