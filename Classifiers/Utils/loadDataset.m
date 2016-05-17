function base = loadDataset( filename )

    data = load(filename);
    
    addpath('../Datasets/');
    addpath('../Utils/');

    base.x = data(:, 1:end-1); %Caracteristicas%
    base.x = normalizar(base.x, 3);

    base.y = data(:, end); %Classe%

end

