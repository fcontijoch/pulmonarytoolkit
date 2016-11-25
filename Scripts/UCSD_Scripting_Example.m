clear; clc;
PTKAddPaths;
%% Note, until we fix this issue, please update the file path correctly for for the source_path variable, and the PTK save function calls at the bottom! Thanks -Pranav
ptk_main = PTKMain;
source_path = '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/orig_imgs';
source_path2 = 'C:\Users\Jacqueline\Dropbox\CTEPH\MATLAB code\Datasets\CTEPH_0008\97272748\03713398';
source_path3 = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';

%%
%IMPORTANT! READ THIS: Please remove cache when re-running results
%dataset.DeleteCacheForThisDataset;
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
% Tutorial 3 says PTKDiskUtilities which is incorrect
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
%% Segmentations
%lobes = dataset.GetResult('PTKLobes');
lungs = dataset.GetResult('PTKLeftAndRightLungs');
vessels = dataset.GetResult('PTKVesselness');
vessels2 = dataset.GetResult('PTKVesselnessDilated');

%% Reporter
reporting = ptk_main.ReportingWithCache;
%%

%PTKVisualiseIn3D([],lungs,4,false,reporting);

%this does not work: must fix
%PTKVisualiseIn3D([],vessels2,4,false,reporting);
%%

%% Check if we can run vessel code on whole image, not lung restricted (commented out for now b/c did not work)

%vessels_all = dataset.GetResult('PTKVesselness');
%%
PTKViewer(lungs);
%%
PTKViewer(vessels2);

%%
%when saving use filter index 0. 
PTKSaveAs(lungs, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/',0,reporting);

%%
PTKSaveAs(vessels, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/',0,reporting);
%%
PTKSaveAs(vessels2, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/',0,reporting);
