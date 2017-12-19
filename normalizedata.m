function norm_features = normalizedata(data)
%% Version 1: 2016-08-18
% Normalizing the data for range between 0 to 1
% Input:
%           data          : Input Data Vector of mxn matrix
% Ouput:
%           norm_features : Normalized Vector.
%%
    [row,col] = size(data);
    norm_features = zeros(row,col);
    for i = 1:col
        norm_features(:,i) = mat2gray(data(:,i));
    end
end