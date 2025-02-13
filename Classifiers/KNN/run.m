close all; clear; clc;

addpath('../Datasets/');
addpath('../Utils/');

filename = 'iris-dataset.txt';
data = load(filename);

pctgTreino = 0.8;

base.x = data(:, 1:end-1); %Caracteristicas%
base.x = normalizar(base.x, 1);
base.y = data(:, end); %Classe%

resultado = KNN(base, 3, 20, pctgTreino);