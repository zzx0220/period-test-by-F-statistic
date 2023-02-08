% generate a sin curve with noise.

noise = randn(60,1);
T = 10;
x = [1:60]';
tau = rand*2*pi;
y_sin = sin((x)/T*2*pi+tau);
y = y_sin*0.6 + noise;


% use the PeriodTest to find the periodicity
T_to_test = 1:20; % the periodicity length to be tested
pre_dt_order = 2; % one can detrend first, linearly or 2-order polynomially

[p,F] = PeriodTest(y,T_to_test,pre_dt_order);

figure;
subplot(121);plot(T_to_test,p)
subplot(122),plot(T_to_test,F)

% The degree of freedom calculated in the function, might not be accurate in some conditions. 
% One could use permutation test or Monte Carlo method to give the null
% distribution of F.

% for example, permutation method:
for rp = 1:1000
    y_sim = Shuffle(y);
    [~,F_sim(rp,:)] = PeriodTest(y_sim,T_to_test,pre_dt_order);
end

p_permutation = mean(F<F_sim,1);

figure; scatter(p,p_permutation) % comparing the effect between permutation method and the default method


% Find the shape of the periodicity
[ml,m] = PeriodMean(y,10);

figure;plot(m) % periodicity shape in a single period
figure;plot([y_sin,y,ml']) % comparing the estimated shape to the true periodic series and the noisy signal

% detrend out of the periodicity
[ts_detrend,ts_trend] = PeriodDetrend(y,10);

figure;plot([ts_trend,ml',y_sin]) % comparing what is detrend out by this movmean method or by the average shape given by PeriodMean.m

