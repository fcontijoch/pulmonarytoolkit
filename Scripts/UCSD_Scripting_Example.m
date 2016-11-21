clear; clc;
PTKAddPaths;
%%
ptk_main = PTKMain;

source_path = 'C:\Users\Jacqueline\Dropbox\CTEPH\MATLAB code\Datasets\CTEPH_0008\97272748\03713398';
source_path = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
% Tutorial 3 says PTKDiskUtilities which is incorrect

dataset = ptk_main.CreateDatasetFromInfo(file_infos);
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
PTKVisualiseIn3D([],lungs,4,false,reporting);
%%
PTKViewer(lungs);
%%
PTKViewer(vessels_big);

%%
PTKSaveAs(lobes, 'Patient Name', '/Users/fcontijoch/Documents/UCSD/Images/PCTA/CTEPH_0008/',true);
