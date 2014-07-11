function [product] = productToRegress(data,baseline,norm,CoM)

    baseline_matrix = ones(size(data))*diag(baseline);
    
    if nargin ~= 3
        forces = data - baseline_matrix;
    else
        forces = normalize(data - baseline_matrix);
    end
x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
    
    if nargin < 4
        x_matrix = ones(size(data))*diag(x);
    else
        x_mat = ones(size(data))*diag(x);
        CoM_matrix = diag(CoM)*ones(size(x_mat));
        x_matrix = x_mat - CoM_matrix;
    end

    product = forces .* x_matrix;
    

end