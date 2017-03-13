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
global dil_rad; global sigma_var; 
dil_rad = rad;sigma_var = .1;


tic
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
vessels_dilated = dataset.GetResult('PTKVesselness');
elapsedTime = [elapsedTime toc];

lung_mask = GetLungMask_Roshni(lungs_dilated,dataset);
%lung_mask = mask_dilated.RawImage;
%imagesc(lung_mask(:,:,110)); %view lung_mask at any arbitrary pt

SaveDicomImages_Roshni(source_name, lungs_dilated,vessels_dilated,lung_mask,reporting);

%% Vary Sigma
% %for sigma_var = [1,1.25,1.5,1.75,2,3,4,5]
%     dataset.DeleteCacheForThisDataset;
%     vessels_dilated = dataset.GetResult('PTKVesselness');
%     
%     PTKViewer(vessels_dilated);
%     SaveDicomImages_Roshni(source_name, lungs_dilated,vessels_dilated,reporting);
% 
% end

%% visualize 2D
%PTKViewer(vessels_dilated);

   

