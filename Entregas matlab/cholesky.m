%  
%  
%  

n = input('Introduce la dimension de la matriz A: ');
A = zeros(n,n);
disp('A continuacion debes introducir la parte triangular inferior de la matriz hermitica a tratar');
for i=1:n
    s=sprintf('Introduce los %d elementos de la fila %d de A: ',i,i);
    A(i,1:i) = input(s);
    A(1:i-1,i) = A(i,1:i-1);
end

b = input('Introduce el vector de terminos independientes:');
b = b(:);

if(n ~= length(b))
    disp('ERROR: El vector b no tiene la dimension adecuada');
    return;
end

%Sobreescribimos la matriz A columna por columna con los valores de B en la
%parte triangular inferior y por simetria tambien sobre a los de B^t
for i=1:n
    A(i,i) = sqrt(A(i,i) - sum(abs(A(i,1:i-1).*abs(A(i,1:i-1)))));
    if(A(i,i) == 0)
        disp('ERROR: La matriz introducida no admite factorizacion de Cholesky');
        return;
    end
    
    for j=i+1:n
        A(j,i) = (conj(A(i,j)) - sum(conj(A(i,1:i-1)).*A(j,1:i-1)))/A(i,i);
        A(i,j) = A(j,i);
    end
end

w = trinf(A,b);
u = trsup(A,w)
resp = input('Para resolver el mismo sistema para otro vector b introduce 1, u otro valor en caso contrario:');
while(resp == 1)
    b = input('Introduce el nuevo vector de terminos independientes:');
    b = b(:);
    while(length(b) ~= n)
        disp('ERROR: La dimension del nuevo vector b es incorrecta');
        b = input('Introduce el nuevo vector de terminos independientes:');
        b = b(:);
    end
    
    w = trinf(A,b);
    u = trsup(A,w)
    
resp = input('Para resolver el mismo sistema para otro vector b introduce 1, u otro valor en caso contrario:');
end

function w = trinf(A,b)
    w = zeros(size(A,1),1);
    for i=1:size(A,1)
        w(i)=(b(i)- dot(A(i,1:i-1), w(1:i-1)))/A(i,i);
    end
end

function u = trsup(A,b)
    u = zeros(size(A,1),1);
    for i=size(A,1):-1:1
        u(i)=(b(i)- dot(A(i,i+1:size(A,1)), u(i+1:size(A,1))))/A(i,i);
    end
end