function SaveDicomImages_Roshni(source_name, lungs_dilated, vessels_dilated, reporting)
%% Save DICOM Images
global dil_rad

        %make new file directory
        dir_patient = strcat('/Users/roshniravindran/Modeling/data_recent/', source_name);
        mkdir(dir_patient);
        
        str_lungs = strcat('lungs', num2str(dil_rad));
        mkdir(dir_patient,str_lungs);
        path_lungs = strcat(dir_patient,'/',str_lungs);
        
        str_vessels = strcat('vessels', num2str(dil_rad));
        mkdir(dir_patient,str_vessels);
        path_vessels = strcat(dir_patient,'/',str_vessels);

        %Patient ID
        str_pat_lungs = strcat(source_name, str_lungs);
        str_pat_vessels = strcat(source_name, str_vessels);
        
        %Save DICOM images
        PTKSaveImageAsDicom(lungs_dilated,path_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        PTKSaveImageAsDicom(vessels_dilated,path_vessels, 'PTKImage', str_pat_vessels, true, reporting)
end