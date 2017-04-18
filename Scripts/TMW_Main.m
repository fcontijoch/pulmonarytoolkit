clc; clear;

%% Load Patient Datasets
source_names = {'carcinomix', 'BPA_0003', 'BPA201701', 'CTEPH'};
path_names = {'C:\Users\Terrencewong\Desktop\CT THORACO-ABDO\ARTERIELLES - 5','C:\Users\Terrencewong\Desktop\patient data\BPA_0003','C:\Users\Terrencewong\Desktop\patient data\BPA201701_orig_imgs', 'C:\Users\Terrencewong\Desktop\patient data\CTEPHorig_imgs'}
timeArray = {};
% Get specific patient dataset
for i=1:numel(source_names)
    
    elapsedTime = TMW_Scripting_Example(source_names{i},path_names{i});
    timeArray{end+1} = elapsedTime;
   
end 
