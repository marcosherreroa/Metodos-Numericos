%  
%  
%  


A = input('Introduce la matriz cuadrada del sistema: ');
b = input('Introduce el vector de términos independientes: ');
b = b(:);
w = input('Introduce el parámetro de relajación: ');
iter = input('Introduce el número máximo de iteraciones: ');
para = input('Introduce la precisión para el test de parada: ');

nulo = 0;
diagonal = diag(A);

for i=1:length(diagonal)
    if diagonal(i) == 0
        nulo = 1;
        break;
    end
end

while(size(A,1) ~= size(A,2) || size(A,1) ~= length(b) || para <= 0 || iter <= 0 || nulo == 1 || w == 0)
    disp('ERROR: Ha ocurrido uno o más de los siguientes errores: ');
    disp('1. La matriz no es cuadrada.');
    disp('2. El vector de términos independientes y la matriz no tienen la misma dimensión.');
    disp('3. El número máximo de iteraciones no es positivo.');
    disp('4. La precisión del test de parada no es positiva.');
    disp('5. Algún elemento de la diagonal principal de A es nulo.');
    disp('6. El párametro de relajación es nulo.');
    A = input('Introduce la matriz cuadrada del sistema: ');
    b = input('Introduce el vector de términos independientes: ');
    b = b(:);
    w = input('Introduce el parámetro de relajación: ');
    iter = input('Introduce el número máximo de iteraciones: ');
    para = input('Introduce la precisión para el test de parada: ');
    nulo = 0;
    diagonal = diag(A);
    for i=1:length(diagonal)
        if diagonal(i) == 0
            nulo = 1;
            break;
        end
    end
end

normb = norm(b);
abscisas = 0:iter;
ordenadas = zeros(1,iter+1);
termina = 0;
n = size(A,1);
uk = zeros(n,1);
uk1 = zeros(n,1); %u_k+1
r = zeros(n,1);
d = zeros(n,1);

i = 0;
while ~termina && i <= iter
    uk = uk1;
    for j=1:n %Lo hacemos sobre el propio uk1, las j-1 primeras componentes ya contiene el valor de la siguiente iteracion
        r(j) = b(j) - A(j,1:n)*uk1;
        d(j) = w*(r(j)/A(j,j));
        uk1(j) = uk1(j) + d(j);
    end
    
    ordenadas(i+1) = norm(r)/normb;
    
    if(ordenadas(i+1) < para)
        if i == 0
            disp('Se satisface el test de parada antes de realizar ninguna iteración');
        else        
           disp(['Este sistema es convergente. Se satisface el test de parada en la iteración ',num2str(i),'. ']);
        end
        disp('Solución: ');
        disp(uk);%El k-esimo residuo, correspondiente a uk, se calcula en la iteracion k+1
        termina = 1;
    end
    
    i= i+1;
end


if(termina == 0)
    disp('Se ha alcanzado el número máximo de iteraciones.');
end

plot(abscisas(1:i),ordenadas(1:i));