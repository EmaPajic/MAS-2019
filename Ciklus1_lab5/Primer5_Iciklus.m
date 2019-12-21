% example9_9.m
% Separating EEG frequency components.
% 
% FFT spectra of EEG data
%
% first channel is C3
% 2500 points = 10 s at 250 Hz
%

clc; clear all; close all;
load eegdata.mat

chap9ex = data{1}{4}(1,:);
SampRate = 250;
Nyquist = SampRate / 2;
TotalTime = 10;
N = SampRate * TotalTime;
t = (1/SampRate):1/SampRate:TotalTime;
%
% 10 s eeg data
%
eegchannel = chap9ex;
figure(1);
    plot(t, eegchannel);
    title('10s of EEG data');
    xlabel('Time in s');
    ylabel('Voltage in mV')'
%
% FFT 
%
figure(2);
eegfreq = abs(fft(eegchannel));
f = (SampRate/N)*(1:N);
    plot(f, eegfreq);
    title('FFT of EEG data');
    xlabel('Frequency in Hz');
    ylabel('Magnitude a.u.');
%
% FFT shift
%
figure(3);
eegfreqshift = fftshift(eegfreq);
f = (SampRate/N)*((-N/2+1):(N/2));
    plot(f, eegfreqshift);
    title('Symmetrical FFT of EEG data');
    xlabel('Frequency in Hz');
    ylabel('Magnitude a.u.');
%
% remove DC component
% 10 samples per Hz,  0 Hz = 1250. sampl,
% 0 Hz =1250. sempl +/-10 samples
eegfreqshift(1240:1260) = 0;
% sum( eegfreqshift(1230:1240) + eegfreqshift(1260:1270))/20 =0;
% % % % %
% remove 60Hz
% 10 samples per Hz, 600 samples per 60Hz
% 1250-600=650 samples +/- 5 samples
% 1250+600=1850 samples +/-5 samples
eegfreqshift(645:655) = 0;
eegfreqshift(1845:1855) = 0;
% sum( eegfreqshift(635:645) + eegfreqshift(655:665))/20 =0;
% sum( eegfreqshift(1835:1845) + eegfreqshift(1855:1865))/20 =0;
%
[b,a] = butter(3, 1/Nyquist, 'high');
% drugacije pravi, 2 / Nyquist je u matlabu
eegchannel_but = filtfilt(b,a,eegchannel);

[b,a] = pei_tseng_notch ( 60 / Nyquist, 60/Nyquist/35);
eegchannel_filtered = filtfilt(b, a, eegchannel_but);
eegfreq_filtered = abs(fft(eegchannel_filtered));
eegfreqshift_filtered = fftshift(eegfreq_filtered);
figure(4)
f = (SampRate/N)*((-N/2+1):(N/2));
  subplot(2,1,1)
    plot(f, eegfreqshift);
    title('Symmetrical FFT of EEG data without DC component');
    xlabel('Frequency in Hz');
    ylabel('Magnitude a.u.');
  subplot(2,1,2)
    plot(f, eegfreqshift_filtered);
    title('Filtered Symmetrical FFT of EEG data without DC component');
    xlabel('Frequency in Hz');
    ylabel('Magnitude a.u.');
%
% Power is the square of the magnitude
% 
figure(5)
f = (SampRate/N)*((-N/2+1):(N/2));
power = eegfreqshift_filtered.^2;
    plot(f, power);
    title('Spectral power');
    xlabel('Frequency in Hz');
    ylabel('Magnitude a.u.');
%
% there are 10 samples per Hz and the center is index 1250
center = 10*Nyquist;

% delta 0 to 2 
% 2 Hz = 20 samples 
% 1250 +/-20 
% theta 2 to 7 
% alpha 7 to 13 
% beta 13 to 64 

delta = 1:20;
theta = 20:70;
alpha = 70:130;
beta = 130:640;

%1250-640=610, 1250+640=1890

power_total = sum(power(610:1890))
power_delta = (sum(power(center-delta))+sum(power(center+delta))) / power_total
power_theta = (sum(power(center-theta))+sum(power(center+theta))) / power_total
power_alpha = (sum(power(center-alpha))+sum(power(center+alpha))) / power_total
power_beta = (sum(power(center-beta))+sum(power(center+beta))) / power_total
power = power_delta + power_theta + power_alpha + power_beta

figure(6)
  labels = {"delta", "theta", "alpha", "beta"}
  power_data = [power_delta; power_theta; power_alpha; power_beta];
  h = bar(power_data, "grouped")
  set (gca, 'xticklabel', labels);
  