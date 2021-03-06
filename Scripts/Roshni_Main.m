function Roshni_Main(fldr)

cd fldr
fldInfo = dir;
source_names = {fldInfo(:).name};
path_names = {fldInfo(:).folder};

%% Load Patient Datasets
source_names = {'BPA_0003','BPA201701','cteph008'};
path_names = {'/Users/roshniravindran/Modeling/Datasets/BPA_0003/15352527','/Users/roshniravindran/Modeling/Datasets/orig_imgs', '/Users/roshniravindran/Modeling/Datasets/orig_imgs 3'};

%source_names = {'carcinomix'};
%path_names = {'/Users/roshniravindran/Modeling/Datasets/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5'};

timeArray = {}; lungArray = {}; vesselArray = {};

% Get parameters for each patient dataset and save them
for i=1:numel(source_names)

    for j= [15]
        [lungs_dilated,vessels_dilated,elapsedTime] = UCSD_ScriptingEx_Roshni(source_names{i},path_names{i}, j);

        timeArray{end+1} = elapsedTime;
        lungArray{end+1} = lungs_dilated;
        vesselArray{end+1} = vessels_dilated;
    
    end
    
    file_name = strcat(source_names{i},'_','PTKArrays.mat');
    save(file_name,'timeArray','lungArray','vesselArray');
    
    timeArray = {}; lungArray = {}; vesselArray = {};
end
end

