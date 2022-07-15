
clear all; close all; clc;
[x1, x2] = meshgrid(-10:1:10, -10:1:10A);
x1dot = - x1 + 2 * x2 + 6; % Aqu� la primera ecuaci�n
x2dot = 5 * x1 - 4 * x2 + 3; % Aqu� la segunda
quiver(x1,x2,x1dot, x2dot) % Crea el campo vectorial
f = @(t,y) [-  y(1) + 2 * y(2); 5 * y(1) - 4 * y(2)] % Aqu� la "funci�n" con el sistema de nuevo (esto es para crear algo de lo que crear las trayectorias)

hold on

% Bucle para dibujar diferentes trayectorias (se puede cambiar este c�digo
% para dibujar trayectorias espec�ficas.
for j=-5:1:4
  [ts,ys] = ode45(f,[-100,100],[0;j]) % Resuelve la ecuaci�n diferencial/el sistema de EDOS (primer par�metro).
  % Halla el valor de la gr�fica en un intervalo (segundo par�metro) y
  % resuelve problema de valor inicial para y=0 (tercer par�metro)
  plot(ys(:,1),ys(:,2))
  xlim([-10,10])
  ylim([-10,10])
end

hold off

