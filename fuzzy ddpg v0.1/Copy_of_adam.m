function [update,s,r] = adam(gradient,learingrate,s,r,tt)
e = learingrate;
beta1 = 0.9;
beta2 = 0.999;
delta = 1e-8;
s = beta1 .*s +(1 - beta1) .*gradient(:);
r = beta2 .*r + (1 - beta2) .* (gradient(:).^2);
shat = s./(1-beta1 ^ tt);
rhat = r./(1-beta2 ^ tt);
update = -e .* shat./(sqrt(rhat) + delta);