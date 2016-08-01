close all; clear; clc;
addpath('../Datasets/');
addpath('../Utils/');

%  filename = 'iris-dataset.txt';
%  filename = 'dermatologia.txt'; 
%  filename = 'column_2C.txt';
  filename = 'column_3C.txt';

data = load(filename);

base.x = data(:, 1:end-1); %Caracteristicas%
base.x = normalizar(base.x,1);

base.y = data(:, end); %Classe%

% result = bayes(base, 20, 0.8, 'mvnpdf');
 resultQ = bayes(base, 20, 0.8, 'quadratica');
% result = bayes(base, 20, 0.8, 'matCovIgual');
 resultCI = bayes(base, 20, 0.8, 'matCovMean');
% result = bayes(base, 20, 0.8, 'matCovAll');
 resultCDI = bayes(base, 20, 0.8, 'matCovDiagIgual');
 resultECD = bayes(base, 20, 0.8, 'equiprovavelCovDif');
 resultECI = bayes(base, 20, 0.8, 'equiprovavelCovIgual');
 resultED = bayes(base, 20, 0.8, 'eclidianDistance');
 resultMD = bayes(base, 20, 0.8, 'mahalanobisDistance');
 
 %Gerando Boxplots%
 bp = [resultQ.acc; resultCI.acc; resultCDI.acc; resultECD.acc; resultECI.acc; resultED.acc; resultMD.acc];
 bpt = bp';
 figure, boxplot(bpt);
 title('Boxplot da Acuracia para a base da Coluna com duas classes');
 ylabel('Acuracia');
 xlabel('Calculo de g(x)');   