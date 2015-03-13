function [z,mu,I ,X, cost_function] = EM_implementation(K,D,max_iters,tol)

 
%EM implementation for image segmentantion
%inputs : K the number of clusters
%         D the dimension of the X data points (RGB value for our
%         implementation)
%         max_iters the number of maximum iterations
%         tol is the maximum tolerance for the reconstruction error
[I,X] =initializeImage(D); % initialize image and return 2 matrices 




N = size(I,1)*size(I,2);
mu = randi(255,K,D); %random mean matrix from 0 to 255  and KxD dimensions
p=ones(1,K);
p=p/K;
sigma = ones(K,D); % covariance matrix is KxD because is diagonal
%initialize sigma matrix
for i=1:K
    for d=1:D
        sigma(i,:) = var(mu(i,:));
    end
end

%initialization of matrices as ones
z=ones(N,K);
gdistr=ones(N,D);
cost_old=inf;

for j=1:max_iters
    
    
    %E step
    %find gamma hidden variables
    for k=1:K
        for d=1:D
		%breaking down the gaussian mixture calculation in 3 variables
            oros3=-log(sqrt(2*pi*sigma(k,d))); 
            oros2=(X(:,d)-mu(k,d)).^2;
            gdistr(:,d)=oros3-(oros2./(2*sigma(k,d))); %P(X|mu,Sigma)
            
            
        end
        z(:,k)=exp(sum(gdistr,2)+log(p(k))); 
    end
    paron=sum(z,2); 
    cost_function = sum(log(paron)); 
    for k=1:K
        z(:,k)=z(:,k)./paron; %finally the gamma(z_nk) 
    end
    
    %M step
    sumz=sum(z,1);  %the overall sum of the gamma(z_nk) hidden variables for all K
    p=sumz/N;
    for k=1:K
		%using temporary matrices for calculating new mu(K) and new sigma(K)
        temp= [z(:,k).*X(:,1), z(:,k).*X(:,2), z(:,k).*X(:,3)]; 
        temp=sum(temp,1);
        mu(k,:)= temp/sumz(k); %finally the mu_new(K)
        
        temp2= [z(:,k).*((X(:,1)-mu(k,1)).^2), z(:,k).*((X(:,2)-mu(k,2)).^2), z(:,k).*((X(:,3)-mu(k,3)).^2)];
        temp2=sum(temp2,1); 
        sigma(k,:)=temp2/sumz(k); %finally the sigma_new(K)
        
        
    end
    if(abs(cost_function-cost_old)<=tol)
            disp(['finished at iteration ' num2str(j)]);
            break;
        end
    cost_old = cost_function;
        
end


