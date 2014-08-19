function [x] = homogRegress(A)

[V,D] = eig(transpose(A)*A);

evals = sum(D,1);

index = find(evals == min(abs(evals)));

xp = V(:,index);

x = xp / sqrt(transpose(xp)*xp);

end