clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')
global cMap

nx = 50;        % # of colums
ny = 75;        % # of rows
boxL = 10;
boxW = 25;
sigma = logspace(0.0001,10);
currents = zeros(size(sigma,2), 1);

for i = 1:size(sigma,2)
    
    V = Assignment2_Q2(nx, ny, boxL, boxW, sigma(i));
    
    vMap = reshape(V, [ny nx]);
    J = cMap'.*gradient(-vMap);
    currents(i,1) = mean(J, 'all');
end

plot(sigma,currents, 'k', 'LineWidth',1.75);
set(gca, 'XScale', 'log');
xlabel('Box Conductivity (S/m)');
ylabel('Average Current Density (A/m^2)');
title('Average Current vs Box Conductivity');