function output = BayesTrain( treino )

    qntdClasses = length(unique(treino.y));
    
    for i = 1:qntdClasses
       indClass = find(treino.y == i);
        %% Calcular a Media de cada classe %%
       media(:, :, i) = mean(treino.x(indClass,:));

       %% Calcular a Probabilidade a Priori %%
       prioriClasse(i) = length(treino.x(indClass, :))/ length(treino.x);

       %% Calcular a Matriz de Covariancia de cada classe %%
       matCov(:, :, i) = cov(treino.x(indClass,:));
       if (rcond(matCov(:, :, i)) < 1e-12)
        matCov(:, :, i) = matCov(:, :, i) + 0.01*eye(size(treino.x,2));
       end

       %% Calcular a Matriz de Covariancia considerando todas as classes %%
       covAll = cov(treino.x);
       
    end
    
    output.media = media;
    output.apriori = prioriClasse;
    output.matCov = matCov;
    output.meanCovBtClass = mean(matCov, 3);
    output.matCovAll = covAll;

end