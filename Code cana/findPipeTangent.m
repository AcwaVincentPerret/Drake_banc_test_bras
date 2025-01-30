function [tangent] = findPipeTangent(point, pipe)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Assertion(s)
assert(size(pipe, 2) == 16, "Pipe should be of size 1x16");

% Unpack pipe
O = pipe(1, 2:4);
A = pipe(1, 5:7);
B = pipe(1, 8:10);
a = pipe(1, 11:13);
b = pipe(1, 14:16);

% Early return: pipe is straight
if pipe(1, 1) == 1
    tangent = a;
    return
end

% Compute normalized up vector
AO = O - A;
OB = B - O;
up = cross(AO, OB);
up = up / norm(up);

% Compute tangent 
OM = point - O;
r = OM / norm(OM);
tangent = cross(r, up);
end