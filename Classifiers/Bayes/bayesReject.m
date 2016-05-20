function output = bayesReject( base, epocas, pctgTreino, custos )
%BAYESREJECT: output = bayesReject( DATASET, EPOCH, Training Percentage, COSTS)
%      Funcao para classificacao de um conjunto de dados utilizando a regra
% de Bayes com rejeicao.

    numRepeticoes = epocas;
    acc = zeros(1, epocas);
    erro = zeros(1, epocas);
    rejectIdx = zeros(1, epocas);
    
    for i = 1:numRepeticoes

        baseEmbaralhada = embaralharDados(base);
        
        [treino, teste] = dividirBase(baseEmbaralhada, pctgTreino);
        
        % Treino %
        modelo = BayesTrain( treino );
        
        % Teste %
        resultadoTeste = RejectBayesClassifier(teste.x, modelo, custos);

        qntdAcertos = sum(resultadoTeste.classes == teste.y');
        acc(i) = qntdAcertos/resultadoTeste.qntdClassificados;
        erro(i) = 1-acc(i);
        rejectIdx(i) = resultadoTeste.qntdRejeitados/size(resultadoTeste.classes,2);
        numberRejectSamples(i) = resultadoTeste.qntdRejeitados;
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
    
    hold on
    figure, bar((1:epocas), fix(numberRejectSamples), 0.7,'FaceColor',[0 .5 .5], 'EdgeColor',[0 .9 .9],'LineWidth', .6);
%     figure, plot((1:epocas), fix(numberRejectSamples), 'o');
    title('Rejection Graph');
    xlabel('Epoch'); xlim([0.5 epocas+0.5]);
    ylabel('Number of Rejected Samples'); ylim([0 max(numberRejectSamples)+5]);
    hold off
    
    accMean = mean(acc);
    erroMean = mean(erro);
    rejectMean = mean(rejectIdx);
    t1 = sprintf('Acuracia media: %s', num2str(accMean));
    t2 = sprintf('Erro medio: %s', num2str(erroMean));
    t3 = sprintf('Rejeicao media: %s', num2str(rejectMean));
    disp(t1);
    disp(t2);
    disp(t3);
    
    output.acc = acc;
    output.meanAcc = accMean;
    output.error = erro;
    output.meanError = erroMean;
    %output.classificationResult = resultadoTeste.classes;
    output.rejectIdx = rejectIdx;
    output.rejectMean = rejectMean;

end

