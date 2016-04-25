function [ treino, teste ] = dividirBase( base, pctgTreino )
%DIVIDIRBASE: [treino, teste] = dividirBase( base, pctgTreino )
%   Essa funcao recebe uma base de dados como entrada e um valor entre 0 e
%   1, relativo a porcentagem de treino. A funcao embaralha os dados da
%   base e retorna uma estrutura com a base de treino e com a base de
%   teste.

    n = size(base.x,1);
    limiar = ceil(pctgTreino*n);
    treino.x = base.x(1:limiar, :);
    treino.y = base.y(1:limiar, :);
    teste.x = base.x(limiar+1:end, :);
    teste.y = base.y(limiar+1:end, :);
    
end

