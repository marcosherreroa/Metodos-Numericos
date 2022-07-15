

disp('Opciones:');
disp('0. Interpolar los valores de una tabla');
disp('1. Interpolar una función anónima en unos puntos dados');
anonima = input('Introduce el número de la opción elegida: ');

while(anonima ~= 0 && anonima ~= 1)
    disp('ERROR: No existe tal opción');
    disp('Opciones:');
disp('0. Interpolar los valores de una tabla');
disp('1. Interpolar una función anónima en unos puntos dados');
anonima = input('Introduce el número de la opción elegida: ');
end

puntos = input('Introduce el vector de puntos a interpolar: ');
while(length(puntos) > length(unique(puntos)))
    disp('ERROR: Has introducido puntos repetidos');
    puntos = input('Introduce el vector de puntos a interpolar: ');
end

if(anonima == 0)
    valores = input('Introduce los valores de los puntos indicados: ');
    while(length(valores) ~= length(puntos))
        disp('ERROR: El numero de valores introducidos no coincide con el de puntos');
        valores = input('Introduce los valores de los puntos indicados: ');
    end
else
    f = input('Introduce la función anónima: ');
    valores = f(puntos);
end

y = valores;
dif = zeros(1,length(puntos));
dif(1) = y(1);
for i = 2:length(puntos)
    
    for j = 1:length(puntos) - i + 1
        y(j) = (y(j) - y(j + 1)) / (puntos(j) - puntos(j+i-1));
    end
    
    dif(i) = y(1);
end

PI_i = 1;
coefs = dif(1);

if(length(puntos) > 1) 
    for i=2:length(puntos)
       PI_i = conv(PI_i,[1, -puntos(i-1)]);
       coefs = [0,coefs] + dif(i)*PI_i;
    end
end

disp('El polinomio resultante es: ');
p = poly2sym(coefs)
%Dibujarlo
if(length(puntos) > 1)
    x = linspace(min(puntos),max(puntos));
else %Si solo nos dan un punto, dibujamos en un intervalo arbitrario centrado en el, nosotros elegimos +-2pi
    x = linspace(puntos(1)-2*pi, puntos(1)+2*pi);
end
    
vy = polyval(coefs,x);
plot(x,vy);
hold on;
 
if(anonima == 0)
   scatter(puntos,valores);
else
   fplot(f,[min(puntos) max(puntos)]);
   scatter(puntos,valores);
   legend('polinomio','función'); 
end

hold off

%Seguir añadiendo puntos mientras se quiera
seguir = input('Si deseas añadir otro punto introduce 1, o cualquier valor en caso contrario: ');
while(seguir == 1)
    puntos(end+1) = input('Introduce el nuevo punto: ');
    rep = 0;
    for i=1:length(puntos)-1
        if(puntos(i) == puntos(end))
            rep = 1;
            break;
        end
    end
    while(rep == 1)
        disp('ERROR: Has introducido un punto repetido');
        puntos(end) = input('Introduce el nuevo punto: ');
        rep = 0;
    for i=1:length(puntos)-1
        if(puntos(i) == puntos(end))
            rep = 1;
            break;
        end
    end
    end
    
    
    if(anonima == 0)
        valores(end+1) = input('Introduce el valor en el nuevo punto: ');
    else
        valores(end+1) = f(puntos(end));
    end
    
    y(end+1) = valores(end);
    for k=2:length(puntos)
        y(end - k + 1) = (y(end-k+1) - y(end-k+2)) / (puntos(end-k+1) - puntos(end));
    end
    
    dif(end+1) = y(1);
    
    PI_i = conv(PI_i,[1,-puntos(end-1)]);
    coefs = [0,coefs] + dif(end)*PI_i;
    
    %Mismo tratamiento que para la solucion inicial
    disp('El polinomio resultante es: ');
    p = poly2sym(coefs)
    
    %Dibujarlo
    x = linspace(min(puntos),max(puntos));
    vy = polyval(coefs,x);
    plot(x,vy);
    hold on; 
    
    if(anonima == 0)
       scatter(puntos,valores);
    else
       fplot(f,[min(puntos) max(puntos)]);
       scatter(puntos,valores);
       legend('polinomio','función'); 
    end
 
    hold off
    
    seguir = input('Si deseas añadir otro punto introduce 1, o cualquier valor en caso contrario: ');
end