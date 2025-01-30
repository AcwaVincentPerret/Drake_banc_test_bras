function [Point] = enterPoint(index,pipeline)

    N = size(pipeline, 1);
    if index > N 
        Point= [0 0 0];
    else    
        Point = pipeline(index, 5:7);
    end

end 