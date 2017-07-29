function [data,nwin,nsam] = prepare_data_d6(T11L,T12L,T13L,T22L,T23L,T33L,nchan,label)
%******************************************************
%Description: Auto sampling
%input: 6 channels of T matrix, label
%output: sampling data,window size,channel of T matrix,number of samples
%******************************************************

A2 = label;
B0(:,:,1) = T11L;
B0(:,:,2) = T12L;
B0(:,:,3) = T13L;
B0(:,:,4) = T22L;
B0(:,:,5) = T23L;
B0(:,:,6) = T33L;

B = B0;
%nchan = 6;  % data channels

[m,n] = size(A2);
B = reshape(B,m*n,nchan); 
A2 = reshape(A2,m*n,1); 
vflag = and(sum(B,2) > 0, A2 > 0); 

%exclude edge points, this window could be different than the input window
nhwin = 0;  nwin = nhwin*2+1; 
cflag = uint8(ones(m,n));   %center flags
A2b = reshape(A2,m,n);
for i=1:nwin
    for j=1:nwin
        temp = circshift(A2b,[i-nhwin,j-nhwin,0]);   
        cflag(:) = and(cflag(:), (temp(:) == A2b(:)));
    end
    disp(i);
end

vind = find(and(vflag, cflag(:)));

%drop some portion, 0.15 is related to the sampling rate
types = unique(A2(vind));
n0 = length(vind)*0.12/length(types);   
vind2 = [];
for i=1:length(types)
    temp = vind(A2(vind)==types(i));
    temp = temp(rand(size(temp))<n0/length(temp));
    vind2 = [vind2;temp];
    length(temp);
end
% vind2 = vind(rand(size(vind))<0.0005);

data = zeros(length(vind2), 1+nwin*nwin*nchan);
data(:,1) = double(A2(vind2,:));

%include 12x12 neighborhood, nwin references to the window size
nhwin = 6;  nwin = 12;
B = reshape(B,m,n,nchan);
ii = 1;
for i=1:nwin
    for j=1:nwin
        temp = circshift(B,[i-nhwin,j-nhwin,0]);
        temp = reshape(temp,m*n,nchan);
        data(:,ii+(1:nchan)) = temp(vind2,:);
        ii = ii+nchan;
    end
end

%visiualize all the sample windows
clrs='rgbcymrgbcymrgbcym';
marks='o+';
r = T22L;g = T33L;b = T11L;
figure;
imrgb(r,g,b);
hold on;
nclass = max(A2(vind2,:));
for i=1:nclass
    [yy,xx] = ind2sub([m,n],vind2(A2(vind2,:)==i));
    plot(xx,yy,[clrs(i),marks(1+(i>6))]);
end

nsam = length(vind2);
%shift the label to zeros-based
data(:,1)=data(:,1)-1;

end



