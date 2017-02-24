clc; clear;

%% Load Patient Datasets
source_names = {'carcinomix', 'BPA_0003','patient1','patient2','patient3'};
path_names = {'/Users/roshniravindran/Modeling/Datasets/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5','/Users/roshniravindran/Modeling/Datasets/BPA_0003/15352527','/Users/roshniravindran/Modeling/Datasets/orig_imgs', '/Users/roshniravindran/Modeling/Datasets/orig_imgs 2','/Users/roshniravindran/Modeling/Datasets/orig_imgs 3'};

timeArray = {};
% Get specific patient dataset
for i=1:numel(source_names)
    elapsedTime = UCSD_ScriptingEx_Roshni(path_names{i});
    timeArray{end+1} = elapsedTime;
end
