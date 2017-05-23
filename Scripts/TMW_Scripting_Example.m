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
 files =dir('0.5')
 for i =1:numel(files) 
 end
 
%%
%https://www.mathworks.com/matlabcentral/fileexchange/43400-skeleton3d
%need to change to binary image 
%% gather data 
global dil_rad
dil_rad = 15;
vessels=dataset.GetResult('PTKVesselness');
vessels_raw=vessels.RawImage;

%% saving data so you dont have to run the entire PTKVesselness again
vessels_bin=vessels_raw>0; 
%increase intensity to see in osirix 
 

skel=Skeleton3D(vessels_bin); 
save 'vessels_info'
%% trying to make hhistogram of connectivity 
info=bwconncomp(skel)
%regionprops returns measurements based on the area of the pixels found in
%the bwconncomp which finds out information about the image such as
%connectivity and area 

numPixels = cellfun(@numel,info.PixelIdxList);
h = histogram(numPixels,100);
h.BinEdges = 0:40;
[counts, binEdges] = histcounts(numPixels,0:40);

noise = find(counts>200); pixels_index = [];
for n=1:numel(noise)
    lowerBound = binEdges(noise);
    upperBound = binEdges(noise+1);
    
    for m=1:numel(numPixels)
        if (numPixels(m)>=lowerBound &&numPixels(m)<=upperBound)
            pixels_index = [pixels_index m];
        end
    end
end

skel2 = skel;
noiseArray = info.PixelIdxList(pixels_index);

for l=1:numel(noiseArray)
    temp = noiseArray{l}
    for j=1:numel(temp)
      skel2(temp)= 0;
    end
end


%check
info2 =bwconncomp(skel2);
%numPixels2 = cellfun(@numel,info2.PixelIdxList);

% S=regionprops(info, 'Area')
% 
% figure(10)
% hist(info.ImageSize)
% noiseOG=skel
% noise1=bwareaopen(skel, 240)
% figure(1) 
% pic1=imagesc(noiseOG(:,:,100))
% figure(2)
% pic2=imagesc(noise1(:,:,100))



%imhist(vessels_bin)

%% reducing noise using area opening 
%%bwareaopen(image, P,conn)
%image= binary image, P= objects with less than P pixels are removed,
%conn = default connectivity 8 for 2D and 26 for 3D. 
x=[];
for i =1:21
    x=linspace(0,200,21);
    noise=bwareaopen(skel, x(i)); 
    figure(1) 
    f1=imagesc(noise(:,:,100));
    saveas(f1,['noise' num2str(x(i)) '.png']);
    
end 

%% trial with visualization using 100 pixel removal 
skel3=bwareaopen(skel,100); 
imagesc(skel3(:,:,100))
PTKImage3=vessels.Copy; 
PTKImage3.ChangeRawImage(skel3); 
PTKViewer(PTKImage3) 
OGImage=vessels.Copy; 
OGImage.ChangeRawImage(skel); 
PTKViewer(OGImage)


%% o2verlays skeletonization overe the original image
figure();
col=[.7 .7 .8];
hiso = patch(isosurface(vessels_bin,0),'FaceColor',col,'EdgeColor','none');
hiso2 = patch(isocaps(vessels_bin,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;
lighting phong;
isonormals(vessels_bin,hiso);
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
view(100,80)
%% trying to remove extras 
Image3=skel*1000; 
Image4=bwconncmp(Image3); 

%increases the threshold of the image to be easily seen in osirix  
PTKImage3=vessels.Copy; 
PTKImage3.ChangeRawImage(Image3); 

vessels_skel=vessels.Copy; 
vessels_skel.ChangeRawImage(skel); 
%% saving skeletonization images 
%making directatory for the new skel images
dir_files_vessels_skel=strcat('C:\Users\Terrencewong\Desktop\Skel\', 'skel');
mkdir(dir_files_vessels_skel);
str_pat_vessels_skel =strcat('Carcinomix', 'skel');
PTKSaveImageAsDicom(vessels_skel, dir_files_vessels_skel, 'vessels_skel', str_pat_vessels_skel, false, reporting);
%save Image3 which is 1000*skel (trying to make it easier to see on osirix)
dir_files_vessels_Image3=strcat('C:\Users\Terrencewong\Desktop\Skel\', 'Image3');
mkdir(dir_files_vessels_Image3);
str_pat_vessels_Image3 =strcat('Carcinomix', 'Image3');
PTKSaveImageAsDicom(PTKImage3, dir_files_vessels_Image3, 'Image', str_pat_vessels_Image3, false, reporting);

%%
%save original image for comparison to the skel 
dir_files_vessels_orig=strcat('C:\Users\Terrencewong\Desktop\Skel\', 'orig');
mkdir(dir_files_vessels_orig)
str_pat_vessels_orig=strcat('Carcinomix', 'vessels');
PTKSaveImageAsDicom(vessels, dir_files_vessels_orig, 'vessels_orig', str_pat_vessels_orig, false, reporting);


%% zhennong's matlab code for bifurcations 
%find all centreline points & classification of starting pixels, normal
%pixels and bifuration 
%skel is the skeletonization output 
[x,y,z]=ind2sub(size(skel), find(skel==1)); 
clear neigh_count starting_pixel bifur_pixel 
normal_pixel=[];bifur_pixel=[];starting_pixel=[]; 
for l=1:size(x,1)
    neigh_count=0;neigh_posit=[]; 
    for i=-1:1
        for j=-1:1
            for k=-1:1
                if z(l)==1 && k==-1 
                    neigh_val=0 
                elseif z(l)==size(z,1) && k==1; 
                    neigh_val=0; 
                
                else 
                    neigh=[x(l)+i,y(l)+j,z(l)+k];
                    neigh_val=skel(neigh(1),neigh(2), neigh(3)); 
                end; 
                if neigh_val==1
                    neigh_count=neigh_count+1; 
                    %neigh_posit=[neigh_posit;neigh]; 
                end 
            end
        end
    end
    if neigh_count==3
        normal_pixel=[normal_pixel;x(l),y(l),z(l)]; 
    elseif neigh_count==4
        bifur_pixel=[bifur_pixel; x(l), y(l), z(l)]
    else 
        starting_pixel=[starting_pixel; x(l), y(l), z(l)];
    end
end;
%% graph for bifurcations

% figure; hold all; 
% plot3(normal_pixel(:,1), normal_pixel(:,2), normal_pixel(:,3), '.b', 'MarkerSize' 24); 
% plot3(bifur_pixel(:,1), bifur_pixel(:,2), bifur_pixel(:,3), '.r', 'MarkerSize', 24); 
% plot3(starting_pixel(:,1), starting_pixel(:,2), starting_pixel(:,3), '.m' 'MarkerSize', 24); 
% 
