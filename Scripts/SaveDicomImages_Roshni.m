function SaveDicomImages_Roshni(source_name, lungs_dilated, vessels_dilated, lung_mask,reporting)
%% Save DICOM Images
global dil_rad;
global sigma_var;

if ~isempty(lungs_dilated)
    flag_lungs = true;
else
    flag_lungs = false;
end

if ~isempty(vessels_dilated)
    flag_vessels = true;
else
    flag_vessels = false;
end

if ~isempty(lung_mask)
    flag_mask = true;
else
    flag_mask = false;
end

        %change lung_mask into PTKImage or PTKDicomImage
        %lung_mask_ptk = PTKDicomImage.CreateDicomImageFromMetadata(lung_mask);
        %mask_dilated = vessels_dilated;
        %mask_dilated.ChangeRawImage(lung_mask);

        %make new file directory
        dir_patient = strcat('/Users/roshniravindran/Modeling/data_mostrecent/', source_name, '/');
        mkdir(dir_patient);
        
        if (flag_lungs)
            str_lungs = strcat('lungs', num2str(dil_rad));
            mkdir(dir_patient,str_lungs);
            path_lungs = strcat(dir_patient,str_lungs);
            str_pat_lungs = strcat(source_name, str_lungs);
            PTKSaveImageAsDicom(lungs_dilated,path_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        end
        
        if (flag_vessels)
            str_vessels = strcat('vessels', num2str(dil_rad),'/',num2str(sigma_var));
            mkdir(dir_patient,str_vessels);
            path_vessels = strcat(dir_patient,str_vessels);
            str_pat_vessels = strcat(source_name, str_vessels);
            PTKSaveImageAsDicom(vessels_dilated,path_vessels, 'PTKImage', str_pat_vessels, true, reporting)
        end
        
        if(flag_mask)
            mask_dilated = lung_mask;
            %mask_dilated.ChangeRawImage(lung_mask);
        
            str_mask = strcat('mask',num2str(dil_rad));
            mkdir(dir_patient,str_mask);
            path_mask = strcat(dir_patient,str_mask);
            PTKSaveImageAsDicom(mask_dilated,path_mask,'PTKImage',source_name,false,reporting)
            %fprintf('DICOM Mask \n');

        end
        
        %Patient ID
        %str_pat_lungs = strcat(source_name, str_lungs);
        %str_pat_vessels = strcat(source_name, str_vessels);
        
        %Save DICOM images
        %PTKSaveImageAsDicom(lungs_dilated,path_lungs, 'PTKImage', str_pat_lungs, true, reporting)
        %PTKSaveImageAsDicom(vessels_dilated,path_vessels, 'PTKImage', str_pat_vessels, true, reporting)
        %PTKSaveImageAsDicom(mask_dilated,path_mask,'PTKImage',source_name,false,reporting)
end