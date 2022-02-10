%File to extract information required from .mat file:
clc, close all

%steps: (1- Double click variable name, 2- Run this file)
X = SMCL_SMCF_Fuzzy.X;
siz = size(X.data);
Xdata = zeros(siz(1), siz(2));
for i = 1: siz(1)
    Xdata(i,:) = X.getdatasamples(i);
end
save('Xdata.mat','Xdata');

Y = SMCL_SMCF_Fuzzy.Y;
siz = size(Y.data);
Ydata = zeros(siz(1), siz(2));
for i = 1: siz(1)
    Ydata(i,:) = Y.getdatasamples(i);
end
save('Ydata.mat','Ydata');

Psi = SMCL_SMCF_Fuzzy.Psi;
siz = size(Psi.data);
Psidata = zeros(siz(1), siz(2));
for i = 1: siz(1)
    Psidata(i,:) = Psi.getdatasamples(i);
end
save('Psidata.mat','Psidata');