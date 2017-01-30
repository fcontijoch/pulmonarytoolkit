clear; clc;
PTKAddPaths;
%%
ptk_main = PTKMain;
source_path = 'E:/Senior design/dataset/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';
%%
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
dataset = ptk_main.CreateDatasetFromInfo(file_infos);

reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;
fprintf('c')

%% Segmentation
lungs = dataset.GetResult('PTKLeftAndRightLungs');
%%
lobes = dataset.GetResult('PTKLobes');
vessels = dataset.GetResult('PTKVesselness');
vessels2 = dataset.GetResult('PTKVesselnessDilated');
%%
PTKViewer(lungs)
%% Trying to dilate rightlungROI and leftlungROI in order to add additional parts of lungs into the image 
X=dicomread(lungs);
%%
rollingball= offsetstrel('ball', 5,5); 
%% Expected input number 1, IM, to be one of these types:numeric, logical
%%how to convert PTKDicomImage into nueric or logical??
dilatedRightLungROI=imdilate(lungs,rollingball)
%%
PTKviewer(dilatedRightLungROI)
fprintf('it ran')

