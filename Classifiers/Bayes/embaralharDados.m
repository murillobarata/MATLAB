function baseOut = embaralharDados( baseIn )
%EMBARALHARDADOS: baseOut = embaralharDados( baseIn )
%   Essa funcao recebe uma base de dados como entrada e retorna a mesma
%   base, porem, com as linhas permutadas.

    %Numero de linhas%
    n = size(baseIn.x,1);

    %Embaralhar dados%
    i = randperm(n);
    baseOut.x = baseIn.x(i,:);
    baseOut.y = baseIn.y(i,:);
    
end