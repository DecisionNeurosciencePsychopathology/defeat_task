function  [fx] = f_defeat_Qlearn(x,theta,u,in)

%Set initial rank hidden state at starting point
if u{4,1} == 1
    x = 16;
end

fx = x;

