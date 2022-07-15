%  
%  
%  


A = input('Introduce la matriz cuadrada del sistema: ');
b = input('Introduce el vector de terminos independientes: ');
b = b(:);
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

while(size(A,1) ~= size(A,2) || size(A,1) ~= length(b) || para <= 0 || iter <= 0 || nulo == 1)
    disp('ERROR: Ha ocurrido uno o más de los siguientes errores: ');
    disp('1. La matriz no es cuadrada.');
    disp('2. El vector de términos independientes y la matriz no tienen la misma dimensión.');
    disp('3. El número máximo de iteraciones no es positivo.');
    disp('4. La precisión del test de parada no es positiva.');
    disp('5. Algún elemento de la diagonal principal de A es nulo.');
    A = input('Introduce la matriz cuadrada del sistema: ');
    b = input('Introduce el vector de terminos independientes: ');
    b = b(:);
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

normab = norm(b);
abscisas = 0:iter;
ordenadas = zeros(1,iter+1);
termina = 0;

u = zeros(length(b),1);
r = b;
ordenadas(1) = 1;

i = 1;
while  ~termina && i <= iter
    d = r./diagonal;
    u = u+d;
    r = b - A*u;

    ordenadas(i+1) = norm(r)/normab;
    
    if(ordenadas(i+1) < para)
        disp(['Este sistema es convergente. Se satisface el test de parada en la iteración ',num2str(i),'. ']);
        disp('Solución: ');
        disp(u);
        termina = 1;
    end
    
    i = i+1;
end

if(termina == 0)
    disp('Se ha alcanzado el número máximo de iteraciones.');
end

plot(abscisas(1:i),ordenadas(1:i));



