function [X] = SIRm(sr0,sv0,sINS,N,T,delta,Y,r_INS,sBAR,sALT)

X=zeros(4,T+1); % La matrice qui va accuellir tous les Xk corrigÃ©s


% k=0
pk=zeros(1,N); %les poids correspondant aux Ã©chantillons Ã  l instant k=0
ksi_k=[normrnd(0,sr0,[2,N]);normrnd(0,sv0,[2,N])]; % GÃ©nÃ©ration des Ã©chantillons ksi_0_i
ksi_k_pond = zeros(4,N); % Matrices des p0_i*ksi_0

 for i=1:N
       pk(i) = fct_vrais(ksi_k(1:2,i),Y,1,r_INS,sBAR,sALT);
 end
 pk = pk/sum(pk);
 for i=1:N
    ksi_k_pond(:,i)=pk(i)*ksi_k(:,i);
 end

X(:,1)=sum(ksi_k_pond,2); %X0 estimÃ©

%%ksi_klin = zeos(4,N);

for k=2:T+1
    fk =[[1,0,delta,0];[0,1,0,delta];[0,0,1,0];[0,0,0,1]];
    wINS = normrnd(0,sINS,[2,N]);
    
% Selection des individus 
    ksi_hat_k = fct_multi(ksi_k,pk,N);
% Etape 3 : Propagation
    ksi_k = fk*ksi_hat_k-delta*[zeros(2,N);wINS];
% Etape 4 : correction 
    for i=1:N
       pk(i) = fct_vrais(ksi_k(1:2,i),Y,k,r_INS,sBAR,sALT);
    end
    pk = pk/sum(pk);
    for i=1:N
        ksi_k_pond(:,i)=pk(i)*ksi_k(:,i);
    end
    X(:,k)=sum(ksi_k_pond,2);
   
    Qk = covParticlesRV(ksi_k);
    ksi_k = mvnrnd(zeros(4,1),Qk,N)' ;
    
     
end