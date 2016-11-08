clear;
PTKAddPaths;

ptk_main = PTKMain;

source_path = '/Users/fcontijoch/Documents/UCSD/Images/PCTA/CTEPH_0008/97272748/03713398/';
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
% Tutorial 3 says PTKDiskUtilities which is incorrect

dataset = ptk_main.CreateDatasetFromInfo(file_infos);

lobes = dataset.GetResult('PTKLobes');
%%
PTKViewer(lobes);

%%
PTKSaveAs(lobes, 'Patient Name', '/Users/fcontijoch/Documents/UCSD/Images/PCTA/CTEPH_0008/',true);