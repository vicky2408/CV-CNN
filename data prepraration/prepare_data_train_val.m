function [train_data,train_label,val_data,val_label] = prepare_data_train_val(data,nchan,nwin,nsam)
%***********************************************
%Description:slpit the samples into train and validation dataset
%input:6 channels of T matrix, label
%output:train_data,train_label,val_data,val_label
% train_data  nwin*nwin*6*nsamtra
%***********************************************

[~, rind] = sort(rand(size(data(:,1))));
data = data(rind,:);    %perturbate the sequence

label = data(:,1);
data = data(:,2:end);
data = reshape(data,nsam,nchan,nwin,nwin);
data = permute(data,[3,4,2,1]);

%split two parts
tind = rand(nsam,1)<0.2;

tmp_data = data(:,:,:,~tind);
tmp_label = label(~tind);
num = floor(size(tmp_data,4)/100)*100;
train_data = tmp_data(:,:,:,1:num);
train_label = tmp_label(1:num,:);

val_data = data(:,:,:,tind);
val_label = label(tind);
end



