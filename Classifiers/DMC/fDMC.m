function [ resultados ] = DMC( treino, teste, qntdClasses )
%DMC [ resultados ] = DMC( treino, teste, qntdClasses )
%   Classificador DMC: recebe como parametro as bases de treino e teste e a
%   quantidade de classes. Retorna as classes atribuidas a base de teste e
%   a acuracia.

    %Calcular os centroides%
    centroide.x = [];
    centroide.y = [];
    for i = 1:qntdClasses
        centroide.x = [centroide.x; mean(treino.x(find(treino.y == i),:))];
        centroide.y = [centroide.y; i];
    end
    
    %A matriz centroide.x possui a quantidade de colunas igual a quantidade
    %de caracteristicas e a quantidade de linhas igual ao numero de
    %classes.
    
    %Calcular a distancia euclidiana da base de TESTE para os CENTROIDES das classes.
    distancias = pdist2(centroide.x, teste.x);
    
    %Obter a classe da menor distancia.
    [~, posicoes] = sort(distancias);
    resultados.classes = posicoes(1,:)';
    
    %Calcular acuracia.
    s = sum(teste.y == resultados.classes);
    resultados.acuracia = s/size(resultados.classes,1);
    
end

