clear; clc;
PTKAddPaths;
%% load dataset
source_path3 = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';

%%remove cache
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);

