function [p,F] = PeriodTest(ts,T,dt_order)
% This function is to test the unknown or known periodicity of a time series using the method given by Truman L. Kelley
% (1943) The Evidence for Periodicity in Short Time Series, Journal of the American Statistical Association, 38:223,
% 319-326, DOI: 10.1080/01621459.1943.10501814

% Input:
% ts: the time series data 
% T: the periodicity to test, a single value or a series of values. This periodicity test does test for each value separately. 
% dt_order: the order of the polynomial detrending before test. For example, 0, only to minus the mean value; 1, linearly detrending; 2, 2-polynomial detrending

% Output:
% p: p-value by default F distribution
% F: F-statistic, between-class variation / within-class variation


% STEP 0: polynomial detrend
ts = detrend(ts,dt_order);

% STEP 1: calculate the total variance
mean_total = mean(ts);
SS_total = sum((ts-mean_total).^2);

for i = 1:length(T)
	% STEP 2: classify the data into different phases in a period.
	t_period = T(i);
	class_data = nan(ceil(length(ts)./t_period),t_period);
	for j = 1:t_period
		ts_period = ts(j:t_period:end);
		class_data(1:length(ts_period),j) = ts_period;
	end


	% STEP 3: calculate the mean of each class and the variation across classes, variation inside each class
	class_mean = mean(class_data,'omitnan');
	class_num = sum(~isnan(class_data));

	SS_between_class = sum(((class_mean-mean_total).^2).*class_num);  % test if that is right

	SS_within_class = SS_total - SS_between_class;

	% STEP 4: calculate the freedoms
	k_total = length(ts) - dt_order - 1; % depend on the detrend
	k_between = t_period-1;
	k_within = k_total - k_between;

	% STEP 5: calculate the F statistics
	F(i) = SS_between_class*k_within/(SS_within_class*k_between);

	% STEP 6: calculate the p value
	p(i) = 1-fcdf(F(i),k_between,k_within);
end




