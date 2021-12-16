clear; clc;
fid = fopen('input.txt');
inputBin = '';
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    inputHex = tline;
    inputBin = hexToBinaryVector(tline);
    
end
%inputBin(2:end+1) = inputBin(1:end);
%inputBin(1) = 0;
%%
pointerBin = 1;
k = 0;
packets = cell(1);

sum = 0;
[packet, pointerBin, sum] = readPacket(inputBin, pointerBin, sum);
 


%%
function [packet, pointer, sum] = readPacket(input, pointer, sum)
    packet = struct('version', -1, ...
                    'type',-1, ...
                    'ID',-1, ...
                    'value', cell(1));

    %version
    packet.version = bin2dec(num2str(input(pointer:pointer+2)));
    pointer = pointer + 3;
    sum = sum + packet.version;
    
    %type
    packet.type = bin2dec(num2str(input(pointer:pointer+2)));
    pointer = pointer + 3;

    if packet.type == 4
        value = '';
        while 1
            firstBit = input(pointer);
            pointer = pointer + 1;

            value = [value num2str(input(pointer:pointer+3)) '  '];
            pointer = pointer + 4;

            if (~firstBit)
                break;
            end
        end

        packet.value{1} = bin2dec(num2str(value));

    else
        packet.ID = input(pointer);
        pointer = pointer + 1;

        if packet.ID
            len = bin2dec(num2str(input(pointer:pointer+10)));
            pointer = pointer + 11;

            for i=1:len
                [packetTemp, lenReaded, sum] = readPacket(input(pointer:end), 1, sum);
                packet.value{i} = packetTemp;
                pointer = pointer + lenReaded - 1;
            end
        else
            len = bin2dec(num2str(input(pointer:pointer+14)));
            pointer = pointer + 15;

            lenReaded = 0;
            i = 0;
            while 1
                i = i + 1;
                [packetTemp, lenReadedTemp, sum] = readPacket(input(pointer+lenReaded:pointer+len-1), 1, sum);
                packet.value{i} = packetTemp;
                lenReaded = lenReaded + lenReadedTemp - 1;
                if lenReaded >= len
                    break;
                end
            end
            
            pointer = pointer + len;
        end
    end  
end