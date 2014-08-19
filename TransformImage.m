%note that coords are horizontal
%http://www.ams.org/samplings/feature-column/fc-2013-03
function [transformerMatrix] = TransformImage(a1,b1,c1,d1,height,length);

a2 = [0 height 1]; 
b2 = [0 0 1];
c2 = [length 0 1];
d2 = [length height 1];

a1 = [a1 1];
b1 = [b1 1];
c1 = [c1 1];
d1 = [d1 1];

A = [a1 0 0 0 -a2(1)*a1;
 0 0 0 a1 -a2(2)*a1;
 b1 0 0 0 -b2(1)*b1;
 0 0 0 b1 -b2(2)*b1;
 c1 0 0 0 -c2(1)*c1;
 0 0 0 c1 -c2(2)*c1;
 d1 0 0 0 -d2(1)*d1;
 0 0 0 d1 -d2(2)*d1];

transformerMatrix = reshape(null(A),3,3);

%check - should be equal
%c1 * transformerMatrix
%c2 * (c1*transformerMatrix(:,3))

end