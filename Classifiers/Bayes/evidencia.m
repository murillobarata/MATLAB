function output = evidencia( teste, modelo ) 
    numeradorPosterioriX=[];
    
    for i = 1:3
        numeradorPosterioriX(i, :) = modelo.apriori(i) * mvnpdf(teste.x, modelo.media(:, :, i), modelo.matCov(:, :, i))';
    end
    
    output.evidencia = sum(numeradorPosterioriX);
    output.nPosteriori = numeradorPosterioriX;
end

