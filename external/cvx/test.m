%Please give feadback on how to utilize cvx better.

clear;clc;

J=ones(10,10);
A1=zeros(10,10);
A2=A1;
A3=A1;
A4=A1;
A5=A1;
A6=A1;
A7=A1;
A8=A1;
A9=A1;
A10=A1;
A11=A1
A12=A1;
A13=A1;
A14=A1;
A15=A1;

A1(1,2)=1;
A2(2,3)=1;
A3(3,4)=1;
A4(4,5)=1;
A5(5,1)=1;
A6(1,6)=1;
A7(2,7)=1;
A8(8,3)=1;
A9(4,9)=1;
A10(5,10)=1;
A11(10,7)=1;
A12(6,8)=1;
A13(7,9)=1;
A14(8,10)=1;
A15(9,6)=1;

cvx_begin
variable X(10,10) semidefinite;
    maximize( trace(J*X) );
    subject to
        trace(X) == 1;
        trace(A1*X) == 0;
        trace(A2*X) == 0;
        trace(A3*X) == 0;
        trace(A4*X) == 0;
        trace(A5*X) == 0;
        trace(A6*X) == 0;
        trace(A7*X) == 0;
        trace(A8*X) == 0;
        trace(A9*X) == 0;
        trace(A10*X) == 0;
        trace(A11*X) == 0;
        trace(A12*X) == 0;
        trace(A13*X) == 0;
        trace(A14*X) == 0;
        trace(A15*X) == 0;
cvx_end