function output = DMC(base, nEpoch, pctgTreino)

    classificacao.x = [];
    classificacao.y = [];
    
    for i = 1:nEpoch
        %Embaralhar os dados%
        base = embaralharDados(base);

        %Dividir a base em Treino e Teste%
        [treino, teste] = dividirBase(base, pctgTreino);

        %Executar Classificador.
        nClasses = length(unique(treino.y));
        resultados = fDMC(treino, teste, nClasses);
        classificacao.x = [classificacao.x;teste.x];
        classificacao.y(:,i) = [resultados.classes];
        acc(:,i) = [resultados.acuracia];
    end

    output.acc = acc;
    output.meanACC = mean(acc);
    
    % bar(acc, 'BarWidth',0.8,'FaceColor',[0 .45 .5],'EdgeColor',[0 .5 .9],'LineWidth',1);
    % %plot(acc, 'g^-');
    % title( 'DMC Accuracy Graphic' );
    % ylabel( 'Accuracy (%)' );
    % xlabel( 'Epoch' );
    % axis( [ 0 51 0.8 1.0 ] );
end