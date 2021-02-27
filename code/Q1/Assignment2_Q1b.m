clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')

nx = 50;   % # of colums
ny = 75;   % # of rows
G = sparse(nx*ny,ny*nx);
F = zeros(nx*ny,1);
for i = 1:nx
    for j = 1:ny
        
        n = j + (i-1) * ny;     % middle
        nxm = j + (i-2) * ny;	% right
        nxp = j + i * ny;       % left
        nym = j-1 + (i-1) * ny; % top
        nyp = j+1 + (i-1) * ny; % down
        
        if i == 1
            G(n,n) = 1;
            F(n,1) = 1;
        elseif i == nx
            G(n,n) = 1;
            F(n,1) = 1;
        elseif j == 1 
            G(n,n) = 1;
            F(n,1) = 0;
        elseif j == ny
            G(n,n) = 1;
            F(n,1) = 0;
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
        
    end
end

figure('name', 'G Matrix')
spy(G)

% Solving the set of linear equations to obtain voltage values
dA = decomposition(G,'lu');
V = dA\F;
Vmap = reshape(V, [ny nx]);    % Reshaping Vector to a matrix
figure('name', 'Finite Difference Solution');
surf(Vmap'), title('Finite Difference Solution');


% ANALYTICAL SOLUTION
L = 300;
W = 200;
a = L;
b = W/2;
x = linspace(-b, b, nx);
y = linspace(0, a, ny);
V = zeros(ny, nx);

figure('name', 'Analytical Solution')
[X,Y] = meshgrid(x,y);
for n = 1:2:99
    V = V + ( (1/n) * (cosh((n*pi*X)/a)/cosh((n*pi*b)/a)) ...
                    .* sin((n*pi*Y)/a) );
    surf(4/pi*V'), title('Analytical Solution');
    pause(0.01);
end


