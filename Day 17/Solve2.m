k = 0;
table = 0;
for vx=-600:1:600
    for vy=-600:1:600
        [success, ~] = getResult(vx, vy);
        if success
            k=k+1;
            table(k,1) = vx;
            table(k,2) = vy;
        end
    end
end

length(table)



















%%
function [success, maxY] = getResult(vx, vy)
    success = false;
    x = 0;
    y = 0;
    maxY = 0;
    while 1
        x = x + vx;
        y = y + vy;

        maxY = max(maxY, y);
    
        vx = vx - sign(vx);
        vy = vy - 1;
    
        if y>=-136 && y<=-86 && x>=150 && x<=193
            success = true;
            break;
        end
    
        if y<-136
            success = false;
            break;
        end
    
    end
end