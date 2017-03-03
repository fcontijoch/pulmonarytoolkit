function lung_mask = GetLungMask_Roshni(lungs_dilated,dataset)
% make sure the global variable crop_flag is set to false.. undos the crop in the function
% PTKGetLungROIForCT

img_dil = lungs_dilated.RawImage;
bin_mask = uint16(img_dil>0);

data_orig = dataset.GetResult('PTKOriginalImage');
img_orig = data_orig.RawImage;

lung_mask = bin_mask.*img_orig;
end