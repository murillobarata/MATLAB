function resultado = RejectBayesClassifier(  x, modelo, custos )
%REJECTBAYESCLASSIFIER: output = bayesReject( DATASET, MODELO, CUSTOS)
%      Funcao para classificacao de um conjunto de dados com base em um modelo
%   de treino e nas taxas de custos.

    evdc = evidencia(x, modelo);
    for i = 1:length(modelo.apriori)
        out(i, :) = (evdc.nPosteriori(i,:)./evdc.evidencia);
    end
    
    indiceRejeicao = (custos.rejeitar - custos.acertar) / ...
        (custos.errar - custos.acertar);
    
    [resultado.valores, resultado.classes] = max(out);
    
%     if ( indiceRejeicao <= 0.5 )
        classificadosMatriz = (resultado.valores >= indiceRejeicao);
        
        resultado.qntdClassificados = sum(classificadosMatriz);
        resultado.qntdRejeitados = size(out, 2) - resultado.qntdClassificados;
        
        resultado.valores = resultado.valores .* classificadosMatriz;
        resultado.classes = resultado.classes .* classificadosMatriz; 
%     else
%         resultado = [];
%     end
end

