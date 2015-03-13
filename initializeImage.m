function [I,X] = initializeImage(D)

    %initialize of image
    %inputs : D dimension of matrix  for reshape
    %outputs : I original height x width x pixel RGB value matrix
    %          X NxD matrix where N = height x Width of image

    I=imread('im.jpg'); %load image "MUST BE IN SAME FILE"


    X=reshape(I,size(I,1)*size(I,2),D); % reshape them in a NxD matrix
    X=double(X); %needs to be in double format for .* operation
    
   
end