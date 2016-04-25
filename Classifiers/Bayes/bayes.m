function output = bayes( base, epocas, pctgTreino, tipo )
%BAYES: output = bayes( DATASET, EPOCH, Training Percentage, TYPE )
%   Essa funcao classifica um conjunto de dados de acordo com uma base de
%   teste. Sao retornados as classes da base de treino, bem como acuracia
%   media e acuracia especifica de cada epoca, juntamente com o erro. Um
%   grafico de como os dados de teste foram classificados eh exibido
%   juntamente a um grafico de barras da acuracia e do erro.
% A classificacao eh feita com base no TIPO, que pode ser:
% 1. mvnpdf - default (calcula diretamente a regra basica de bayes)
% 2. quadratica (calcula com base na equacao quadratica)
% 3. matCovIgual (considera que as matrizes de covariancia de cada classe
% sao iguais.)
% 4. matCovMean (considera que as matrizes de covariancia de cada classe
% sao iguais e utiliza a media entre elas para o calculo.)
% 5. matCovAll (considera apenas uma matriz de covariancia, que e calculada
% cosiderando todos os elemento, sem distincao por classe.)
% 6. matCovDiagIgual (considera que, alem das matrizes de covariancia serem
% iguais, elas sao diagonais.)
% 7. equiprovavelCovDif (considera que as classes sao equiprovaveis e que
% a matriz de covariancia de cada classe e diferente.)
% 8. equiprovavelCovIgual (considera que as classes sao equiprovaveis e que
% as matrizes de covariancia de cada classe sao iguais.)
% 9. eclidianDistance (classificador com base na distancia euclidiana,
% considera apenas a media.)
% 10. mahalanobisDistance (classificador com base na distancia mahalanobis,
% que considera as medias de cada classe e uma matriz de covariancia unica.)

    numRepeticoes = epocas;
    acc = zeros(1, epocas);
    erro = zeros(1, epocas);
    
    for i = 1:numRepeticoes

        baseEmbaralhada = embaralharDados(base);
        
        [treino, teste] = dividirBase(baseEmbaralhada, pctgTreino);

        modelo = BayesTrain( treino );

        resultadoTeste = BayesTest(teste, modelo, tipo);

        s = sum(resultadoTeste.classes == teste.y');
        acc(i) = s/size(resultadoTeste.classes,2);
        erro(i) = 1-acc(i);  
    end

%    surfaceDecision(teste, resultadoTeste, length(unique(treino.y)), 1, 2);
%    surfaceDecision(teste, resultadoTeste, length(unique(treino.y)), size(teste.x,2)-1, size(teste.x,2));

    hold on
    bar((1:epocas), acc, 0.7,'FaceColor',[0 .5 .5], 'EdgeColor',[0 .9 .9],'LineWidth', .6);
    title('Accuracy Graph');
    xlabel('Epoch'); xlim([0.5 epocas+0.5]);
    ylabel('Accuracy'); ylim([0 1]);
    hold off
    
    hold on
    figure, bar((1:epocas), erro, 0.7, 'FaceColor',[0 .5 .5], 'EdgeColor', [0 .9 .9],'LineWidth', .6);
    title('Error Graph');
    xlabel('Epoch'); xlim([0.5 epocas+0.5]);
    ylabel('Error'); ylim([0 1]);
    hold off
    
    accMean = mean(acc);
    erroMean = mean(erro);
    t1 = sprintf('Acuracia media: %s', num2str(accMean));
    t2 = sprintf('Erro medio: %s', num2str(erroMean));
    disp(t1);
    disp(t2);
    
    output.acc = acc;
    output.meanAcc = accMean;
    output.error = erro;
    output.meanError = erroMean;
    output.classificationResult = resultadoTeste.classes;
    
end

