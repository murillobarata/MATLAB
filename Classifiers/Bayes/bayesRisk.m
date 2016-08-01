function output = bayesRisk( base, epocas, pctgTreino, riskMatrix )
%BAYESRISK output = bayesRisk( DATASET, EPOCH, Training Percentage, riskMatrix )
%   Funcao para classificacao bayesiana com base em uma matriz de risco.

    numRepeticoes = epocas;
    acc = zeros(1, epocas);
    erro = zeros(1, epocas);
    
    for i = 1:numRepeticoes

        baseEmbaralhada = embaralharDados(base);
        
        [treino, teste] = dividirBase(baseEmbaralhada, pctgTreino);
        
        % Treino %
        modelo = BayesTrain( treino );
        
        % Teste %
        resultadoTeste = RiskBayesClassifier(teste.x, modelo, riskMatrix);

        s = sum(resultadoTeste.classes == teste.y');
        acc(i) = s/size(resultadoTeste.classes,2);
        erro(i) = 1-acc(i);  
    end

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

