close all; clear all; clc;

load eegdata.mat;
trial = data{1, 4};

% function - remove EOG
task1 = double(trial{4});
fs = 250;
time = 0:1/fs:(length(task1(1,:))/fs - 1/fs);

kernel = fft(task1(7,:));
M = max(kernel);
kernel = kernel / M;

freqz(1-kernel)
%%
% c3
sigf = fft(task1(2,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);

figure
    plot(time, task1(2,:), 'LineWidth', 2, 'Color', [0 0 0]); hold on;
    plot(time, real(sigt), 'LineWidth', 2, 'Color', [0.7 0.2 0]); hold off;
        xlabel('vreme [s]');
        ylabel('amplituda [\muV]');
        legend('originalan', 'filtriran');
        grid on;

N = length(task1(2,:));        
freq = (fs/N)*(1:N);
figure
    plot(freq, abs(fft(task1(2, :))/(N/2)), 'LineWidth', 2, 'Color', [0 0 0]); hold on;
    plot(freq, abs(fft(real(sigt))/(N/2)), 'LineWidth', 2, 'Color', [0.7 0.2 0]); hold off;
        xlabel('frekvencija [Hz]');
        ylabel('magnituda [\muVs]');
        legend('originalan', 'filtriran');
        xlim([0 fs/2]);
        grid on;

F1 = abs(sigf);
F2 = abs(fft(real(sigt)));
F1 = F1 / max(F1);
F2 = F2 / max(F2);

figure
    plot(freq, 1-abs(kernel), 'LineWidth', 2, 'Color', [0 1 0]); hold on;
    plot(freq, F1, 'LineWidth', 2, 'Color', [0 0 0]);
    plot(freq, F2, 'LineWidth', 2, 'Color', [0.7 0.2 0]); hold off;
        xlabel('frekvencija [Hz]');
        ylabel('magnituda [\muVs]');
        legend('filter', 'originalan', 'filtriran');
        xlim([0 10]);
        grid on;
        
% kako da se proceni funkcija prenosa
% tfestimate(abs(fft(sigIzl2)), abs(fft(sig)),1024,[],[],fs)
% hold on;
% tfestimate(abs(fft(sigIzl1)), abs(fft(sig)),1024,[],[],fs)

figure
subplot(211)
    plot(freq, abs(fft(task1(7,:))), 'LineWidth', 2, 'Color', [0 1 0]); hold on;
    plot(freq, abs(fft(task1(2,:))), 'LineWidth', 2, 'Color', [0 0 0]); hold off;
        xlabel('frekvencija [Hz]');
        ylabel('magnituda [\muVs]');
        legend('sum', 'signal');
        xlim([0 70]);
        grid on;
subplot(212)
    plot(time, task1(7,:), 'LineWidth', 2, 'Color', [0 1 0]); hold on;
    plot(time, task1(2,:), 'LineWidth', 2, 'Color', [0 0 0]); hold off;
        xlabel('vreme [s]');
        ylabel('amplituda [\muV]');
        legend('sum', 'signal');
        grid on;
        
%% faza signala


figure
    plot(freq, unwrap(angle(fft(task1(2,:)))*180/pi), 'LineWidth', 2, 'Color', [0 0 0]); hold on;
    plot(freq, unwrap(angle(fft(real(sigt)))*180/pi), 'LineWidth', 2, 'Color', [0.7 0.2 0]); hold off;
        xlabel('frekvencija [Hz]');
        ylabel('faza signala u stepenima');
        legend('originalan', 'filtriran');
        xlim([0 10]);
        grid on;
