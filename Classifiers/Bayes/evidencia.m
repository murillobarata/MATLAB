function output = evidencia( teste, modelo ) 
    numeradorPosterioriX=[];
    
    for i = 1:length(modelo.apriori)
        numeradorPosterioriX(i, :) = modelo.apriori(i) * mvnpdf(teste, modelo.media(:, :, i), modelo.matCov(:, :, i))';
    end
    
    output.evidencia = sum(numeradorPosterioriX);
    output.nPosteriori = numeradorPosterioriX;
end

