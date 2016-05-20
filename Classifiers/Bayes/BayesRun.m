close all; clear; clc;
addpath('../Datasets/');
addpath('../Utils/');

%  filename = 'iris-dataset.txt';
%  filename = 'dermatologia.txt'; 
%  filename = 'column_2C.txt';
 filename = 'column_3C.txt';

base = loadDataset(filename);

%% Executando classificador Bayesiano com Rejeicao %%
% Atribuindo os custos para que o classificador calcule o limiar de
% rejeicao. Os valores dos custos
custos.acertar = 0; %Wc%
custos.errar = 1; %We%
custos.rejeitar = 0.5; %Wr = [0; 0.5]%

result = bayesReject(base, 20, 0.8, custos);

%% Executando classificador Bayesiano com Risco %%
% riskMatrix = 1 - eye(length(unique(base.y)));
% result = bayesRisk(base, 20, 0.8, riskMatrix);

%% Executando classificador Bayesiano com funções discriminantes %%
% % result  = bayes(base, 20, 0.8, 'mvnpdf');
% resultQ   = bayes(base, 20, 0.8, 'quadratica');
% % result  = bayes(base, 20, 0.8, 'matCovIgual');
% resultCI  = bayes(base, 20, 0.8, 'matCovMean');
% % result  = bayes(base, 20, 0.8, 'matCovAll');
% resultCDI = bayes(base, 20, 0.8, 'matCovDiagIgual');
% resultECD = bayes(base, 20, 0.8, 'equiprovavelCovDif');
% resultECI = bayes(base, 20, 0.8, 'equiprovavelCovIgual');
% resultED  = bayes(base, 20, 0.8, 'eclidianDistance');
% resultMD  = bayes(base, 20, 0.8, 'mahalanobisDistance');
%Gerando Boxplots%
%  bp = [resultQ.acc; resultCI.acc; resultCDI.acc; resultECD.acc; resultECI.acc; resultED.acc; resultMD.acc];
%  bpt = bp';
%  figure, boxplot(bpt);
%  %title('Boxplot da Acurácia para a base da Coluna com três classes');
%  ylabel('Acurácia');