% Speaker recognition project by Kacper Porebski
% Project was implemented using demonstration code provided and by the
% following:
% Created by A. Alexander, EPFL
% Modified by J. Richiardi
% Modified by S. Yanushkevich

%Choosing the number of Gaussian invariants.
No_of_Gaussians=10;

disp('-------------------------------------------------------------------');
disp('                    Speaker recognition Project');
disp('-------------------------------------------------------------------');

%-----------reading in the training data----------------------------------
training_data1=audioread('Joel1.mp3');
training_data2=audioread('Julia2.mp3');
training_data3=audioread('Alyssa3.mp3');
training_data4=audioread('Angelo4.mp3');
training_data5=audioread('Natan5.mp3');

%------------reading in the test data-----------------------------------
testing_data1=audioread('Joel1Test.mp3');
testing_data2=audioread('Julia2Test.mp3');
testing_data3=audioread('Alyssa3Test.mp3');
testing_data4=audioread('Angelo4Test.mp3');
testing_data5=audioread('Natan5Test.mp3');

disp('Completed reading taining and testing data (Press any key to continue)');
pause;

Fs=8000;   %uncoment if you cannot obtain the feature number from audioread above

%-------------feature extraction------------------------------------------
training_features1=melcepst(training_data1,Fs);
training_features2=melcepst(training_data2,Fs);
training_features3=melcepst(training_data3,Fs);
training_features4=melcepst(training_data4,Fs);
training_features5=melcepst(training_data5,Fs);

testing_features1=melcepst(testing_data1,Fs);
testing_features2=melcepst(testing_data2,Fs);
testing_features3=melcepst(testing_data3,Fs);
testing_features4=melcepst(testing_data4,Fs);
testing_features5=melcepst(testing_data5,Fs);

disp('Completed feature extraction for training and testing data (Press any key to continue)');
pause;

%-------------training the input data using GMM-------------------------
%training input data, and creating the models required
disp('Training models with the input data');

