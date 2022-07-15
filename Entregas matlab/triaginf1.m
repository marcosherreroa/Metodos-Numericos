%  
%  
%  

function V1 = triaginf1(M1,I1)
if size(M1,1) == size(I1)
    J = I1;
else J = transpose(I1);
end
V1 = zeros(1,size(M1,1));
for i=1:size(M1,1)
    sum = dot(V1,M1(i,:));
    V1(i)=J(i)-sum;
end
end

