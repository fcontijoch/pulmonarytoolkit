clear; clc;
PTKAddPaths;
fprintf('PTKAddPath \n');

%% Note, until we fix this issue, please update the file path correctly for for the source_path variable, and the PTK save function calls at the bottom! Thanks -Pranav
ptk_main = PTKMain;
source_path = 'C:\Users\terrence1995\Desktop\CT scans\CARCINOMIX\CT THORACO-ABDO\ARTERIELLES - 5';
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
radii=[1 5 10 15 20 30 50];
for rad=1:7;
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
