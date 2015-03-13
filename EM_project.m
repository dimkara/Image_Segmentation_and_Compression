function  [cost_function,error]  = EM_project(max_iters,tol)
 

%EM_project file.EM implementation for k=1,2,4,8,16,32,64 clusters sequentially
%Inputs : maximum iterations of the EM algorithm 
%		  tolerance for convergence
%Outputs: cost_function vector of size Kx1 that shows the minimum log likehood cost of the EM for K clusters
%		  error vector of size Kx1 that shows the reconstruction error of the image for K clusters
%Can also save the files if u remove line from comments  (make sure to put other line in comments though)


format long
close all;
D = 3;



error = zeros(7,1);
K = zeros(7,1);
for i=1:size(K,1)
    
    K(i) = 2^(i-1);
   
    fprintf(['implementing EM algorithm for ' num2str(K(i)) ' clusters and '  num2str(max_iters) ' iterations with ' num2str(tol) ' maximum tolerance \n \n']);
    [z,mu,I ,X,cost_function]= EM_implementation(K(i),D,max_iters,tol);
    
    error(i)=reconstructImage(X,z,mu,I,D);% this is for not saving the image
    figure;
   %error(i)=reconstructImage(X,z,mu,I,D,i);% this is for saving the imag
end
