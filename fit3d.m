function [] = fit3d (s,t,f)

% some 3d points
data = transpose(vertcat(s,t,f));

[xx,yy] = meshgrid(-5:1:5, 490:10:520);

% best-fit quadratic curve
C = [ones(5,1) data(:,1:2) prod(data(:,1:2),2)] \ data(:,3)
zz = [ones(numel(xx),1) xx(:) yy(:) xx(:).*yy(:)] * C;
zz = reshape(zz, size(xx));



figure('Renderer','opengl')
line(data(:,1), data(:,2), data(:,3), 'LineStyle','none', ...
    'Marker','.', 'MarkerSize',25, 'Color','r')
surface(xx, yy, zz, ...
    'FaceColor','interp', 'EdgeColor','b', 'FaceAlpha',0.2)
grid on; axis tight equal;
view(9,9);
xlabel x; ylabel y; zlabel z;
colormap(cool(64))