% 
% 
% 


function x = tridiag(a,b,c, d)
 %Resuelve un sistema Ax = d cuya matriz A es tridiagonal y sus diagonales significativas están
 %almacenadas en los vectores a,b y c
 
 
 n = length(d);
 
 if(length(a) ~= n-1 || length(b) ~= n || length(c) ~= n-1)
     disp('Las dimensiones de los vectores no son las adecuadas')
     return;
 end
 
 m = zeros(n, 1);
 m(1) = b(1);
 for k= 2:n
    m(k)= b(k)- c(k-1)/m(k-1)*a(k-1);
 end
 
 g = zeros(n,1);
 g(1) = d(1)/m(1);
 for k=2:n
     g(k) = (d(k)-g(k-1)*a(k-1))/m(k);
 end
 
 x = zeros(n,1);
 x(n)= g(n);
 for k=n-1:-1:1
     x(k)= g(k)-c(k)/m(k)*x(k+1);
 end
 
 