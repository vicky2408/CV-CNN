%*****************************************************************
%  Description: Complex-Valued Convolutional Neural Network 
%               train & test process
%               The wights and inputs are all complex. The foraward operations are calculated in complex domain 
%               and the backward update are based on complex back-propagation formula.
%  Input: train_data,train_label,val_data,val_label,test_data
%         The dimension of data is m*m*channels*(sample numbers) while m is the size of samples. 
%         The label is encoded in one-hot form while the one is insteaded by 1+1*j.
%  Output: train & val accuracy; test output
%  Reference: https://github.com/rasmusbergpalm/DeepLearnToolbox 
%             This code is created based on the architecture of the reference.
%  Date: July.22, 2017
%*****************************************************************
clear all; close all; clc;  
addpath('./utils');   
load train_data.mat;load train_label.mat;    % Please input your testing data and label
load val_data.mat;load val_label.mat;
load test_data.mat;
%% CV-CNN architecture
cnn.layers = {  
    struct('type', 'i')                                     %input layer  
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 3)   %convolution layer  
    struct('type', 's', 'scale', 2)                         %sub sampling layer  
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 3)  %convolution layer  
%     struct('type', 's', 'scale', 2)                       %subsampling layer  
};  
 
% Initialize parameters
cnn = cv_cnn_setup(cnn,train_data, train_label);  
    
opts.alpha = 0.8 ;                  % learning rate
opts.batchsize = 100;               % batch size,  
opts.numepochs = 65;                % epochs

% train 
cnn = cv_cnn_train(cnn,train_data, train_label, opts);  
  
% validation    
[er, bad] = cv_cnn_val(cnn,val_data,val_label);

% test
net = cv_cnn_ff(cnn,test_data);
test_img_oo = net.o;

%plot mean squared error  
plot(cnn.rL);  

%show test error  
disp([num2str(er*100) '% error']); 