[mu_train1,sigma_train1,c_train1]=gmm_estimate(training_features1',No_of_Gaussians);
[mu_train2,sigma_train2,c_train2]=gmm_estimate(training_features2',No_of_Gaussians);
[mu_train3,sigma_train3,c_train3]=gmm_estimate(training_features3',No_of_Gaussians);
[mu_train4,sigma_train4,c_train4]=gmm_estimate(training_features4',No_of_Gaussians);
[mu_train5,sigma_train5,c_train5]=gmm_estimate(training_features5',No_of_Gaussians);

disp('Completed Training ALL Models  (Press any key to continue)');
pause;
%-------------------------testing against the input data-------------- 

%testing against the first model
[lYM,lY]=lmultigauss(testing_features1', mu_train1,sigma_train1,c_train1);
A(1,1)=mean(lY);
[lYM,lY]=lmultigauss(testing_features2', mu_train1,sigma_train1,c_train1);
A(1,2)=mean(lY);
[lYM,lY]=lmultigauss(testing_features3', mu_train1,sigma_train1,c_train1);
A(1,3)=mean(lY);
[lYM,lY]=lmultigauss(testing_features4', mu_train1,sigma_train1,c_train1);
A(1,4)=mean(lY);
[lYM,lY]=lmultigauss(testing_features5', mu_train1,sigma_train1,c_train1);
A(1,5)=mean(lY);


%testing against the second model
[lYM,lY]=lmultigauss(testing_features1', mu_train2,sigma_train2,c_train2);
A(2,1)=mean(lY);
[lYM,lY]=lmultigauss(testing_features2', mu_train2,sigma_train2,c_train2);
A(2,2)=mean(lY);
[lYM,lY]=lmultigauss(testing_features3', mu_train2,sigma_train2,c_train2);
A(2,3)=mean(lY); 
[lYM,lY]=lmultigauss(testing_features4', mu_train2,sigma_train2,c_train2);
A(2,4)=mean(lY);
[lYM,lY]=lmultigauss(testing_features5', mu_train2,sigma_train2,c_train2);
A(2,5)=mean(lY);


%testing against the third model
[lYM,lY]=lmultigauss(testing_features1', mu_train3,sigma_train3,c_train3);
A(3,1)=mean(lY);
[lYM,lY]=lmultigauss(testing_features2', mu_train3,sigma_train3,c_train3);
A(3,2)=mean(lY);
[lYM,lY]=lmultigauss(testing_features3', mu_train3,sigma_train3,c_train3);
A(3,3)=mean(lY);
[lYM,lY]=lmultigauss(testing_features4', mu_train3,sigma_train3,c_train3);
A(3,4)=mean(lY);
[lYM,lY]=lmultigauss(testing_features5', mu_train3,sigma_train3,c_train3);
A(3,5)=mean(lY);

%testing against the fourth model
[lYM,lY]=lmultigauss(testing_features1', mu_train4,sigma_train4,c_train4);
A(4,1)=mean(lY);
[lYM,lY]=lmultigauss(testing_features2', mu_train4,sigma_train4,c_train4);
A(4,2)=mean(lY);
[lYM,lY]=lmultigauss(testing_features3', mu_train4,sigma_train4,c_train4);
A(4,3)=mean(lY);
[lYM,lY]=lmultigauss(testing_features4', mu_train4,sigma_train4,c_train4);
A(4,4)=mean(lY);
[lYM,lY]=lmultigauss(testing_features5', mu_train4,sigma_train4,c_train4);
A(4,5)=mean(lY);

%testing against the fifth model
[lYM,lY]=lmultigauss(testing_features1', mu_train5,sigma_train5,c_train5);
A(5,1)=mean(lY);
[lYM,lY]=lmultigauss(testing_features2', mu_train5,sigma_train5,c_train5);
A(5,2)=mean(lY);
[lYM,lY]=lmultigauss(testing_features3', mu_train5,sigma_train5,c_train5);
A(5,3)=mean(lY);
[lYM,lY]=lmultigauss(testing_features4', mu_train5,sigma_train5,c_train5);
A(5,4)=mean(lY);
[lYM,lY]=lmultigauss(testing_features5', mu_train5,sigma_train5,c_train5);
A(5,5)=mean(lY);


disp('Results in the form of confusion matrix for comparison');
disp('Each column i represents the test recording of Speaker i');
disp('Each row i represents the training recording of Speaker i');
disp('The diagonal elements corresponding to the same speaker');
disp('-------------------------------------------------------------------');
A
disp('-------------------------------------------------------------------');
% confusion matrix in color
figure; imagesc(A); colorbar;

%Finding appropriate thresholds
Matching_Scores = [A(1,1), A(2,2), A(3,3), A(4,4), A(5,5)];
Matching_Scores_Mean = mean(Matching_Scores);
Matching_Scores_Std = std(Matching_Scores);
Threshold1 =  Matching_Scores_Mean - Matching_Scores_Std;

NM_Scores = [A(1,2), A(1,3), A(1,4), A(1,5), A(2,1), A(2,3), A(2,4), A(2,5)...
    ,A(3,1), A(3,2), A(3,4), A(3,5), A(4,1), A(4,2), A(4,3), A(4,5), A(5,1)...
    ,A(5,2), A(5,3), A(5,4)];
NM_Scores_Mean = mean(NM_Scores);
NM_Scores_Std = std(NM_Scores);
Threshold2 = NM_Scores_Mean - NM_Scores_Std;

Threshold3 = (Threshold1 + Threshold2)/2;

disp('Thresholds generated:');
Threshold1
Threshold2
Threshold3

disp('Validating Probe');
Validation_Probe1 = audioread('KacperProbe.mp3');
Probe_Features1 = melcepst(Validation_Probe1,Fs);
[LYM,LY]=lmultigauss(Probe_Features1', mu_train1,sigma_train1,c_train1);
B(1,1)=mean(LY);
[LYM,LY]=lmultigauss(Probe_Features1', mu_train2,sigma_train2,c_train2);
B(1,2)=mean(LY);
[LYM,LY]=lmultigauss(Probe_Features1', mu_train3,sigma_train3,c_train3);
B(1,3)=mean(LY);
[LYM,LY]=lmultigauss(Probe_Features1', mu_train4,sigma_train4,c_train4);
B(1,4)=mean(LY);
[LYM,LY]=lmultigauss(Probe_Features1', mu_train5,sigma_train5,c_train5);
B(1,5)=mean(LY);

disp('Validation done, following scores received');
B




