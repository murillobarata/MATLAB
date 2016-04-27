function [ acc ] = acuraciaKNN( ouro, resultado )
%MATRIZCONFUSAO Summary of this function goes here
%   Detailed explanation goes here

    ol = size(ouro,1);
    rl = size(resultado,1);
    
    p = 0;
    n = 0;
    
    if (ol ~= rl)
        'Erro: Matrizes com dimensoes diferentes'
    else
       for i = 1:ol
           if ouro(i) == resultado(i)
               p = p + 1;
           else
               n = n + 1;
           end
       end
    end
    
    acc = p/ol;

end

