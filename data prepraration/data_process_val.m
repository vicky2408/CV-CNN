function val_data_s  = data_process_val(test_data)
%*****************************************************************
%Description: data standardization for train data and test image
% 
%*****************************************************************
T =  test_data;                   
t11 = T(:,:,1,:);
t12 = T(:,:,2,:);
t13 = T(:,:,3,:);
t22 = T(:,:,4,:);
t23 = T(:,:,5,:);
t33 = T(:,:,6,:);
[m,n,p,q] = size(t11);

T11_ave = sum(sum(sum(sum(t11))))/(m*n*p*q);                             
T12_ave = sum(sum(sum(sum(t12))))/(m*n*p*q);
T13_ave = sum(sum(sum(sum(t13))))/(m*n*p*q);
T22_ave = sum(sum(sum(sum(t22))))/(m*n*p*q);
T23_ave = sum(sum(sum(sum(t23))))/(m*n*p*q);
T33_ave = sum(sum(sum(sum(t33))))/(m*n*p*q);

T11_std = sqrt((sum(sum(sum(sum((t11-T11_ave).^2)))))/(m*n*p*q));
T12_std = sqrt((sum(sum(sum(sum((t12-T12_ave).*conj(t12-T12_ave))))))/(m*n*p*q));          
T13_std = sqrt((sum(sum(sum(sum((t13-T13_ave).*conj(t13-T13_ave))))))/(m*n*p*q));
T22_std = sqrt((sum(sum(sum(sum((t22-T22_ave).^2)))))/(m*n*p*q));
T23_std = sqrt((sum(sum(sum(sum((t23-T23_ave).*conj(t23-T23_ave))))))/(m*n*p*q));
T33_std = sqrt((sum(sum(sum(sum((t33-T33_ave).^2)))))/(m*n*p*q));

TT11 = (t11-T11_ave)/T11_std;
TT12 = (t12-T12_ave)/T12_std;
TT13 = (t13-T13_ave)/T13_std;
TT22 = (t22-T22_ave)/T22_std;
TT23 = (t23-T23_ave)/T23_std;
TT33 = (t33-T33_ave)/T33_std;

val_data_s(:,:,1,:) = TT11;
val_data_s(:,:,2,:) = TT12;
val_data_s(:,:,3,:) = TT13;
val_data_s(:,:,4,:) = TT22;
val_data_s(:,:,5,:) = TT23;
val_data_s(:,:,6,:) = TT33;

end

