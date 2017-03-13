function lung_mask = GetLungMask_Roshni(lungs_dilated,dataset)
% make sure the global variable crop_flag is set to false.. undos the crop in the function
% PTKGetLungROIForCT
mask_dilated = lungs_dilated.Copy;

%img_dil = lungs_dilated.RawImage;
data_orig = dataset.GetResult('PTKLungROI', PTKContext.LungROI);
%data_orig = dataset.GetResult('PTKOriginalImage');
img_orig = data_orig.RawImage;

switch class(img_orig)
    case 'uint16'
        bin_mask = uint16(img_dil>0);
    case 'int16'
        bin_mask = int16(img_dil>0);
    otherwise 
        bin_mask = double(img_dil>0);
end

lung_mask = bin_mask.*img_orig;
%mask_dilated.ChangeRawImage(lung_mask);

end