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

%% Original, Dilatio, and Erosion Images 
%original image
radii=[1 5];
for rad=1:2;
    figure(1);
    imagesc(lungs.RawImage(:,:,100));
    f1=figure(1);
    
    saveas(f1,['Original_rad' num2str(radii(rad)) '.png'])
%dilated image using sphere
    Lungs=lungs.RawImage; 
    fprintf('Lungs=lungs.RawImage \n')
    Lungs_Dilation= imdilate(Lungs, strel('sphere', radii(rad))); 
    fprintf('lungs dilated at radii %f \n', radii)
% figure for dilation
    figure(2)
    imagesc(Lungs_Dilation(:,:,100))
    f2=figure(2)
    saveas(f2,['Dilation_rad' num2str(radii(rad)) '.png'])
% eroded image 
    Lungs_Erosion=imerode(Lungs_Dilation, strel('sphere', radii(rad)));
    fprintf('lungs eroded at radii %f \n', radii)
%figure for erosion 
    figure(3)
    imagesc(Lungs_Erosion(:,:,100))
    f3=figure(3)
    saveas(f3,['Erosion_rad' num2str(radii(rad)) '.png'])
    fprintf('images of radii %f displayed \n', radii)
end;
%% Trying to dilate rightlungROI and leftlungROI in order to add additional parts of lungs into the image 

%%
%rollingball adds a nonflat ball-shaped structure element 
%can also use vertical line element strel('line', 11, 90)
%changing the data from char to logical to be used in dilation

%%
rollingball= offsetstrel('ball', 5,5); 
%imdilate must be used on a uint8 or logical, data must be flat and 2D 
dilatedRightLeftLungROI=imdilate(lungs, rollingball)
PTKviewer(dilatedRightLeftLungROI)
%can also use imagesc(dilatedRightLeftLungROI)
fprintf('added more region to view \n')


