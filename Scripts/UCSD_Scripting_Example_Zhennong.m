clear; clc;
PTKAddPaths;
%%
ptk_main = PTKMain;
source_path = 'E:/Senior deisn/dataset/BPA201702_orig_image/orig_imgs'
%%
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
