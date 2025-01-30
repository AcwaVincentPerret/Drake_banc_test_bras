function [index,stop] = findPipeIndex(point, pipeline, hint)
%findPipeIndex Find the index of the pipe containing point
%   Find the index of the pipe containing the given point. The search
%   starts at hint to speed up the process in case there are many pipe. 

% Assertions
assert(hint >= 1 & hint <= size(pipeline, 1), "Hint index is out of range!");
assert(size(pipeline, 2) == 16, "Pipeline should be a Nx16 matrice");

% Pipeline size
N = size(pipeline, 1);

% Init
index = 0; 
%% First search at hint
found = false;
stop = false ;
AM = point - pipeline(hint, 5:7);
BM = point - pipeline(hint, 8:10);
if (dot(AM, pipeline(hint, 11:13)) >= 0 && dot(BM, pipeline(hint, 14:16)) < 0)
    found = true;
%première cana = demi droite commençant à B
elseif (dot(BM, pipeline(hint, 14:16)) < 0 && hint == 1)
    found = true;
%%dernière cana demi droite commençant à A
elseif (dot(AM, pipeline(hint, 11:13)) >= 0 && hint == N)
     found = true;
%envoyer l'info que le robot n'est plus dans la cana 
        
end
if (dot(BM, pipeline(hint, 14:16)) >= 0 && hint == N)
     stop = true ;
     found = true ;
     
end
% Early return : hint was the actual searched index
if found
    %fprintf("Early return\n")
    index = hint;
    return
end

%% Search in other pipes
% Initialisation
i = 1;
search = hint + i;
skip_count = 0;
while ~found
    % Check index
    if search < 1 || search > N
        skip_count = skip_count + 1;

        % Update search index
        if search > hint
            search = hint - i; % if searching forward, try backward
        elseif search < hint
            i = i + 1;
            search = hint + i; % if searching backward, try further forward
        end

        % Skip
        continue;
    end

    % Actual test if point is inside pipe
    AM = point - pipeline(search, 5:7);
    BM = point - pipeline(search, 8:10);
    if (dot(AM, pipeline(search, 11:13)) >= 0 && dot(BM, pipeline(search, 14:16)) < 0)
        found = true;
        index = search;
    elseif (dot(BM, pipeline(search, 14:16)) < 0 && search == 1)
        found = true;
        index = search;
    elseif (dot(AM, pipeline(search, 11:13)) >= 0 && search == N)
        found = true;
        index = search;
    end

    % Update search index
    if search > hint
        search = hint - i; % if searching forward, try backward
    elseif search < hint
        i = i + 1;
        search = hint + i; % if searching backward, try further forward
    end
end

end