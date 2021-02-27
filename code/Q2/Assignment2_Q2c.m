clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')
global cMap

nx = 50;        % # of colums
ny = 80;        % # of rows
boxL = 10;
boxW = 0:1:40;
currents = zeros(size(boxW,2), 1);

for i = 1:size(boxW,2)
    
    V = Assignment2_Q2(nx, ny, boxL, boxW(i), 0.1);
    
    vMap = reshape(V, [ny nx]);
    J = cMap'.*gradient(-vMap);
    currents(i,1) = max(J, [], 'all');
end

plot(boxW,currents, 'k', 'LineWidth',1.75);
xlabel('Width of Box (m)');
ylabel('Maximum Current Density (A/m^2)');
title('Max Current vs Narrowing of bottle-neck');