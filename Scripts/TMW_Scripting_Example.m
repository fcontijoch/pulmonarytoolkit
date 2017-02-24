clear; clc;
PTKAddPaths;
fprintf('PTKAddPath \n');

%% Note, until we fix this issue, please update the file path correctly for for the source_path variable, and the PTK save function calls at the bottom! Thanks -Pranav
ptk_main = PTKMain;
source_path = 'C:\Users\terre\Desktop\CT THORACO-ABDO\ARTERIELLES - 5';
fprintf('source_paths \n')
%%
%IMPORTANT! READ THIS: Please remove cache when re-running results
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);

% Tutorial 3 says PTKDiskUtilities which is incorrect
dataset = ptk_main.CreateDatasetFromInfo(file_infos);

%dataset = ptk_main.CreateDatasetFromInfo(file_infos);
dataset.DeleteCacheForThisDataset;

fprintf('cache removed \n')

%% Segmentations
%getting data from the image set
lungs = dataset.GetResult('PTKLeftAndRightLungs');
%lobes = dataset.GetResult('PTKLobes');
%vessels = dataset.GetResult('PTKVesselness');
%vessels2 = dataset.GetResult('PTKVesselnessDilated');
fprintf('data gathered \n') 

%% Original, Dilation, and Erosion Images 
%original image
radii=[5];
for rad=1;
    tic
    figure(1);
    imagesc(lungs.RawImage(:,:,100));
    f1=figure(1);  
    saveas(f1,['Original_rad' num2str(radii(rad)) '.png']);
%dilated image using sphere
    Lungs=lungs.RawImage; 
    Lungs_Dilation= imdilate(Lungs, strel('sphere', radii(rad))); 
    fprintf('lungs dilated at radii %.3f \n', radii(rad))
% figure for dilation
    figure(2);
    imagesc(Lungs_Dilation(:,:,100));
    f2=figure(2);
    saveas(f2,['Dilation_rad' num2str(radii(rad)) '.png']);
% eroded image 
    Lungs_Erosion=imerode(Lungs_Dilation, strel('sphere', radii(rad)));
    fprintf('lungs eroded at radii %.3f \n', radii(rad))
%figure for erosion 
    figure(3);
    imagesc(Lungs_Erosion(:,:,100));
    f3=figure(3);
    saveas(f3,['Erosion_rad' num2str(radii(rad)) '.png']);
    fprintf('It took %.3f to compute radius of %.3f \n', toc, radii(rad))    
end;
%% Segmentation Roshni trial
%time this step for different dilation radii
tic
% dilation/ erosion defined in PTKGetLeftAndRightLungs
global dil_rad
dil_rad = 5;
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
vessels_dilated = dataset.GetResult('PTKVesselness');
figure(1);
    imagesc(squeeze(lungs_dilated.RawImage(:,:,100)));
    f1=figure(1);
    saveas(f1,['lungs_dil' num2str(dil_rad) '.png']);
    figure(2);
    imagesc(squeeze(vessels_dilated.RawImage(:,:,100)));
    f2=figure(2);
    saveas(f1,['vessels_dil' num2str(dil_rad) '.png']);
toc

%% Trying to loop the dil_rad
global dil_rad
dil_rad=0 
for i=[5 5 0]
    tic 
    lungs_dilated = dataset.GetResult('PTKGetLeftAndRightLungs');
    toc 
    fprintf('It took %.3f to dilate lungs at radius %.3f \n', toc, dil_rad)
    figure(1);
    imagesc(squeeze(lungs_dilated.RawImage(:,:,100)));
    f1=figure(1);
    saveas(f1,['lungs_dil' num2str(dil_rad) '.png']);
    tic
    vessels_dilated = dataset.GetResult('PTKVesselness');
    
    v=imagesc(squeeze(vessels_dilated.RawImage(:,:,100)))
    toc 
    fprintf('It took %.3f to dilate vessels at radius %.3f \n', toc, dil_rad)
    figure(2);
    imagesc(squeeze(vessels_dilated.RawImage(:,:,100)));
    f2=figure(2);
    saveas(f1,['vessels_dil' num2str(dil_rad) '.png']);
    dil_rad =i+dil_rad
end
    %%
%make new file directory
        dir_files_lungs= strcat('C:\Users\terre\Desktop\dilation output\lungs_data', num2str(dil_rad));
        dir_files_vessels= strcat('C:\Users\terre\Desktop\dilation output\vessel_data', num2str(dil_rad));
        mkdir('dir_files_lungs', 'dir_files_vessels');

        %Patient ID
        str_pat_lungs = strcat('Carcinomix', 'lungs', num2str(dil_rad));
        str_pat_vessels = strcat('Carcinomix', 'vessels', num2str(dil_rad));
        
        %Save DICOM images
        PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)




%% Save DICOM Images 


v1=figure(4)
imagesc(vessels.RawImage(:,:,100))
v2=figure(5)
imagesc(vessels2.RawImage(:,:,10))
PTKViewer(vessels2)

%% Save DICOM Images

        %make new file directory
        dir_files_lungs= strcat('C:\Users\terre\Desktop\dilation output\lungs_data', num2str(dil_rad));
        dir_files_vessels= strcat('C:\Users\terre\Desktop\dilation output\vessel_data', num2str(dil_rad));
        mkdir('dir_files_lungs', 'dir_files_vessels');

        %Patient ID
        str_pat_lungs = strcat('Carcinomix', 'lungs', num2str(dil_rad));
        str_pat_vessels = strcat('Carcinomix', 'vessels', num2str(dil_rad));
        
        %Save DICOM images
        PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
        