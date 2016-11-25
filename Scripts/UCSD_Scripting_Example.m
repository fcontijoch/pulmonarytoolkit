clear; clc;
PTKAddPaths;
%%
ptk_main = PTKMain;
source_path = '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0010/orig_imgs';
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
% Tutorial 3 says PTKDiskUtilities which is incorrect

% Please remove cache when re-running results
%dataset.DeleteCacheForThisDataset;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
%%
%lobes = dataset.GetResult('PTKLobes');
lungs = dataset.GetResult('PTKLeftAndRightLungs');
vessels = dataset.GetResult('PTKVesselness');
%%
vessels2 = dataset.GetResult('PTKVesselnessDilated');

%%
%vessels_big = dataset.GetResult('PTKVesselness');
%%
reporting = ptk_main.ReportingWithCache;
%%
%this does not work: must fix
%PTKVisualiseIn3D([],vessels2,4,false,reporting);
%%

%% Check if we can run vessel code on whole image, not lung restricted

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
