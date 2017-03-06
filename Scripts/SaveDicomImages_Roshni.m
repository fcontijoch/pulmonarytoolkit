function SaveDicomImages_Roshni(source_name, lungs_dilated, vessels_dilated, lung_mask,reporting)
%% Save DICOM Images
global dil_rad
        %change lung_mask into PTKImage or PTKDicomImage
        %lung_mask_ptk = PTKDicomImage.CreateDicomImageFromMetadata(lung_mask);
        lung_mask_ptk = vessels_dilated;
        lung_mask_ptk.ChangeRawImage(lung_mask);
        
        %make new file directory
        dir_patient = strcat('/Users/roshniravindran/Modeling/data_mostrecent/', source_name, '/');
        mkdir(dir_patient);
        
        str_lungs = strcat('lungs', num2str(dil_rad));
        mkdir(dir_patient,str_lungs);
        path_lungs = strcat(dir_patient,str_lungs);
        
        str_vessels = strcat('vessels', num2str(dil_rad));
        mkdir(dir_patient,str_vessels);
        path_vessels = strcat(dir_patient,str_vessels);

        str_mask = strcat('mask',num2str(dil_rad));
        mkdir(dir_patient,str_mask);
        path_mask = strcat(dir_patient,str_mask);
        
        %Patient ID
        str_pat_lungs = strcat(source_name, str_lungs);
        str_pat_vessels = strcat(source_name, str_vessels);
        
        %Save DICOM images
        PTKSaveImageAsDicom(lungs_dilated,path_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        PTKSaveImageAsDicom(vessels_dilated,path_vessels, 'PTKImage', str_pat_vessels, true, reporting)
        PTKSaveImageAsDicom(lung_mask_ptk,path_mask,'PTKImage',source_name,false,reporting)
end