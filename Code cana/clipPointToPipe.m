function [clipped] = clipPointToPipe(point, pipe)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    
    % Init (declaration)
    clipped = [0 0 0];
    AM = [0 0 0];
    
    OA = [0 0 0];
    OB = [0 0 0];
    OM = [0 0 0];
    up = [0 0 0];
    r = [0 0 0];
    
    % Unpack pipe
    O = pipe(1, 2:4);
    A = pipe(1, 5:7);
    B = pipe(1, 8:10);
    a = pipe(1, 11:13);
    b = pipe(1, 14:16);
    
    
    if pipe(1, 1) == 1 % Straight
        AM = point - A;
        clipped = A + dot(AM, a) * a;
    elseif pipe(1, 1) == 2 || pipe(1,1) == 3 % Curved
        % Compute normalized up vector
        OA = A - O;
        OB = B - O;
        up = cross(OA, OB);
        up = up / norm(up);
    
        OM = point - O;
        r = OM - dot(OM, up) * up;
        clipped = O + (norm(OA) / norm(r)) * r;
    
    
    end

end

% function [clipped] = clipPointToPipe(point, pipe)
%     % Clip a point to a pipe using GPU calculations
%     clipped = [0 0 0];
% 
%     % Unpack pipe using GPU arrays
%     O = gpuArray(pipe(1, 2:4));
%     A = gpuArray(pipe(1, 5:7));
%     B = gpuArray(pipe(1, 8:10));
%     a = gpuArray(pipe(1, 11:13));
%     b = gpuArray(pipe(1, 14:16));
% 
%     point = gpuArray(point);  % Convert point to GPU array
% 
%     if pipe(1, 1) == 1 % Straight pipe case
%         AM = point - A;
%         clipped = A + dot(AM, a) * a;
% 
%     elseif pipe(1, 1) == 2 || pipe(1, 1) == 3 % Curved pipe case
%         OA = A - O;
%         OB = B - O;
%         up = cross(OA, OB);
%         up = up / norm(up);
% 
%         OM = point - O;
%         r = OM - dot(OM, up) * up;
%         clipped = O + (norm(OA) / norm(r)) * r;
%     end
% 
%     % Bring the result back to CPU
%     clipped = gather(clipped);
% end