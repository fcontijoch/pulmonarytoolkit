clear; clc;
PTKAddPaths;
%% load dataset
source_path = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';

%%
%make dataset and default reporting object
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);

ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%%
% Segmentation
%threshold_image = dataset.GetResult('PTKUnclosedLungIncludingTrachea');
%[airway_tree, airway_image] = dataset.GetResult('PTKAirways');
%size_dilation_mm = 2.5;
%max_generation = 3;

%lungs = dataset.GetResult('PTKLeftAndRightLungs');
%lobes = dataset.GetResult('PTKLobes');

lung_notrachea = dataset.GetResult('PTKUnclosedLungExcludingTrachea');
%%
%visualize 2D
PTKViewer(lung_notrachea);

%visualize 3D



