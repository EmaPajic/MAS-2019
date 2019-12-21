% Surrogate signals with trends 
% http://www.physionet.org/physiobank/database/synthetic/tns/ 

% 1.Signals with linear trends 
% trlina1.txt alpha = 0.1, Nmax = 217, slope of linear trend Al=2-16/index; 

% 2.Signals with sinusoidal trends 
% trsin1.txt alpha = 0.9, Nmax = 217, Amplitude of trend As=2,period T=128; 

% Resampling and baseline correction
close all; clear all; clc;
%%-------------- define input file *.txt
% data from input file are in data

fajl = fopen('trlina1.txt');
data = csvread(fajl);
% display all data
% t is the number data points
t_data = 0:1:length(data)-1;

figure(1)
    plot(t_data,data)

% --------------work with the first 400 samples 
y = data(1:400);
t = 0:1:399;
t = t';
% display 400 samples
figure(2)
    plot(t,y)

% decimate the data to estimate the baseline
indicies = 1:7:400;
t_dec = t(indicies);

% force the endpoint conditions to be zero slope
% as described in the textbook
y_dec = [y(indicies)];

for i = 2:1:56
  y_dec(i+1) += y(7*i) + y(7*i+2) + y(7*i-1) + y(7*i+3);
  y_dec(i+1) /= 5;
end;

% compute the spline estimate from the decimated data
% interpolate on the orginal range
% pp is the piecewise polynomial 
pp = spline(t_dec, y_dec);

% evaluate the polynomial on the original range
yy = ppval(pp, t);


% plot both: 
% original data in blue dots 'd'
% spline estimate of baseline in red dashes 
figure(3)
    plot(t, y, 'g')
    hold on
    plot(t, yy, 'r--')
    hold off

% do the baseline removal:
% subtract the spline estimate from the raw data
figure(4)
    plot(t, y-yy)

%------------------work with 50 % of data
t = 1:1:floor(length(t_data)/2);
y = data(1:(length(data)/2));
t = t';
size(y)
size(t)
indicies = 1:10:length(t);
t_dec = t(indicies);
y_dec = [y(indicies)];

for i = 2:1:length(t_dec) - 1
  y_dec(i+1) += y(7*i) + y(7*i+2) + y(7*i-1) + y(7*i+3) + y(7*i-2) + y(7*i+4);
  y_dec(i+1) /= 7;
end;

pp = spline(t_dec, y_dec);
yy = ppval(pp, t);
% plot both: 
% original data in blue dots
% spline estimate of baseline in red dashes
figure(5)
    plot(t, y, 'd')
    hold on
    plot(t, yy, 'r--')
    hold off

% do the baseline removal:
% subtract the spline estimate from the raw data
figure(6)
    plot(t, y-yy)