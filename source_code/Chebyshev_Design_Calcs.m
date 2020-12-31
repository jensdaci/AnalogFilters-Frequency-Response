clear;
clc;

fid = fopen("Design_Output.txt", "wt");

amax = 3;
N = 6;

fprintf(fid, 'Chebyshev - %dth Order \n', N);
fprintf(fid, 'Passband Variations: %.1f dB \n', amax);

epsilon = sqrt(10^(amax/10) - 1);
a = 1/N * asinh(1/epsilon);

p = zeros(6, 2);
psi = [pi/(2*N) 3*pi/(2*N) 5*pi/(2*N) 7*pi/(2*N) 9*pi/(2*N) 11*pi/(2*N)];
wo = zeros(3, 1);
Q = zeros(3, 1);

fprintf(fid, '\nPole Locations: \n');
for i=1:6
    p(i, 1) = sinh(a) * sin(psi(i));
    p(i, 2) = cosh(a) * cos(psi(i)); 
    
    fprintf(fid, '    p%d = -wp * [%.4f + j%.4f] \n', i, p(i, 1), p(i, 2));
end

fprintf(fid, '\nWo Frequencies: \n');
for i=1:3
    wo(i) = sqrt( (p(i, 1))^2 + p(i, 2)^2 );
    
    fprintf(fid, '    wo%d = %.4f * wp \n', i, wo(i));
end

fprintf(fid, '\nQ Values: \n');
for i=1:3
    Q(i) = wo(i) / (2*p(i, 1));
    
    fprintf(fid, '    Q%d = %.4f \n', i, Q(i));
end

fclose(fid);

