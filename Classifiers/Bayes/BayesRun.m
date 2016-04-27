close all; clear; clc;
addpath('../Datasets/');
addpath('../Utils/');

%  filename = 'iris-dataset.txt';
 filename = 'dermatologia.txt'; 
%  filename = 'column_2C';
%  filename = 'column_3C';

data = load(filename);

base.x = data(:, 1:end-1); %Caracteristicas%
base.x = normalizar(base.x,1);

base.y = data(:, end); %Classe%

% result = bayes(base, 20, 0.8, 'mvnpdf');
result = bayes(base, 20, 0.8, 'quadratica');
% result = bayes(base, 20, 0.8, 'matCovIgual');
% result = bayes(base, 20, 0.8, 'matCovMean');
% result = bayes(base, 20, 0.8, 'matCovAll');
% result = bayes(base, 20, 0.8, 'matCovDiagIgual');
% result = bayes(base, 20, 0.8, 'equiprovavelCovDif');
% result = bayes(base, 20, 0.8, 'equiprovavelCovIgual');
% result = bayes(base, 20, 0.8, 'eclidianDistance');
% result = bayes(base, 20, 0.8, 'mahalanobisDistance');