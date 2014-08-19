function [product] = productToRegress(data,baseline,pos,norm,CoM)

%3 args means normalizing
%4 args means homog--eigen
%length of baseline will determine the positions

    %baseline_matrix = ones(size(data))*diag(baseline);
    baseline_matrix = baseline;
    if norm
         %because this way its positive
         
        forces = normalize((baseline_matrix - data));
    else
        forces = (baseline_matrix - data);
    end 

    if nargin < 5
        pos_matrix = ones(size(data))*diag(pos);
    else
        pos_mat = ones(size(data))*diag(pos);
        CoM_matrix = diag(CoM)*ones(size(pos_mat));
        pos_matrix = pos_mat - CoM_matrix;
    end

    product = forces .* pos_matrix;
    

end