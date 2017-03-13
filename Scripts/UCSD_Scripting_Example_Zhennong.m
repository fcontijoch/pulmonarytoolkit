clc;clear;
PTKAddPaths;
%%
global dil_rad
dil_rad =15;
%%
global ves_rad
for ves_rad = 0.1:0.1:0.9; %the range here should be determined based on Terrence's and Zhennong's results

%%
ptk_main = PTKMain;
source_path = 'E:/Senior design/dataset/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';
%source_path = 'E:/Senior design/dataset/BPA201701/orig_imgs';
%source_path = 'E:/Senior design/dataset/BPA_0003/BPA_0003/15352527/62776054';
%source_path = 'E:/Senior design/dataset/BPA201704/orig_imgs';
%source_path = 'E:/Senior design/dataset/CTEPH008/orig_imgs/';
%%
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
dataset = ptk_main.CreateDatasetFromInfo(file_infos);

reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;
fprintf('c')


%% Segmentation
%time this step for different dilation radii

% dilation/ erosion defined in PTKGetLeftAndRightLungs
%lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
vessels_dilated = dataset.GetResult('PTKVesselness');

%%
%lobes = dataset.GetResult('PTKLobes');
%vessels = dataset.GetResult('PTKVesselness');
%vessels2 = dataset.GetResult('PTKVesselnessDilated');
%% Save DICOM Images

        %make new file directory
        %dir_files_lungs= strcat('E:/Senior design/new dataset/lungs', num2str(dil_rad));
        dir_files_vessels= strcat('E:/Senior design/dataset/Carcinomix/vessels', num2str(ves_rad));
        mkdir(dir_files_vessels);

        %Patient ID
        %str_pat_lungs = strcat('Carcinomix', 'lungs', num2str(dil_rad));
        str_pat_vessels = strcat('Carcinomix', 'vessels', num2str(ves_rad));
        
        %Save DICOM images
        %PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs,'PTKImage',str_pat_lungs,true,reporting)
        PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
        
%% visualize 2D
%PTKViewer(lungs_dilated);
end;


