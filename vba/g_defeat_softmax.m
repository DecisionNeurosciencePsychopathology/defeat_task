function  [ gx ] = g_defeat_softmax(x,P,u,in )

%Get bias parameter
%bias = exp(P);
bias = 1./(1+exp(-P));


%set up ranges for where subjects can decide to pick from
for i = 1:length(u{3})
    if strcmp('free',u{3})
        c=-4;
        d=4;
    elseif strcmp('above',u{3})
        c=2;
        d=4;
    elseif strcmp('above_forced',u{3})
        c=4;
        d=4;
    elseif strcmp('below',u{3})
        c=-2;
        d=-4;
    elseif strcmp('below_forced',u{3})
        c=-4;
        d=-4;
    elseif strcmp('max_forced',u{3})
        
    end
end

gx = rand + bias;

%Scale gx into range of y, bias + rand will always have range a=0 b=2
a=0;
b=2;

%Y's range will depend on trial type but will be between c=-4 and d=4

%Scale it using affine transformation
new_gx = (gx-a)*((d-c)/(b-a))+c;

%Produce new gx
gx = new_gx;