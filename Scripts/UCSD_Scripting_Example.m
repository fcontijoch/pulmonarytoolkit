clear; clc;
PTKAddPaths;
%%
ptk_main = PTKMain;


source_path = 'C:\Users\Jacqueline\Dropbox\CTEPH\MATLAB code\Datasets\CTEPH_0008\97272748\03713398';
source_path = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';

%source_path = '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0008/orig_imgs';

file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
% Tutorial 3 says PTKDiskUtilities which is incorrect

dataset = ptk_main.CreateDatasetFromInfo(file_infos);
% Please remove cache when re-running results
dataset.DeleteCacheForThisDataset;
%%
%lobes = dataset.GetResult('PTKLobes');
vessels = dataset.GetResult('PTKVesselness');
%%
lungs = dataset.GetResult('PTKLeftAndRightLungs');
%%
vessels2 = dataset.GetResult('PTKVesselnessDilated');

%%
vessels_big = dataset.GetResult('PTKVesselness');
%%
reporting = ptk_main.ReportingWithCache;
%%

%PTKVisualiseIn3D([],lungs,4,false,reporting);

%this does not work: must fix
%PTKVisualiseIn3D([],vessels2,4,false,reporting);
%%

%%
% Please remove cache when re-running results
dataset.DeleteCacheForThisDataset;
vessels_all = dataset.GetResult('PTKVesselness');

%%
PTKViewer(lungs);
%%
PTKViewer(vessels_big);

%%
%when saving use filter index 0. 
PTKSaveAs(lungs, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0008/',0,reporting);

%%
PTKSaveAs(vessels, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0008/',0,reporting);
%%
PTKSaveAs(vessels_all, 'Patient Name', '/Users/Pranav/Documents/CTEPH_DATASETS/CTEPH_0008/',0,reporting);
