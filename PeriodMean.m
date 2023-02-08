function [ml,m] = PeriodMean(ts,T)
% use periodicity length T to calculate the mean curve in a period

% m, the mean curve in one period
% ml, the mean curve extended to the length of ts

ts_period = nan(ceil(length(ts)/T),T);

for i = 1:T
    tsample = ts(i:T:end);
    ts_period(1:length(tsample),i) = tsample;
end

m = mean(ts_period,'omitnan'); % single period

ml = repmat(m,1,ceil(length(ts)/T));
ml((length(ts)+1):end) = [];

end
