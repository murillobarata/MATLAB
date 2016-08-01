function output = g(x, modelo, tipo)
%% output = g(dados, modelo, tipo)
%A funcao g classifica os dados contidos em X, de acordo com um MODELO (BayesTrain) de treinamento.
% A classificacao e feita com base no TIPO que pode ser:
% 1. mvnpdf - default
% 2. quadratica
% 3. matCovIgual
% 4. matCovMean
% 5. matCovAll
% 6. matCovDiagIgual
% 7. equiprovavelCovDif
% 8. equiprovavelCovIgual
% 9. eclidianDistance
% 10. mahalanobisDistance

    if strcmp(tipo, 'mvnpdf')
        % Calculo sobre a equacao de Bayes direto. A unica modificacao esta
        % na ausencia da evidencia.
        evdc = evidencia(x, modelo);
        for i = 1:length(modelo.apriori)
            %gOut(i, :) = (modelo.apriori(i) * mvnpdf(x, modelo.media(:, :, i), modelo.matCov(:, :, i))');
            gOut(i, :) = evdc.nPosteriori(i,:)./evdc.evidencia ;
        end
    elseif strcmp(tipo,'quadratica')
        % Leva em consideracao que as matrizes de covariancia sao
        % diferentes e que as classes nao sao equiprovaveis.
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                ci = -(1/2)*(log(2*pi))-(1/2)*(log(det(modelo.matCov(:, :, i))));
                a = (x(j,:) - modelo.media(:,:,i));
                s = inv(modelo.matCov(:, :, i));
                
                gi = -1/2 * (a) * (s) * (a') + (log(modelo.apriori(i))) + ci;
                gOut(i, j) = gi; 
            end
        end
    elseif strcmp(tipo,'matCovIgual')
        % Considera as matrizes de covariancia das classes iguais,
        % portanto, utiliza apenas a primeira para realizar o calculo.
        s = modelo.matCov(:, :, 1);
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                a = (1/2)*(x(j,:))*(inv(s))*(modelo.media(:, :, i)');
                b = (1/2)*(modelo.media(:, :, i))*(inv(s))*(modelo.media(:, :, i)');
                c = (1/2)*(modelo.media(:, :, i))*(inv(s))*(x(j,:)');
                d = log(modelo.apriori(i));

                gi = a-b+c+d;
                gOut(i, j) = gi;
            end
        end
    elseif strcmp(tipo, 'matCovMean')
        % Semelhante ao metodo acima, porem, ao inves de considerar a
        % matriz de covariancia de uma classe especifica, considera-se a
        % media entre as matrizes de covariancia das classes.
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                a = (1/2)*(x(j,:))*(inv(modelo.meanCovBtClass))*(modelo.media(:, :, i)');
                b = (1/2)*(modelo.media(:, :, i))*(inv(modelo.meanCovBtClass))*(modelo.media(:, :, i)');
                c = (1/2)*(modelo.media(:, :, i))*(inv(modelo.meanCovBtClass))*(x(j,:)');
                d = log(modelo.apriori(i));

                gi = a-b+c+d;
                gOut(i, j) = gi;
            end
        end
    elseif strcmp(tipo, 'matCovAll')
        % Utiliza uma matriz de covariancia calculada para todos os dados,
        % sem distingui-los por classe.
        s = modelo.matCovAll;
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                a = (1/2)*(x(j,:))*(inv(s))*(modelo.media(:, :, i)');
                b = (1/2)*(modelo.media(:, :, i))*(inv(s))*(modelo.media(:, :, i)');
                c = (1/2)*(modelo.media(:, :, i))*(inv(s))*(x(j,:)');
                d = log(modelo.apriori(i));

                gi = a-b+c+d;
                gOut(i, j) = gi;
            end
        end  
    elseif strcmp(tipo, 'matCovDiagIgual')
        % Considera as matrizes de covariancia das classes iguais e que
        % elas sao diagonais.
        variancia = mean(diag(modelo.meanCovBtClass));
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                a = (1/variancia)*(modelo.media(:, :, i))*x(j,:)';
                b = log(modelo.apriori(i));
                c = (1/2)*(modelo.media(:, :, i))*(1/variancia)*(modelo.media(:, :, i)');

                gi = a+b-c;
                gOut(i, j) = gi; 
            end
        end
    elseif strcmp(tipo, 'equiprovavelCovDif')
        % Considera que as classes sao equiprovaveis e que a matriz de
        % covariancia de cada classe e diferente.
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                a = (x(j,:) - modelo.media(:,:,i));
                s = inv(modelo.matCov(:, :, i));
                
                gi = -1/2 * (a) * (s) * (a');
                gOut(i, j) = gi; 
            end
        end
    elseif strcmp(tipo, 'equiprovavelCovIgual')
        % Considera que as classes sao equiprovaveis e que as matrizes de
        % covariancia de cada classe sao iguais.
        for j = 1:size(x, 1)
            for i = 1:length(modelo.apriori)
                a = (x(j,:) - modelo.media(:,:,i));
                s = inv(modelo.meanCovBtClass);
                
                gi = -1/2 * (a) * (s) * (a');
                gOut(i, j) = gi; 
            end
        end
    elseif strcmp(tipo, 'eclidianDistance')
        for i = 1:length(modelo.apriori)
            gi = pdist2(modelo.media(:,:,i), x);
            gOut(i, :) = gi;
        end
    elseif strcmp(tipo, 'mahalanobisDistance')
        for i = 1:length(modelo.apriori)
            gi = pdist2(modelo.media(:,:,i), x, 'mahalanobis', modelo.meanCovBtClass);
            gOut(i, :) = gi;
        end
    end
    output = gOut;
end

