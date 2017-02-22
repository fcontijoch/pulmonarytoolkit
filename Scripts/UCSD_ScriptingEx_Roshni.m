
clear; clc;
PTKAddPaths;

%% load dataset
source_carcinomix = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';
%%
%make dataset and default reporting object
<<<<<<< HEAD
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);



=======
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_carcinomix);
>>>>>>> 050a7d31d9f03cd76f72f25de06226ccbd4ccb12
ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%% Segmentation
%time this step for different dilation radii
tic
% dilation/ erosion defined in PTKGetLeftAndRightLungs
global dil_rad
dil_rad = 5;
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
vessels_dilated = dataset.GetResult('PTKVesselness');
toc

%% Save DICOM Images

        %make new file directory
        dir_files_lungs= strcat('/Users/roshniravindran/Modeling/pulmonarytoolkit_data/lungs', num2str(dil_rad));
        dir_files_vessels= strcat('/Users/roshniravindran/Modeling/pulmonarytoolkit_data/vessels', num2str(dil_rad));
        mkdir(dir_files_lungs, dir_files_vessels);

        %Patient ID
        str_pat_lungs = strcat('Carcinomix', 'lungs', num2str(dil_rad));
        str_pat_vessels = strcat('Carcinomix', 'vessels', num2str(dil_rad));
        
        %Save DICOM images
        PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
        
%% visualize 2D
%PTKViewer(lungs_dilated);

   

