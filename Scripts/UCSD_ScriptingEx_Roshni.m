function elapsedTime = UCSD_ScriptingEx_Roshni(source_name,sourcepath)
PTKAddPaths;

%% load dataset
%make dataset and default reporting object
file_infos = PTKDicomUtilities.GetListOfDicomFiles(sourcepath);
ptk_main = PTKMain;
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();

dataset.DeleteCacheForThisDataset;

%% Segmentation
elapsedTime = [];

% dilation/ erosion defined in PTKGetLeftAndRightLungs
global dil_rad
for i = [5, 10, 15, 20]
dil_rad = i;

tic
lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
vessels_dilated = dataset.GetResult('PTKVesselness');
elapsedTime = [elapsedTime toc];

%% Save DICOM Images

        %make new file directory
        dir_patient = strcat('/Users/roshniravindran/Modeling/pulmonarytoolkit_data/', source_name);
        mkdir(dir_patient);
        
        dir_files_lungs= strcat(dir_patient,'lungs', num2str(dil_rad));
        dir_files_vessels= strcat(dir_patient,'vessels', num2str(dil_rad));
        mkdir(dir_files_lungs);
        mkdir(dir_files_vessels);

        %Patient ID
        str_pat_lungs = strcat(source_name, 'lungs', num2str(dil_rad));
        str_pat_vessels = strcat(source_name, 'vessels', num2str(dil_rad));
        
        %Save DICOM images
        PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
end      
%% visualize 2D
%PTKViewer(vessels_dilated);

   

