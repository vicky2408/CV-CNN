function label_s = label_process(label)
%*****************************************************************
%Description: label is the class of samples, range in [0-13]; transform it
%             into one-hot encoding; Change num 0-13 if the task has different classes 
%             
%*****************************************************************
[m,n] = size(label);
label_s = zeros(14,m);       % 14: number of class in this dataset
for i =1:m
    if      label(i,n) == 0
        label_s(:,i) = [1+1i 0 0 0 0 0 0 0 0 0 0 0 0 0];

    elseif label(i,n) == 1
        label_s(:,i) = [0 1+1i  0 0 0 0 0 0 0 0 0 0 0 0];

        elseif label(i,n) == 2
        label_s(:,i) = [0 0 1+1i 0 0 0 0 0 0 0 0 0 0 0];

         elseif label(i,n) == 3
        label_s(:,i) = [0 0 0 1+1i 0 0 0 0 0 0 0 0 0 0];

        elseif label(i,n) == 4
        label_s(:,i) = [0 0 0 0 1+1i 0 0 0 0 0 0 0 0 0];

        elseif label(i,n) == 5
        label_s(:,i) = [0 0 0 0 0 1+1i 0 0 0 0 0 0 0 0];

        elseif label(i,n) == 6
        label_s(:,i) = [0 0 0 0 0 0 1+1i 0 0 0 0 0 0 0];

        elseif label(i,n) == 7
        label_s(:,i) = [0 0 0 0 0 0 0 1+1i 0 0 0 0 0 0];

        elseif label(i,n) == 8
        label_s(:,i) = [0 0 0 0 0 0 0 0 1+1i 0 0 0 0 0];

        elseif label(i,n) == 9
        label_s(:,i) = [0 0 0 0 0 0 0 0 0 1+1i 0 0 0 0];
        
        elseif label(i,n) == 10
        label_s(:,i) = [0 0 0 0 0 0 0 0 0 0 1+1i 0 0 0];
        
        elseif label(i,n) == 11
        label_s(:,i) = [0 0 0 0 0 0 0 0 0 0 0 1+1i 0 0];
        
        elseif label(i,n) == 12
        label_s(:,i) = [0 0 0 0 0 0 0 0 0 0 0 0 1+1i 0];
        
        elseif label(i,n) == 13
        label_s(:,i) = [0 0 0 0 0 0 0 0 0 0 0 0 0 1+1i ];
     end
end        
