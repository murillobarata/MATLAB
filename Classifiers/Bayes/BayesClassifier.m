function output = BayesClassifier( teste, modelo, tipo )
    if strcmp(tipo, '')
        tipo = 'mvnpdf';
    end
    
    gi = g(teste.x, modelo, tipo);
    
    if (strcmp(tipo, 'eclidianDistance') || strcmp(tipo, 'mahalanobisDistance'))
        [valores, classes] = min(gi); 
    else
        [valores, classes] = max(gi);
    end
    
    output.valores = valores;
    output.classes = classes;
end

