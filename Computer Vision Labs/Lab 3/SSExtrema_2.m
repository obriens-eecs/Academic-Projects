function kp = SSExtrema(DoGPyr)
octaves = {};
celloctave = {};
for octave = 1:size(DoGPyr, 2)
    DP = DoGPyr{octave};
    imsize = size(DP(:,:,1));
    s.max = [];
    s.min = [];
    for col = 1:imsize(2)
        for row = 1:imsize(1)
            %%% Check pixel location
            checkmax = false;
            checkmin = false;
            if col == 1 && row == 1
                top = DP(row:row+1,col:col+1,1);
                mid = DP(row:row+1,col:col+1,2);
                bot = DP(row:row+1,col:col+1,3);
                %%% Check if max or min
                val = mid(1,1);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            elseif col > 1 && col < imsize(2) && row == 1
%                 disp (x),imsize(1)
                top = DP(row:row+1,col-1:col+1, 1);
                mid = DP(row:row+1,col-1:col+1, 2);
                bot = DP(row:row+1,col-1:col+1, 3);
                val = mid(1,2);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end

            elseif col == imsize(2) && row == 1
                top = DP(row:row+1, col-1:col, 1);
                mid = DP(row:row+1, col-1:col, 2);
                bot = DP(row:row+1, col-1:col, 3);
                val = mid(1,2);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
                
            elseif col == imsize(2) && row > 1 && row < imsize(1)
                top = DP(row-1:row+1,col-1:col, 1);
                mid = DP(row-1:row+1,col-1:col, 2);
                bot = DP(row-1:row+1,col-1:col, 3);
                val = mid(2, 2);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            
            elseif row == imsize(2) && col == imsize(1)
                top = DP(row-1:row,col-1:col, 1);
                mid = DP(row-1:row,col-1:col, 2);
                bot = DP(row-1:row,col-1:col, 3);
                val = mid(2,2);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            
            elseif col > 1 && col < imsize(2) && row == imsize(1)
                top = DP(row-1:row,col-1:col+1, 1);
                mid = DP(row-1:row,col-1:col+1, 2);
                bot = DP(row-1:row,col-1:col+1, 3);
                val = mid(2,2);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            elseif col == 1 && row == imsize(1)
                top = DP(row-1:row, col:col+1, 1);
                mid = DP(row-1:row, col:col+1, 2);
                bot = DP(row-1:row, col:col+1, 3);
                val = mid(2, 1);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            elseif col == 1 && row > 1 && row < imsize(1)
                top = DP(row-1:row+1, col:col+1, 1);
                mid = DP(row-1:row+1, col:col+1, 2);
                bot = DP(row-1:row+1, col:col+1, 3);
                val = mid(2, 1);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            elseif col > 1 && col < imsize(2) && row > 1 && row < imsize(1)
                top = DP(row-1:row+1, col-1:col+1, 1);
                mid = DP(row-1:row+1, col-1:col+1, 2);
                bot = DP(row-1:row+1, col-1:col+1, 3);
                val = mid(2,2);
                if (val > top) & (val >= mid) & (val > bot)
                    checkmax = true;
                    break
                end
                if (val < top) & (val <= mid) & (val < bot)
                    checkmin = true;
                    break
                end
            end
        end
        if checkmax == true
            newmax = [col row val];
            s.max(end+1,:) = newmax;
        elseif checkmin == true
            newmin = [col row val];
            s.min(end+1,:) = newmin;
        else
            continue
        end
    end
    celloctave{end + 1} = s;
    octaves{end + 1} = celloctave;
end
kp = octaves;
