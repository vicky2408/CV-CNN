%*****************************************************************
%Description: Taking Flevoland dataset as an example to test the CV-CNN performance
%input: testing outut of CV-CNN -- test_img_oo.mat
%output: classification result
%*****************************************************************
addpath('../CV-CNN');
load ground_truth;
load test_img_oo;
load label;
%% classification
% imshow the classification image
figure,imshow (ground_truth);title('Ground Truth')               % the ground truth of Flevoland
[class_img,ImageRGB] = test_imaging(test_img_oo);

%% calculate the accuracy
load label;                                 % the label of Flevoland
[accuracy, confusion_matrix] = calculate_acc(label,class_img);