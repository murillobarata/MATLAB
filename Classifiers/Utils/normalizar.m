function output = normalizar( dados, opcao )
%NORMALIZA DADOS: output = normalizar( dados, opcao )
% [1] - (dados - media)./(max - min)
% [2] - (dados - min) ./ max

[lin, ~] = size(dados);

if (opcao == 1)
    minimo = min(dados);
    maximo = max(dados);
    media = mean(dados);
    minRep = repmat(minimo, lin, 1);
    maxRep = repmat(maximo, lin, 1);
    mediaRep = repmat(media, lin, 1);
    dataset = (dados - mediaRep)./(maxRep - minRep);
elseif (opcao == 2)
    dataset = dados - min(dados(:));
    dataset = dataset ./ max(dados(:));
elseif (opcao == 3)
    range = [0 1];
    maximos = max(dados);
    minimos = min(dados);
    T = dados - repmat( minimos,[size(dados,1) 1]);
    T = T ./ repmat( maximos - minimos,[size(dados,1) 1]);

    T = T * (range(2) - range(1)) ;
    T = T + range(1);

    dataset = T;
end

    output = dataset;
end