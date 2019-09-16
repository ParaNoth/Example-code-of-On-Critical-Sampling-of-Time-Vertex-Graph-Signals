clc;
clear;
%% Load data
load example_data.mat

%% Get S_T, S_G
[~, s_t] = rref(u_t_tilde');
[~, s_g] = rref(u_g_tilde');

%% Get S'(s_tmp) and \Psi'\tilde{U}_J
s_tmp = zeros(1,length(s_t)*length(s_g));
num = 1;
for i = s_t
    for j = s_g
        s_tmp(num) = (i-1)*G1.N+j;
        num = num + 1;
    end
end
psi_u_j_tilde = u_j_tilde(s_tmp,:);
%% Get S and xsampled
[~, s] = rref(psi_u_j_tilde');
s_x = s_tmp(s);
xsampled = x(s_x);
%% Recover x
psi_u_j = psi_u_j_tilde(s,:);
x_r = u_j_tilde*inv(psi_u_j'*psi_u_j)*psi_u_j'*xsampled;