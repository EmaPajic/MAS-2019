close all; clear all; clc;

N = 20000;
fs = 1000;
time = [0:N-1]/fs;
f = [0:N-1]*fs/N;

% test 1 i test 2 signali

f1 = 1;
f2 = 5;
f3 = 10;
f4 = 20;

% test signal 1 (stacionarni signal)
x1 = cos(2*pi*f1*time) + cos(2*pi*f2*time) + cos(2*pi*f3*time) + cos(2*pi*f4*time);

% test signal 2 (nestacionarni signal)
x2 = [ cos(2*pi*f1*time(1:N/4)) cos(2*pi*f2*time(N/4+1:N/2))...
    cos(2*pi*f3*time(N/2+1:3*N/4)) cos(2*pi*f4*time(3*N/4+1:N)) ];

% test signal 3 (chirp signal)
f1c = 1;
f2c = 30;
fc = ((1:N)*((f2c-f1c)/N)) + f1c;
x3 = sin(pi*time.*fc);

% test signal 4 (sinusni signal i �um)
noise_amp = 80;
x4 = cos(2*pi*10*time) + (noise_amp.*rand(1,N)-noise_amp/2)+ ...
    cos(2*pi*20*time);

% test signal 5 (sporoosciluju�i chirp)
f1s = 1;
f2s = 5;
f3s = 25;
fc1 = ((1:N)*((f2s-f1s)/N)) + f1s;
x_1 = sin(pi*time.*fc1);
x_2 = zeros(1, N);
duz = 150;
t1 = [0:duz-1]/fs;
x_3 = 5*sin(2*pi*f3s*t1);
x_2(:,1000:1000-1+duz) = x_3;
x_2(:,8000:8000-1+duz) = x_3;
x_2(:,15000:15000-1+duz) = x_3;
x_2(:,17000:17000-1+duz) = x_3;
 
x5 = x_1 + x_2;

%primena Welch metode
%PSD_welch(x1, fs);
%PSD_welch(x2, fs);
%PSD_welch(x3, fs);
%PSD_welch(x4, fs);
%PSD_welch(x5, fs);

%primena stft

STFT(x5, fs, time);

%primena wawelet
wavelet_spekt(x5, fs, time);