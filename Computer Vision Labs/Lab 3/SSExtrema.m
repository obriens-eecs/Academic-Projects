function [kp] = SSExtrema(DoGPyr)
keypoints = {};
struct2cell = {};
for octave = 1:size(DoGPyr,2)
    DoG = DoGPyr{octave};
    imsize = size(DoG(:,:,1));
    str.max = [];
    str.min = [];
    for col = 1:imsize(2)
        for row = 1:imsize(1)
            checkmax = false;
            checkmin = false;
            if col == 1
                
                if row == 1
                    upper = DoG(row:row+1,col:col+1,1);
                    mid = DoG(row:row+1,col:col+1,2);
                    lower = DoG(row:row+1,col:col+1,3);
                    p = mid(1,1);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                elseif row > 1 && row < imsize(1)
                    upper = DoG(row-1:row+1, col:col+1, 1);
                    mid = DoG(row-1:row+1, col:col+1, 2);
                    lower = DoG(row-1:row+1, col:col+1, 3);
                    p = mid(2, 1);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                elseif row == imsize(1)    
                    upper = DoG(row-1:row, col:col+1, 1);
                    mid = DoG(row-1:row, col:col+1, 2);
                    lower = DoG(row-1:row, col:col+1, 3);
                    p = mid(2, 1);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                end
                
            elseif col > 1 && col < imsize(2)
                
                if row == 1
                    upper = DoG(row:row+1,col-1:col+1, 1);
                    mid = DoG(row:row+1,col-1:col+1, 2);
                    lower = DoG(row:row+1,col-1:col+1, 3);
                    p = mid(1,2);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                elseif row > 1 && row < imsize(1)
                    upper = DoG(row-1:row+1, col-1:col+1, 1);
                    mid = DoG(row-1:row+1, col-1:col+1, 2);
                    lower = DoG(row-1:row+1, col-1:col+1, 3);
                    p = mid(2,2);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                elseif row == imsize(1)   
                    upper = DoG(row-1:row,col-1:col+1, 1);
                    mid = DoG(row-1:row,col-1:col+1, 2);
                    lower = DoG(row-1:row,col-1:col+1, 3);
                    p = mid(2,2);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                end
            
            elseif col == imsize(2)
                
                if row == 1
                    upper = DoG(row:row+1, col-1:col, 1);
                    mid = DoG(row:row+1, col-1:col, 2);
                    lower = DoG(row:row+1, col-1:col, 3);
                    p = mid(1,2);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                
                elseif row > 1 && row < imsize(1)
                    upper = DoG(row-1:row+1,col-1:col, 1);
                    mid = DoG(row-1:row+1,col-1:col, 2);
                    lower = DoG(row-1:row+1,col-1:col, 3);
                    p = mid(2, 2);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                    
                elseif row == imsize(1)   
                    upper = DoG(row-1:row,col-1:col, 1);
                    mid = DoG(row-1:row,col-1:col, 2);
                    lower = DoG(row-1:row,col-1:col, 3);
                    p = mid(2,2);
                    if (p > upper) & (p >= mid) & (p > lower)
                        checkmax = true;
                        break
                    end
                    if (p < upper) & (p <= mid) & (p < lower)
                        checkmin = true;
                        break
                    end
                end
                
            end
                
        end
        if checkmax == true
            newmax = [col row p];
            str.max(end+1,:) = newmax;
        elseif checkmin == true
            newmin = [col row p];
            str.min(end+1,:) = newmin;
        else
            continue
        end
    end
    struct2cell{end + 1} = str;
    keypoints{end + 1} = struct2cell;
end
kp = keypoints;
end