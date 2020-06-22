function [D] = fct_D(q1,q2,Nb) 
    D = 1;
    for i=1:Nb
        D = D - sqrt(q1(i)*q2(i)); 
    end
 