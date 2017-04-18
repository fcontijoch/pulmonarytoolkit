%for the loop to run the dilation of the image 
%function elapsedTime =TMW_Scripting_Example(source_names,sourcepath)
%%
clear;clc;
PTKAddPaths;
fprintf('PTKAddPath \n');

%% Note, until we fix this issue, please update the file path correctly for for the source_path variable, and the PTK save function calls at the bottom! Thanks -Pranav
ptk_main = PTKMain;
%if you want to manually insert only one source_path, dont need if you are
%trying to run the loop 
source_path = 'C:\Users\Terrencewong\Desktop\CT THORACO-ABDO\ARTERIELLES - 5';
fprintf('source_paths \n')
%%
%IMPORTANT! READ THIS: Please remove cache when re-running results
%manual run 
file_infos = PTKDicomUtilities.GetListOfDicomFiles(source_path);
%loop run in conjunction with TMW_Main
%file_infos = PTKDicomUtilities.GetListOfDicomFiles(sourcepath);

% Tutorial 3 says PTKDiskUtilities which is incorrect
dataset = ptk_main.CreateDatasetFromInfo(file_infos);
reporting = CoreReporting();
%dataset = ptk_main.CreateDatasetFromInfo(file_infos);
dataset.DeleteCacheForThisDataset;

fprintf('cache removed \n')

%% Segmentations
% %getting data from the image set
% lungs = dataset.GetResult('PTKLeftAndRightLungs');
% %lobes = dataset.GetResult('PTKLobes');
% % %vessels = dataset.GetResult('PTKVesselness');
% % %vessels2 = dataset.GetResult('PTKVesselnessDilated');
% % fprintf('data gathered \n') 
% 
% %% Original, Dilation, and Erosion Images 
% %original image
% % radii=[5];
% % for rad=1;
% %     tic
% %     figure(1);
% %     imagesc(lungs.RawImage(:,:,100));
% %     f1=figure(1);  
% %     saveas(f1,['Original_rad' num2str(radii(rad)) '.png']);
% % %dilated image using sphere
% %     Lungs=lungs.RawImage; 
% %     Lungs_Dilation= imdilate(Lungs, strel('sphere', radii(rad))); 
% %     fprintf('lungs dilated at radii %.3f \n', radii(rad))
% % % figure for dilation
% %     figure(2);
% %     imagesc(Lungs_Dilation(:,:,100));
% %     f3=figure(2);
% %     saveas(f3,['Dilation_rad' num2str(radii(rad)) '.png']);
% % % eroded image 
% %     Lungs_Erosion=imerode(Lungs_Dilation, strel('sphere', radii(rad)));
% %     fprintf('lungs eroded at radii %.3f \n', radii(rad))
% % %figure for erosion 
% %     figure(3);
% %     imagesc(Lungs_Erosion(:,:,100));
% %     f3=figure(3);
% %     saveas(f3,['Erosion_rad' num2str(radii(rad)) '.png']);
% %     fprintf('It took %.3f to compute radius of %.3f \n', toc, radii(rad))    
% % end;
% %% Segmentation Roshni trial
% %time this step for different dilation radii
% % tic
% % % dilation/ erosion defined in PTKGetLeftAndRightLungs
% % global dil_rad
% % dil_rad = 5;
% % lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs');
% % vessels_dilated = dataset.GetResult('PTKVesselness');
% % figure(1);
% %     imagesc(squeeze(lungs_dilated.RawImage(:,:,100)));
% %     f1=figure(1);
% %     saveas(f1,['lungs_dil' num2str(dil_rad) '.png']);
% %     figure(2);
% %     imagesc(squeeze(vessels_dilated.RawImage(:,:,100)));
% %     f2=figure(2);
% %     saveas(f2,['vessels_dil' num2str(dil_rad) '.png']);
% % toc
% 
%% Trying to loop the dil_rad from Roshni
% elapsedTime=[];
% global dil_rad
% for i=[1,5,10, 15, 20]
% dil_rad =i 
% 
%     tic 
%     %dilation of lungs to include more vessels
%     lungs_dilated = dataset.GetResult('PTKLeftAndRightLungs'); 
%     fprintf('It took %.3f to dilate lungs at radius %.3f for patient: %s\n', toc, dil_rad, source_names)
%     
%     %erosion of lungs to original size
%     vessels_dilated = dataset.GetResult('PTKVesselness');
%     toc 
%     fprintf('It took %.3f to dilate vessels at radius %.3f \n', toc, dil_rad)
%     elapsedTime= [elapsedTime toc];
% 
% 
% 
%     %%
% %make new file directory
%         
%         dir_patient =strcat('C:\Users\Terrencewong\Desktop\SeniorDesign\', source_names, '\');
%         mkdir(dir_patient);
%         
%         dir_files_lungs= strcat(dir_patient, '1.5-2lungs', num2str(dil_rad));
%         dir_files_vessels= strcat(dir_patient, '1.5-2vessels', num2str(dil_rad));
%         mkdir(dir_files_lungs); 
%         mkdir(dir_files_vessels);
% 
%         %Patient ID
%         str_pat_lungs = strcat(source_names, 'lungs', num2str(dil_rad));
%         str_pat_vessels = strcat(source_names, 'vessels', num2str(dil_rad));
%         
%         %Save DICOM images
%         PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs, 'PTKImage', str_pat_lungs, true, reporting)
%         PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
% end



