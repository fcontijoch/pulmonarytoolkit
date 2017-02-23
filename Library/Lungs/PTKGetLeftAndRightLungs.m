function results = PTKGetLeftAndRightLungs(unclosed_lungs, filtered_threshold_lung, lung_roi, reporting)
    % PTKGetLeftAndRightLungs. Extracts left and right lungs from a lung
    %     segmentation, with morphological smoothing and hole-flling
    %
    %
    %     Licence
    %     -------
    %     Part of the TD Pulmonary Toolkit. https://github.com/tomdoel/pulmonarytoolkit
    %     Author: Tom Doel, 2012.  www.tomdoel.com
    %     Distributed under the GNU GPL v3 licence. Please see website for details.

    %Roshni added global variable
    global dil_rad
    
    min_volume_warning_limit = 2000;
    l_to_r_ratio_limit = 1.5;
    reporting.UpdateProgressAndMessage(25, 'Separating lungs');
    results = PTKSeparateAndLabelLungs(unclosed_lungs, filtered_threshold_lung, lung_roi, reporting);
    
    reporting.UpdateProgressAndMessage(25, 'Closing right lung');
    right_lung = results.Copy;
    right_lung.ChangeRawImage(right_lung.RawImage == 1);
    right_lung.CropToFit;
    
    if PTKSoftwareInfo.FastMode
        close_size = 5;
    else
        close_size = 8;
    end
    
    % Perform morphological closing with a spherical structure element
    right_lung.MorphWithBorder(@imclose, close_size);
    
    % Fill any remaining holes inside the 3D image
    right_lung = PTKFillHolesInImage(right_lung);
    
    right_lung.ChangeRawImage(uint8(right_lung.RawImage));
    

    %right_lung2 = right_lung.RawImage;
    %right_lung2dilation = imdilate(right_lung2,strel('sphere',10));
    %right_lung2erode = imerode(right_lung2dilation,strel('sphere',10));
    %right_lung.ChangeRawImage(uint8(right_lung2erode));
    
   

    %dilation of right lung using the imdilate and erode. both should be the same 
     RightLungImage= right_lung.RawImage;
     RightLungImage_Dilate=imdilate(RightLungImage, strel('sphere', dil_rad));
     RightLungImage_Erode=imerode(RightLungImage_Dilate, strel('sphere', dil_rad));
     right_lung.ChangeRawImage(uint8(RightLungImage_Erode));


    % Get the right lung volume
    right_lung_volume_mm3 = right_lung.Volume;
    if right_lung_volume_mm3 < min_volume_warning_limit
        reporting.ShowWarning('PTKGetLeftAndRightLungs:RightLungVolumeSmall', ['The calculated right lung volume ' num2str(right_lung_volume_mm3) 'mm^3 is small. This may indicate pathology or a segmentation error. Please manually verify the lung segmentation.'], [])
    end
    
    reporting.UpdateProgressAndMessage(50, 'Closing left lung');
    left_lung = results.Copy;
    left_lung.ChangeRawImage(left_lung.RawImage == 2);
    left_lung.CropToFit;
    
    % Perform morphological closing with a spherical structure element
    left_lung.MorphWithBorder(@imclose, close_size);
    % Fill any remaining holes inside the 3D image
    left_lung = PTKFillHolesInImage(left_lung);
    
    left_lung.ChangeRawImage(2*uint8(left_lung.RawImage));
    

    %left_lung2 = left_lung.RawImage == 2;
    %left_lung2dilation = imdilate(left_lung2,strel('sphere',10));
     %%or strel('ball',2,2)?
    %left_lung2erode = imerode(left_lung2dilation,strel('sphere',10));
    %left_lung.ChangeRawImage(2*uint8(left_lung2erode));

    %dilation and erosion of left lung
     LeftLungImage = left_lung.RawImage == 2;
     LeftLungImage_Dilate = imdilate(LeftLungImage, strel('sphere',dil_rad));
     LeftLungImage_Erode= imerode(LeftLungImage_Dilate,strel('sphere', dil_rad));
     left_lung.ChangeRawImage(2*uint8(LeftLungImage_Erode));
    
    
    % Get the left lung volume
    left_lung_volume_mm3 = left_lung.Volume;
    if left_lung_volume_mm3 < min_volume_warning_limit
        reporting.ShowWarning('PTKGetLeftAndRightLungs:LeftLungVolumeSmall', ['The calculated left lung volume ' num2str(right_lung_volume_mm3) 'mm^3 is small. This may indicate pathology or a segmentation error. Please manually verify the lung segmentation.'], [])
    end
    
    if ((left_lung_volume_mm3 / right_lung_volume_mm3) > l_to_r_ratio_limit) || ((right_lung_volume_mm3 / left_lung_volume_mm3) > l_to_r_ratio_limit)
        reporting.ShowWarning('PTKGetLeftAndRightLungs:LeftRightLungVolumeDifference', ['The calculated left ' num2str(left_lung_volume_mm3) 'mm^3 and right ' num2str(right_lung_volume_mm3) 'mm^3 lung volumes are significantly different. This may indicate pathology or a segmentation error. Please manually verify the lung segmentation.'], [])
    end
    
    reporting.UpdateProgressAndMessage(75, 'Combining');
    
    results.Clear;
    results.ChangeSubImage(left_lung);
    results2 = results.Copy;
    results2.Clear;
    results2.ChangeSubImage(right_lung);
    results.ChangeRawImage(min(2, results.RawImage + results2.RawImage));
    results.ImageType = PTKImageType.Colormap;
end