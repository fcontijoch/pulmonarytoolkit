clear; clc;
PTKAddPaths;

%% load dataset
source_path = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';
source_pathT='C:\Users\terrence1995\Desktop\CT scans\CARCINOMIX\CT THORACO-ABDO\ARTERIELLES - 5';
%%
%make dataset and default reporting object
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
file_infosT = PTKDicomUtilities.GetListOfDicomFiles(source_pathT);
ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
dataset = ptk_main.CreateDatasetFromInfo(file_infosT)
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%%
% Segmentation
%threshold_image = dataset.GetResult('PTKUnclosedLungIncludingTrachea');
%[airway_tree, airway_image] = dataset.GetResult('PTKAirways');
%size_dilation_mm = 2.5;
%max_generation = 3;
global dil_rad;
dil_rad = 5;
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
%%
vessels_dilated = dataset.GetResult('PTKVesselness');

%lobes = dataset.GetResult('PTKLobes');

%lung_notrachea = dataset.GetResult('PTKUnclosedLungExcludingTrachea');
% %% Original, Dilation, and Erosion Images 
% %original image
% radii=[1 5 10 15 20 30 50];
% % for rad=1:7;
%     tic
%     figure(1);
%     imagesc(lungs.RawImage(:,:,100));
%     f1=figure(1);  
%     saveas(f1,['Original_rad' num2str(radii(rad)) '.png']);
% %dilated image using sphere
%     Lungs=lungs.RawImage; 
%     Lungs_Dilation= imdilate(Lungs, strel('sphere', radii(rad))); 
%     fprintf('lungs dilated at radii %.3f \n', radii(rad))
% % figure for dilation
%     figure(2);
%     imagesc(Lungs_Dilation(:,:,100));
%     f2=figure(2);
%     saveas(f2,['Dilation_rad' num2str(radii(rad)) '.png']);
% % eroded image 
%     Lungs_Erosion=imerode(Lungs_Dilation, strel('sphere', radii(rad)));
%     fprintf('lungs eroded at radii %.3f \n', radii(rad))
% %figure for erosion 
%     figure(3);
%     imagesc(Lungs_Erosion(:,:,100));
%     f3=figure(3);
%     saveas(f3,['Erosion_rad' num2str(radii(rad)) '.png']);
%     fprintf('It took %.3f to compute radius of %.3f \n', toc, radii(rad))    
% end;
% %%
% % Include Aortic branch + main vessels in lung image
% 
% orig_image = dataset.GetResult('PTKOriginalImage');
% reduced_image = orig_image.Copy;
% reduced_image = PTKGaussianFilter(reduced_image, 1.0, true);
% scale_factor = reduced_image.Scale;
% 
% lung_image = orig_image.Copy;
% raw_image = orig_image.RawImage;
%     raw_image(3:end-2, 3:end-2, 3:end-2) = lung_image.RawImage(3:end-2, 3:end-2, 3:end-2);
%     lung_image.ChangeRawImage(raw_image);
%     
%     limit_1 = lung_image.RescaledToGreyscale(-1500);
%     limit_2 = lung_image.RescaledToGreyscale(-400);
%     lung_image = (lung_image >= limit_1 & lung_image <= limit_2);
%     
%     threshold_image = lung_image.BlankCopy;
%     threshold_image.ImageType = PTKImageType.Colormap;
%     threshold_image.ChangeRawImage(lung_image);
%     
%     lung_image = PTKThresholdAirway(lung_image, true);

%%
%visualize 2D
PTKViewer(lungs);

%visualize 3D

%%
%Save DICOM Images
dir_files='/Users/roshniravindran/Modeling/pulmonarytoolkit_data/lungs';
mkdir(dir_files);

%PTKSaveAs(vessels,'Patient Name',dir_files, 0, reporting)

PTKSaveImageAsDicom(vessels_dilated,'/Users/roshniravindran/Modeling/pulmonarytoolkit_data', 'vessels', 'BPA201701_', true, reporting)
PTKSaveImageAsDicom(lungs_dilated,'/Users/roshniravindran/Modeling/pulmonarytoolkit_data/lungs', 'lungs', 'BPA201701', true, reporting)


