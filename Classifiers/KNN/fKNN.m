function [ resultados ] = fKNN(treino, teste, k)
%KNN [ resultados ] = KNN(treino, teste, k)
%   Essa funcao recebe uma base de treino, uma base de teste e um valor k,
%   inteiro. Ela retorna um vetor, com a quantidade de linhas do vetor de
%   teste, que contem as classes atribu?das atraves da distancia
%   euclidiana.
    
    qt = size(teste.x,1); %Quantidade de elementos para teste.
    distancias = pdist2(treino.x, teste.x);
    [~, posicoes] = sort(distancias);
    r = [];
    
    for i = 1:qt
        %Obter os K vizinhos menores%
        vizinhos.x = treino.x(posicoes(1:k,i),:);
        vizinhos.y = treino.y(posicoes(1:k,i),:);
        
        classe = mode(vizinhos.y); 
        r = [r; classe];
    end
    
    resultados.classe = r;
    
    %Calcular acuracia.
    resultados.acuracia = acuraciaKNN(teste.y, resultados.classe);
end

