clc;
close all;

%%%% Coloum constraint %%%%%%%%%%%%
A_col = [];
for i=1:9
    A = [zeros(9, 81*(i-1)) eye(9) eye(9) eye(9) eye(9) eye(9) eye(9) eye(9) eye(9) eye(9) zeros(9, 729-81*i)];
    A_col = [A_col; A];
end

%%%%% Row constraint %%%%%%%%%%%%%%
A_row = [];

for i=1:9
    A = [zeros(9, 9*(i-1)) eye(9) zeros(9,72) eye(9) zeros(9, 72) eye(9) zeros(9, 72) eye(9) zeros(9, 72) eye(9) zeros(9,72) eye(9) zeros(9,72) eye(9) zeros(9,72) eye(9) zeros(9, 72) eye(9) zeros(9, 72-9*(i-1))];
    A_row = [A_row; A];
end

%%%% Box constraint %%%%%

A_b1 = [];
for i=1:3
    A = [zeros(9, 27*(i-1)) eye(9) eye(9) eye(9) zeros(9, 54) eye(9) eye(9) eye(9) zeros(9, 54) eye(9) eye(9) eye(9) zeros(9, 54-(27*(i-1))) zeros(9, 54*9)];
    A_b1 = [A_b1; A];
end

A_b2 = [];
for i=1:3
    A = [zeros(9, 27*9) zeros(9, 27*(i-1)) eye(9) eye(9) eye(9) zeros(9, 54) eye(9) eye(9) eye(9) zeros(9, 54) eye(9) eye(9) eye(9) zeros(9, 54-(27*(i-1))) zeros(9, 27*9)];
    A_b2 = [A_b2; A];
end


A_b3 = [];


for i=1:3
    A = [zeros(9, 54*9) zeros(9, 54-(27*(i-1))) eye(9) eye(9) eye(9) zeros(9, 54) eye(9) eye(9) eye(9) zeros(9, 54) eye(9) eye(9) eye(9) zeros(9, 27*(i-1))];
    A_b3 = [A_b3; A];
end

A_b = [A_b1; A_b2; A_b3];


%%%%%%%%% Cell constraint %%%%%%%%%%%%%%%%%%%
A_cell = [];
for i=1:81
    A = [zeros(1, 9*(i-1)) ones(1, 9) zeros(1, 729-(9*i))];
    A_cell = [A_cell; A];
end


A = [A_row; A_col; A_b; A_cell];

while(1)
    d = input("do u want to enter the clues for sudoku(yes/no)=(1/0)");
    if d==1
        x = input("enter the position(x,y); x= ");
        y = input("enter y = ");
        pos = (9*(y-1)) + x;
        N = input("enter the number");
        A1 = [zeros(1, N-1) ones(1, 1) zeros(1, 9-N)];
        A = [A; [zeros(1, 9*(pos-1)) A1 zeros(1, 729-(9*pos))]];
        A1 = [];
    else
        break;
    end
    
end

disp(size(A))

b = ones(size(A,1),1);
cvx_begin
variable x(size(A,2),1)
minimize norm(x,1)
subject to
A*x == b;
sum(x)==81;
cvx_end


S = zeros(9,9);
k = [1, 2, 3, 4, 5, 6, 7, 8, 9];

for i=1:81
    a = [x(((i-1)*9)+1 : i*9, 1)];
    n = dot(a,k);
    if mod(i,9) == 0
        S(9, floor((i-1)/9)+1) = n;
    else
        S(mod(i,9), floor((i-1)/9)+1)=n;
    end
    
end

disp(S);



















