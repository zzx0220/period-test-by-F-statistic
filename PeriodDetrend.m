function [ts_detrend,ts_trend] = PeriodDetrend(ts,T)
% detrend the time series using sliding window with periodicity T

ts_trend = movmean(ts,T,'omitnan');
ts_detrend = ts- ts_trend;

end