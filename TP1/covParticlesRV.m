function [ COV] = covParticlesRV( part )

r1= part(1,:);
r2 = part(2,:);
v1 = part(3,:);
v2 = part(4,:);

% les moyennes 

MEAN1 = mean(r1,2);
MEAN2 = mean(r2,2);
MEAN3 = mean(v1,2);
MEAN4 = mean(v2,2);

% Les covariances

var_r1 = mean( ((r1 - MEAN1).^2),2);
var_r2 = mean( ((r2 - MEAN2).^2),2 );
var_v1 = mean( ((v1 - MEAN3).^2),2);
var_v2 = mean( ((v2 - MEAN4).^2),2);

var_r1r2 = mean( ((r1 - MEAN1).*(r2 - MEAN2)),2);
var_r1v1 = mean( ((r1 - MEAN1).*(v1 - MEAN3)),2);
var_r1v2 = mean( ((r1 - MEAN1).*(v2 - MEAN4)),2);

var_r2v1 = mean( ((r2 - MEAN2).*(v1 - MEAN3)),2 );
var_r2v2 = mean( ((r2 - MEAN2).*(v2 - MEAN4)),2);

var_v1v2 = mean( ((v1 - MEAN3).*(v2 - MEAN4)));

% la matrice de covariance 

COV(1,1)=var_r1;
COV(2,2)=var_r2;
COV(3,3)=var_v1;
COV(4,4)=var_v2;


COV(1,2)=var_r1r2;
COV(2,1)=var_r1r2;
COV(1,3)=var_r1v1;
COV(3,1)=var_r1v1;

COV(1,4)=var_r1v2;
COV(4,1)=var_r1v2;

COV(2,3)=var_r2v1;
COV(3,2)=var_r2v1;
COV(2,4)=var_r2v2;
COV(4,2)=var_r2v2;

COV(3,4)=var_v1v2;
COV(4,3)=var_v1v2;

