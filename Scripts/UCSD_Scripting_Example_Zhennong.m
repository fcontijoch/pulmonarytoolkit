clc;clear;
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
lungsxx = dataset.GetResult('PTKLeftAndRightLungs');
vesselsxx = dataset.GetResult('PTKVesselness');
vessels2xx = dataset.GetResult('PTKVesselnessDilated');
%%
%lobes = dataset.GetResult('PTKLobes');
%vessels = dataset.GetResult('PTKVesselness');
%vessels2 = dataset.GetResult('PTKVesselnessDilated');
%% Dilation and erosion
radius=3;
figure(1);
imagesc(lungs.RawImage(:,:,100));

lungs2 = lungs.RawImage;
lungs2dilation = imdilate(lungs2,strel('sphere',radius));