%% Save DICOM Images 


% v1=figure(4)
% imagesc(vessels.RawImage(:,:,100))
% v2=figure(5)
% imagesc(vessels2.RawImage(:,:,10))
% PTKViewer(vessels2)
% 
% %% Save DICOM Images
% 
%         %make new file directory
%         dir_files_lungs= strcat('C:\Users\terre\Desktop\dilation output\lungs_data', num2str(dil_rad));
% %         dir_files_vessels= strcat('C:\U0sers\terre\Desktop\dilation output\vessel_data', num2str(dil_rad));
%         mkdir('dir_files_lungs', 'dir_files_vessels');
% 
%         %Patient ID
%         str_pat_lungs = strcat('Carcinomix', 'lungs', num2str(dil_rad));
%         str_pat_vessels = strcat('Carcinomix', 'vessels', num2str(dil_rad));
%         
%         %Save DICOM images
%         PTKSaveImageAsDicom(lungs_dilated,dir_files_lungs, 'PTKImage', str_pat_lungs, true, reporting)
%         PTKSaveImageAsDicom(vessels_dilated,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
%         

%%changing the sigma manually 
 %vessels = dataset.GetResult('PTKVesselness');
 %make new file directory
       % dir_files_vessels= strcat('C:\Users\Terrencewong\Desktop\SeniorDesign\Sigma_Change\')
       % mkdir('dir_files_vessels1-1.2');

        %Patient ID
        
      %  str_pat_vessels = strcat('Carcinomix', 'vessels', '1-1.2');
        %Save DICOM images
       % PTKSaveImageAsDicom(vessels,dir_files_vessels, 'PTKImage', str_pat_vessels, true, reporting)
 
 
 
 %% skeletoning trial 
vessels=dataset.GetResult('PTKVesselness');
BWvessels=im2bw(vessels)

save vessels %makes it into a mat so that the external 3D skeletonization program can be ran 
%https://www.mathworks.com/matlabcentral/fileexchange/43400-skeleton3d
%need to change to binary image 
vesselsraw=vessels.RawImage;
vessels_bin=vessels_raw>0; 

skel=Skeleton3D(vessels_bin); 
%%
vessels_skel=vessels.Copy; 
vessels_skel.ChangeRawImage(skel); 
%% saving images 
%making directatory for the new skel images
dir_files_vessels_skel=strcat('C:\Users\Terrencewong\Desktop\Skel\', 'skel');
mkdir(dir_files_vessels_skel);
str_pat_vessels_skel =strcat('Carcinomix', 'skel');
PTKSaveImageAsDicom(vessels_skel, dir_files_vessels_skel, 'vessels_skel', str_pat_vessels_skel, false, reporting);
%%
%save original image for comparison to the skel 
dir_files_vessels_orig=strcat('C:\Users\Terrencewong\Desktop\Skel\', 'orig');
mkdir(dir_files_vessels_orig)
str_pat_vessels_orig=strcat('Carcinomix', 'vessels');
PTKSaveImageAsDicom(vessels, dir_files_vessels_orig, 'vessels_orig', str_pat_vessels_orig, false, reporting);
%%
vessels=dataset.GetResult('PTKVesselness'); 
vesselsraw=vessels.RawImage;
%% using the TestSkeleton3D 
skel = Skeleton3D(vesselsraw);

figure();
col=[.7 .7 .8];
hiso = patch(isosurface(vesselsraw,0),'FaceColor',col,'EdgeColor','none');
hiso2 = patch(isocaps(vesselsraw,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;
lighting phong;
isonormals(vesselsraw,hiso);
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
hold on;
w=size(skel,1);
l=size(skel,2);
h=size(skel,3);
[x,y,z]=ind2sub([w,l,h],find(skel(:)));
plot3(y,x,z,'square','Markersize',4,'MarkerFaceColor','r','Color','r');            
set(gcf,'Color','white');
view(140,80)