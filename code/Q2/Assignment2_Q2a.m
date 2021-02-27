clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')
global cMap

nx = 50;        % # of colums
ny = 75;        % # of rows
boxL = 10;      % Length of box... along x
boxW = 25;      % Width of box... along y
sigma = 0.1;    % Conductivity of box
% Function Call
V = Assignment2_Q2(nx, ny, boxL, boxW, sigma);

% Potential Surface Map
vMap = reshape(V, [ny nx]);    % Reshaping Vector to a matrix
figure('name', 'Voltage - FD Solution'), surf(vMap'); % Plotting

% Conductivity Map
figure('name', 'Conductivity Map');
surf(cMap), title('Conductivity Map');

% Electric Field
[Ex,Ey] = gradient(-vMap);
figure('name', 'Electric Field');
quiver(Ex,Ey,1.1), title('Electric Field');

% Current Flow
Jx = cMap'.* Ex;
Jy = cMap'.* Ey;
figure('name', 'Current Flow');
quiver(Jx,Jy,1.1), title('Current Flow');