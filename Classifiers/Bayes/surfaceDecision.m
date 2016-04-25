function [ resultadosplot ] = surfaceDecision( teste, resultados, numClasses, c1, c2 )

%Obter as duas primeiras caracteristicas
X = teste.x(:, c1:c2);

nsamples = size(teste.x,1);
samplesClass = cell(numClasses,1);

% Separando os dados das classes especificas
for i = 1:numClasses
    samplesClass{i} = teste.x(find(resultados.classes == i),c1:c2);
end

% Computar a classe principal para usar como protitipo da classe
sample_means = cell(numClasses,1);
for i=1:length(sample_means),
    sample_means{i} = mean(samplesClass{i});
end

% Calcular o range
xrange = [min(teste.x(:,c1))-0.5 max(teste.x(:,c1))+0.5];
yrange = [min(teste.x(:,c2))-0.5 max(teste.x(:,c2))+0.5];

% Tamanho do passo para a visualizacao da fronteira de decisao
inc = 0.008;

% Gerar a grade de coordenadas
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));

xy = [x(:) y(:)];

image_size = size(x);

numxypairs = length(xy); % number of (x,y) pairs
 
% distance measure evaluations for each (x,y) pair.
dist = [];
 
% loop through each class and calculate distance measure for each (x,y)
% from the class prototype.
for i=1:numClasses,
 
    % calculate the city block distance between every (x,y) pair and
    % the sample mean of the class.
    % the sum is over the columns to produce a distance for each (x,y)
    % pair.
    disttemp = sum(abs(xy - repmat(sample_means{i}, [numxypairs 1])), 2);
 
    % concatenate the calculated distances.
    dist = [dist disttemp];
 
end

% for each (x,y) pair, find the class that has the smallest distance.
% this will be the min along the 2nd dimension.
[m,idx] = min(dist, [], 2);
     
% reshape the idx (which contains the class label) into an image.
decisionmap = reshape(idx, image_size);

figure;
 
%show the image
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');

% colormap for the classes:
% class 1 = light red, 2 = light green, 3 = light blue
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1];
colormap(cmap);

% plot the class training data.
plotar(1) = plot(samplesClass{1}(:,1),samplesClass{1}(:,2), 'r^');
plotar(2) = plot(samplesClass{2}(:,1),samplesClass{2}(:,2), 'go');
plotar(3) = plot(samplesClass{3}(:,1),samplesClass{3}(:,2), 'b*');

% include legend
legend(plotar,'Setosa', 'Versicolor', 'Virginica','Location','NorthOutside', ...
    'Orientation', 'horizontal');
 
% label the axes.
xlabel('length');
ylabel('width');

% legend(plotar, 'Setosa ', 'Versicolor ', 'Virginica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');

% gscatter(X(:,1), X(:,2), resultados.classe,'rgb');
% title('Dispersion of testing data set after KNN classification');
% xlabel('Sepal length');
% ylabel('Sepal width');


end