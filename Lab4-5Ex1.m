% based on code from S. Yanushekvich, February 04,2009
clear all
close all


disp('-------------------------------------------------------------------');
disp(' Lab 5, ENCM509');
disp('Fingerprint matching using Euclidean distance and Gabor filter');
disp('-------------------------------------------------------------------');


    %----------------------------------------------------------------------
    %-------- Select fingerprint 1
    %----------------------------------------------------------------------
       disp('Select Fingerprint 1'); 
 
          
       [namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'});
            if namefile~=0
                 [img,map]=imread(strcat(pathname,namefile));
                % if isrgb(img)
                     img=rgb2gray(img);
               %  end
             end
   
%   disp('(Press any key to continue)');
%   pause;
           
         disp('Processing ...');
         Fp1.imOrig = img;
         disp('Segmentation');
         Fp1 = segmentimage(Fp1);
         disp('Orientation array');
         Fp1 = computeorientationarray(Fp1);
         disp('Finding the singularity point');
         Fp1 = findsingularitypoint(Fp1);
         disp('Local frequencies');
         Fp1 = computelocalfrequency(Fp1, Fp1.imOrig);
         disp('Filtering');
         Fp1 = enhance2ridgevalley(Fp1);
         disp('Skeleton cleaning');
         Fp1 = cleanskeleton(Fp1);
         disp('Finding minutiae');
         Fp1 = findminutia(Fp1);
         
         [x1,y1]= find(Fp1.minutiaArray==1);
         [x2,y2]= find(Fp1.minutiaArray==2);

      disp('See the original and the processed fingerprint 1');  
   %   pause;
      figure(1)
         subplot(1,2,1), imagesc(Fp1.imOrig),colormap gray, title('Fingerprint 1') 
         subplot(1,2,2),
         hold on, imagesc(Fp1.imOrig),colormap gray, title('Minutiae')
         plot(y1,x1,'or','markersize',8)
         plot(y2,x2,'sb','markersize',8), axis ij
         legend('End of Ridge', 'Bifurcation')
         hold off
   
    %----------------------------------------------------------------------
    %-------- Database Load
    %----------------------------------------------------------------------
  disp('Reading in Database'); 
  
  
for n=1:9
  img = imread(sprintf('l%1d.bmp',n));
   img=rgb2gray(img);
   Fp2.imOrig = img;
   Fp2 = segmentimage(Fp2);
   Fp2 = computeorientationarray(Fp2);
   Fp2 = findsingularitypoint(Fp2);
   Fp2 = computelocalfrequency(Fp2, Fp2.imOrig);
   Fp2 = enhance2ridgevalley(Fp2);
   Fp2 = cleanskeleton(Fp2);
   Fp2 = findminutia(Fp2);  
    %----------------------------------------------------------------------
    %---- Fingerprint comparison using two methods: Gabor and local matching
    %
    %----------------------------------------------------------------------      
        Score1=MatchGaborFeat(Fp1,Fp2);
        ScoreGab(n) = Score1;
        %user_entry2=input('Enter the threshold (for example, 5, 6,..., 12): ');   
       threshold2=10;  
       Fp2=align2(Fp1,Fp2);
       Score2=match(Fp1.minutiaArray,Fp2.minutiaArrayAlign, Fp1.imSkeleton, Fp2.imSkeletonAlign,threshold2);
       ScoreMin(n)= Score2;

end

disp(ScoreGab);
disp(ScoreMin);
