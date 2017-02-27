clc; clear;

%% Load Patient Datasets
source_names = {'carcinomix', 'BPA_0003','BPA201701','cteph008'};
path_names = {'/Users/roshniravindran/Modeling/Datasets/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5','/Users/roshniravindran/Modeling/Datasets/BPA_0003/15352527','/Users/roshniravindran/Modeling/Datasets/orig_imgs', '/Users/roshniravindran/Modeling/Datasets/orig_imgs 3'};


timeArray = {}; lungArray = {}; vesselArray = {};
% Get specific patient dataset
for i=1:numel(source_names)

    for j = [5, 10, 15, 20]
        [lungs_dilated,vessels_dilated,elapsedTime] = UCSD_ScriptingEx_Roshni(source_names{i},path_names{i}, j);

        timeArray{end+1} = elapsedTime;
        lungArray{end+1} = lungs_dilated;
        vesselArray{end+1} = vessels_dilated;
    
    end
end
