
clear;clc;

J=eye(10,10);
Q=zeros(10,10);
Q(1,2)=1;
Q(2,3)=1;
Q(3,4)=1;
Q(4,5)=1;
Q(5,1)=1;
Q(1,6)=1;
Q(2,7)=1;
Q(8,3)=1;
Q(4,9)=1;
Q(5,10)=1;
Q(10,7)=1;
Q(6,8)=1;
Q(7,9)=1;
Q(8,10)=1;
Q(9,6)=1;

cvx_begin
variable X(10,10) semidefinite ;
minimize(trace(Q*X));
    subject to
    X(1,1)==1;
    X(2,2)==1;
    X(3,3)==1;
    X(4,4)==1;
    X(5,5)==1;
    X(6,6)==1;
    X(7,7)==1;
    X(8,8)==1;
    X(9,9)==1;
    X(10,10)==1;
    
        
cvx_end