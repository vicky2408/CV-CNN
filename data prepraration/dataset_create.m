%*****************************************************************
%  Description: data preparation for CV-CNN, taking Flevoland dataset as an example 
%  Input: T matrix; label
%  Output: train_data,train_label,val_data,val_label,test_data
%  Create: EMW
%  Date: July.22, 2017
%*****************************************************************

clear
load label.mat                   % the ground truth of Flevoland
load 'T_L2.mat'                  % the T matrix of Flevoland L band
nchan = 6;                       % T matrix channels
%% Auto data sampling
[data,nwin,nsam] = prepare_data_d6(T11L,T12L,T13L,T22L,T23L,T33L,nchan,label);

%% Split to train and validation dataset
[train_data_s,train_label_s,val_data_s,val_label_s] = prepare_data_train_val(data,nchan,nwin,nsam);

%% Data preprocessing
[train_data,test_data] = data_process_train(train_data_s,T11L,T12L,T13L,T22L,T23L,T33L,nwin); 
val_data  = data_process_val(val_data_s);
train_label = label_process(train_label_s);     
val_label = label_process(val_label_s);

save  'dataset_cv_cnn.mat' train_data train_label val_data val_label test_data -v7.3