format longe
sumaUnos = 0;
pot = 1;

for i = 0:23
    sumaUnos = sumaUnos+ pot;
    pot = pot/2;
end

disp('El mayor número normal positivo es:');
disp(sumaUnos*2^127);

disp('El menor número normal positivo es:');
disp(2^(-126))

disp('El mayor número subnormal positivo es:');
disp((sumaUnos-1)*2^(-126));

disp('El menor número subnormal positivo es:');
disp(2^(-23)*2^(-126));