clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')
global cMap

meshMul = 0.5:0.5:10;
currents = zeros(size(meshMul,2), 1);
areas = zeros(size(meshMul,2), 1);

for i = 1:size(meshMul,2)
    nx = 20 * meshMul(i);
    ny = 30 * meshMul(i);
    boxL = 4 * meshMul(i);
    boxW = 10 * meshMul(i);
    
    V = Assignment2_Q2(nx, ny, boxL, boxW, 0.1);
    
    vMap = reshape(V, [ny nx]);
    J = cMap'.*gradient(-vMap);
    
    currents(i,1) = mean(J, 'all');
    areas(i,1) = (nx/20)*(ny/30);
end

plot(areas,currents, 'k', 'LineWidth',1.75);
xlabel('Mesh Element Size (m^2)');
ylabel('Average Current Density (A/m^2)');
title('Current vs Mesh size');