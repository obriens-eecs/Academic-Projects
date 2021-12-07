function [DoGPyr] = DoGSS(GPyr)

DoGPyr = cell(1, size(GPyr,2));
    
    for i = 1:size(GPyr,2)
        temp = [];
        
        for j = 1:( size(GPyr{1},3) - 1)
            
            DoG = GPyr{i}(:,:,j) - GPyr{i}(:,:,j+1);
            temp = cat(3, temp, DoG);
            
        end
        
        DoGPyr{i} = temp;
    end

end