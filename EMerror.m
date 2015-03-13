function  error = EMerror(X,Xnew)
%calculate the reconstruction error
%inputs : X NxD matrix with real RGB values of image
%       : Xnew NxD matrix with hard assigned values for each cluster
%output : a vector with the error for each cluster assignment

sum = 0;
for i=1:size(X,1)
    for j=1:size(X,2)
        sum = sum+ (X(i,j)-Xnew(i,j)).^2;
    end
end

error = (1/size(X,1))*sum;

