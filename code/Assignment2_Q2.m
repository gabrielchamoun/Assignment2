clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')

nx = 50;   % # of colums
ny = 75;   % # of rows
boxL = 10;
boxW = 25;

% Conductivity Map
cMap = ones(nx,ny);
cMap(nx/2 - boxL/2:nx/2 + boxL/2,1:boxW) = 0.1;
cMap(nx/2 - boxL/2:nx/2 + boxL/2,ny-boxW:ny) = 0.1;

G = sparse(nx*ny,ny*nx);
F = zeros(nx*ny,1);
for i = 1:nx
    for j = 1:ny
        
        % Node Mapping
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
        elseif j == 1
            rxm = (cMap(i,j) + cMap(i-1,j)) / 2;
            rxp = (cMap(i,j) + cMap(i+1,j)) / 2;
            ryp = (cMap(i,j) + cMap(i,j+1)) / 2;
            
            G(n,n) = -(rxm+rxp+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nyp) = ryp;
        elseif j == ny
            rxm = (cMap(i,j) + cMap(i-1,j)) / 2;
            rxp = (cMap(i,j) + cMap(i+1,j)) / 2;
            rym = (cMap(i,j) + cMap(i,j-1)) / 2;
            
            G(n,n) = -(rxm+rxp+rym);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
        else
            rxm = (cMap(i,j) + cMap(i-1,j)) / 2;
            rxp = (cMap(i,j) + cMap(i+1,j)) / 2;
            rym = (cMap(i,j) + cMap(i,j-1)) / 2;
            ryp = (cMap(i,j) + cMap(i,j+1)) / 2;
            
            G(n,n) = -(rxm+rxp+rym+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
        end
        
    end
end
% figure('name', 'G Matrix'), spy(G);

% Solving the set of linear equations to obtain voltage values
dA = decomposition(G,'lu');
V = dA\F;
vMap = reshape(V, [ny nx]);    % Reshaping Vector to a matrix
figure('name', 'Voltage - FD Solution'), surf(vMap); % Plotting

% Conductivity Map
figure('name', 'Conductivity Map'), surf(cMap');

% Electric Field
[Ex,Ey] = gradient(-vMap);
figure('name', 'Electric Field - FD Solution'), quiver(Ex,Ey,1.1); % Plotting

% Current Flow
Jx = cMap'.* Ex;
Jy = cMap'.* Ey;
figure('name', 'Current Flow - FD Solution'), quiver(Jx,Jy,1.1);

% current density
% j = cMap'.*gradient(-vMap);
% figure('name', 'Current Field - FD Solution'),surf(j)
