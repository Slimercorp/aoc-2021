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
%inputBin(6:end+5) = inputBin(1:end);
%inputBin(1:5) = 0;
%%
pointerBin = 1;
k = 0;
packets = cell(1);

sum = 0;
[packet, pointerBin, sum] = readPacket(inputBin, pointerBin, sum);
result = handle(packet)
%%
function [result] = handle(packet)
    len = length(packet.value);
    switch (packet.type)
        case 0
            result = 0;
            for i=1:len
                operand = packet.value{i}.value{1};
                if isstruct(operand)
                    operand = handle(packet.value{i});
                end
            
                result = result + operand;
            end
        case 1
            result = 1;
            for i=1:len
                operand = packet.value{i}.value{1};
                if isstruct(operand)
                    operand = handle(packet.value{i});
                end

                result = result * operand;
            end
        case 2
            result = inf;
            for i=1:len
                operand = packet.value{i}.value{1};
                if isstruct(operand)
                    operand = handle(packet.value{i});
                end
                result = min(operand, result);
            end
        case 3
            result = 0;
            for i=1:len
                operand = packet.value{i}.value{1};
                if isstruct(operand)
                    operand = handle(packet.value{i});
                end
                result = max(operand, result);
            end
        case 5
            operand1 = packet.value{1}.value{1};
            operand2 = packet.value{2}.value{1};
            
            if isstruct(operand1)
                operand1 = handle(packet.value{1});
            end
            
             if isstruct(operand2)
                operand2 = handle(packet.value{2});
             end
            
            if operand1 > operand2
                result = 1;
            else
                result = 0;
            end
        case 6
            operand1 = packet.value{1}.value{1};
            operand2 = packet.value{2}.value{1};
            
            if isstruct(operand1)
                operand1 = handle(packet.value{1});
            end
            
             if isstruct(operand2)
                operand2 = handle(packet.value{2});
             end
             
            if operand1 < operand2
                result = 1;
            else
                result = 0;
            end
        case 7
            operand1 = packet.value{1}.value{1};
            operand2 = packet.value{2}.value{1};
            
            if isstruct(operand1)
                operand1 = handle(packet.value{1});
            end
            
             if isstruct(operand2)
                operand2 = handle(packet.value{2});
            end
            
            if operand1 == operand2
                result = 1;
            else
                result = 0;
            end
    end
end

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