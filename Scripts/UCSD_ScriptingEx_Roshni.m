function [lungs_dilated, vessels_dilated, elapsedTime] = UCSD_ScriptingEx_Roshni(source_name,sourcepath)
PTKAddPaths;

%% load dataset
%make dataset and default reporting object
file_infos = PTKDicomUtilities.GetListOfDicomFiles(sourcepath);

ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%% Lung Segmentation
elapsedTime = [];

% dilation/ erosion defined in PTKGetLeftAndRightLungs
global dil_rad; global sigma_var; 
dil_rad = 15;


tic
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
elapsedTime = [elapsedTime toc];


%SaveDicomImages_Roshni(source_name, lungs_dilated,vessels_dilated,lung_mask,reporting);
%SaveDicomImages_Roshni(source_name,[],vessels_dilated,[],reporting);

%% Vary Sigma
for sigma_var = .5:.05:3
     vessels_dilated = dataset.GetResult('PTKVesselness');
     %     PTKViewer(vessels_dilated);

     SaveDicomImages_Roshni(source_name,[],vessels_dilated,[],reporting);
end

 %% Lung Mask
 lung_mask = GetLungMask_Roshni(lungs_dilated,dataset);
%imagesc(lung_mask(:,:,110)); %view lung_mask at any arbitrary pt

%% Save Images

SaveDicomImages_Roshni(source_name, lungs_dilated,[],lung_mask,reporting);
%% visualize 2D
%PTKViewer(vessels_dilated);

   

