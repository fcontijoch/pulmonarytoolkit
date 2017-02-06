clear; clc;
PTKAddPaths;

%% load dataset
source_path = '/Users/roshniravindran/Downloads/CARCINOMIX/CT THORACO-ABDO/ARTERIELLES - 5';

%%
%make dataset and default reporting object
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);

ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%%
% Segmentation
%threshold_image = dataset.GetResult('PTKUnclosedLungIncludingTrachea');
%[airway_tree, airway_image] = dataset.GetResult('PTKAirways');
%size_dilation_mm = 2.5;
%max_generation = 3;

lungs = dataset.GetResult('PTKLeftAndRightLungs');
vessels = dataset.GetResult('PTKVesselness');

%lobes = dataset.GetResult('PTKLobes');

%lung_notrachea = dataset.GetResult('PTKUnclosedLungExcludingTrachea');
%%
% Include Aortic branch + main vessels in lung image

orig_image = dataset.GetResult('PTKOriginalImage');
reduced_image = orig_image.Copy;
reduced_image = PTKGaussianFilter(reduced_image, 1.0, true);
scale_factor = reduced_image.Scale;

lung_image = orig_image.Copy;
raw_image = orig_image.RawImage;
    raw_image(3:end-2, 3:end-2, 3:end-2) = lung_image.RawImage(3:end-2, 3:end-2, 3:end-2);
    lung_image.ChangeRawImage(raw_image);
    
    limit_1 = lung_image.RescaledToGreyscale(-1500);
    limit_2 = lung_image.RescaledToGreyscale(-400);
    lung_image = (lung_image >= limit_1 & lung_image <= limit_2);
    
    threshold_image = lung_image.BlankCopy;
    threshold_image.ImageType = PTKImageType.Colormap;
    threshold_image.ChangeRawImage(lung_image);
    
    lung_image = PTKThresholdAirway(lung_image, true);

%%
%visualize 2D
PTKViewer(vessels);

%visualize 3D



