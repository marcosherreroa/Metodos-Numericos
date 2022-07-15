
format longe;
num = 0;
pot = 0.5;

for i = 1:53
    num = num+pot;
    pot = pot* 0.5;
end

disp('El numero es: ');
disp(num);
disp('Observamos que 1-num =');
disp(2^-53);
disp('= 2`(-53)');
