d=zeros(40,4);
for n=1:40

    eval(['s=s' num2str(n) ';']);
    eval(['t=t' num2str(n) ';']);
    eval(['f=f' num2str(n) ';']);

    data = transpose(vertcat(s,t,f));

    [xx,yy] = meshgrid(-5:0.5:5, 540:10:480);

    % best-fit quadratic curve
    C = [ones(5,1) data(:,1:2) prod(data(:,1:2),2)] \ data(:,3)
zz = [ones(numel(xx),1) xx(:) yy(:) xx(:).*yy(:)] * C;
    zz = reshape(zz, size(xx));
    d(n,1:4) = transpose(C);
end