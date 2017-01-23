clear; clc;
PTKAddPaths;
fprintf('PTKAddPath \n');

%% Note, until we fix this issue, please update the file path correctly for for the source_path variable, and the PTK save function calls at the bottom! Thanks -Pranav
ptk_main = PTKMain;
source_path = '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/orig_imgs';
source_path2 = 'C:\Users\Jacqueline\Dropbox\CTEPH\MATLAB code\Datasets\CTEPH_0008\97272748\03713398';
source_path3 = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';
source_path = '/Users/fcontijoch/Documents/UCSD/Images/PCTA/Bpa_201701/orig_imgs';
fprintf('source_paths \n')
%%
%IMPORTANT! READ THIS: Please remove cache when re-running results
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
% Tutorial 3 says PTKDiskUtilities which is incorrect
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
%dataset = ptk_main.CreateDatasetFromInfo(file_infos);
dataset.DeleteCacheForThisDataset;
%% Segmentations
lungs = dataset.GetResult('PTKLeftAndRightLungs');
lobes = dataset.GetResult('PTKLobes');
vessels = dataset.GetResult('PTKVesselness');
vessels2 = dataset.GetResult('PTKVesselnessDilated');

%%
dataset.ClearCacheForThisDataset(false);

clc
vesselsWhole = dataset.GetResult('PTKVesselnessWhole');
vesselsDilated = dataset.GetResult('PTKVesselnessDilated');

clc

% Reporter
reporting = ptk_main.ReportingWithCache;
dir_files='/Users/fcontijoch/Documents/UCSD/Images/PCTA/Bpa_201701/ptk_vessels10A';
mkdir(dir_files);
PTKSaveImageAsDicom(vesselsWhole,dir_files, 'vessels', 'BPA201701 Vessels 10A', true, reporting)

dir_files='/Users/fcontijoch/Documents/UCSD/Images/PCTA/Bpa_201701/ptk_vessels10B';
mkdir(dir_files);
PTKSaveImageAsDicom(vesselsDilated,dir_files, 'vessels', 'BPA201701 Vessels 10B', true, reporting)
%%

%PTKVisualiseIn3D([],lungs,4,false,reporting);

%this does not work: must fix
%PTKVisualiseIn3D([],vessels2,4,false,reporting);
%%

%% Trying to dilate rightlungROI and leftlungROI in order to add additional parts of lungs into the image 
lungs = dataset.GetResult('PTKLeftAndRightLungs');
rollingball= offsetstrel('ball', 5,5); 
dilatedRightLungROI=imdilate(lungs, rollingball)
PTKviewer(dilatedRightLungROI)
fprintf('it ran')



%% Check if we can run vessel code on whole image, not lung restricted (commented out for now b/c did not work)

%vessels_all = dataset.GetResult('PTKVesselness');
%%
PTKViewer(lungs);
%%
PTKViewer(vesselsDilated);

%%
PTKSaveImageAsDicom(vesselsWhole,'/Users/fcontijoch/Documents/UCSD/Images/PCTA/Bpa_201701/ptk_vessels2', 'vessels', 'BPA201701', true, reporting)
%%
dir_files='/Users/fcontijoch/Documents/UCSD/Images/PCTA/Bpa_201701/ptk_vessels10C';
mkdir(dir_files);

PTKSaveAs(vesselsDilated,'Patient Name',dir_files, 0, reporting)
%%
%when saving use filter index 0. 
PTKSaveAs(lungs, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/',0,reporting);

%%
PTKSaveAs(vessels, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/',0,reporting);
%%
PTKSaveAs(vessels2, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/',0,reporting);
