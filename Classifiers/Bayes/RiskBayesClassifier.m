function output = RiskBayesClassifier( x, modelo, riskMatrix )
%RiskBayesClassifier: output = BayesRiskTest( DATASET, MODELO, RISKMATRIX )
%   Funcao para classificacao de um conjunto de dados com base em um modelo
%   de treino e uma matriz de risco. 

    for j = 1:length(riskMatrix)
        out = [];
        for k = 1:length(riskMatrix)
            out(k, :) = (riskMatrix(k,j) .* mvnpdf(x, modelo.media(:, :, k), modelo.matCov(:, :, k))') .* ... 
                modelo.apriori(k);
        end
        loss(j,:) = sum(out);
    end        
        
    [output.valores, output.classes] = min(loss);

end

