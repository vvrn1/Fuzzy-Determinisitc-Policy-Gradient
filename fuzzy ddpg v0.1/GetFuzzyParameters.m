function [sigma,mu,K] = GetFuzzyParameters(filename)

fis  = readfis(filename);
imfs = getfis(fis,'inmfparams')  ;
omfs = getfis(fis,'outmfparams') ;

sigma(:,1) = imfs(:,1) ;
mu(:,1)    = imfs(:,2) ;
K(:,1)     = omfs(:,1) ;
