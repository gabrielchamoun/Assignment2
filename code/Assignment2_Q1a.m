clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')

nx = 50;   % # of colums
ny = 50;   % # of rows
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
            F(n,1) = 0;
        elseif j == 0 
            G(n,n) = -3;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
        elseif j == ny
            G(n,n) = -3;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nyp) = 1;
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
        
    end
end

% figure('name', 'G Matrix')
% spy(G)

% Solving the set of linear equations to obtain voltage values
dA = decomposition(G,'lu');
V = dA\F;
Vmap = reshape(V, [nx, ny]);    % Reshaping Vector to a matrix
figure('name', 'Solution'), surf(Vmap); % Plotting



