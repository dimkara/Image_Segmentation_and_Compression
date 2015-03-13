function error =  reconstructImage(X,z,mu,I,D,i)


%Image reconstruction
%Inputs : z NxK matrix is the a priori probability of data point N to be in cluster K
%         mu KxD is the mean of cluster K in dimension D for hard assignment
%         I is Height x Width Matrix of the image in RGB format 
%         only it's dimensions are needed for reconstruction
%         D is for reshaping the matrix in RGB format
%         i is for saving the file if it's called
   
if(nargin<6)
    i=0;
end

[~,index]=max(z,[],2);
Xnew=mu(index,:);
dim1 = size(I,1);
dim2 = size(I,2);
a=reshape(Xnew,dim1,dim2,D);
a = uint8(a); %return it in unit8 format for visualization
image(a); %shows in current figure for current K . 
if(i~=0) 
    fprintf(['saving image as k_' num2str(2^(i-1)) 'im.jpg \n'] ); 

    imwrite(a,['k_' num2str(2^(i-1)) 'im.jpg'],'jpg'); 
end

error = EMerror(X,Xnew); %calculate the error

%console display
fprintf(['reconstruction error for ' num2str(size(mu,1)) ' clusters is ' num2str(error) ' \n \n']);
