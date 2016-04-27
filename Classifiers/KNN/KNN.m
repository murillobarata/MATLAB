function output = KNN(base, k, nEpoch, pctgTreino)

    classificacao.x = [];
    classificacao.y = [];
    acc = [];

    for i = 1:nEpoch
        %Embaralhar os dados%
        baseEmbaralhada = embaralharDados(base);

        %Dividir a base em Treino e Teste%
        [treino, teste] = dividirBase(baseEmbaralhada, pctgTreino);

        %Executar KNN%
        resultados = fKNN(treino, teste, k);

        %Guardar resultados:
        classificacao.x = [classificacao.x;teste.x];
        classificacao.y(:,i) = [resultados.classe];
        acc(:,i) = [resultados.acuracia];
    end

    output.acc = acc;
    output.meanAcc = mean(acc);
    
end



% bar(acc, 'BarWidth',0.8,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1);
% % %plot(acc, 'g^-');
% title( 'KNN Accuracy Graphic' );
% ylabel( 'Accuracy (%)' );
% xlabel( 'Epoch' );
% axis( [ 0 51 0.1 1.0 ] );
