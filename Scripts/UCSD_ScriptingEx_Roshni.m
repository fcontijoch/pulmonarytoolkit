function [lungs_dilated, vessels_dilated, elapsedTime] = UCSD_ScriptingEx_Roshni(source_name,sourcepath, rad)
PTKAddPaths;

%% load dataset
%make dataset and default reporting object
file_infos = PTKDicomUtilities.GetListOfDicomFiles(sourcepath);
ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%% Segmentation
elapsedTime = [];

% dilation/ erosion defined in PTKGetLeftAndRightLungs
global dil_rad
dil_rad = rad;

tic
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
vessels_dilated = dataset.GetResult('PTKVesselness');

elapsedTime = [elapsedTime toc];
 
SaveDicomImages_Roshni(source_name, lungs_dilated,vessels_dilated,reporting);
%% visualize 2D
%PTKViewer(vessels_dilated);

   

