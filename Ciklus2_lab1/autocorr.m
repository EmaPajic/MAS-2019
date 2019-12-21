% Generisanje obojenog šuma sa dva razlicita spektra
% Evaluacija primenom autokorelacije
%
close all; clear all; clc;
%
% šum
N = 1024;            % broj odbiraka
noise = randn(N, 1); % generisanje šuma (Gauss, beli) 
figure
    plot(noise, 'LineWidth', 2, 'Color', [0 0 0]);
        title('Generated white noise');
        grid on;
%
% FIR filter
L = 100;            % dužina FIR filtra
wn = pi*[1/40 1/4]; % dve granicne ucestanosti LP FIR filtra za evaluaciju
%
% Izracunavanje impulsnog odziva LP filtra
figure
for k = 1:2           % ponavljanje za dve granicne ucestanosti
    wc = wn(k);       % dodeljivanje granicne ucestanosti
    for i = 1:L+1     % generisanje sin(x)/x
        n = i-L/2;    % formiranje simetricne
        if n == 0
            hn(i) = wc/pi;
        else
           hn(i) = (sin(wc*(n)))/(pi*n);  % impulsni odziv filtra
        end
     end
    out(:, k) = conv(hn, noise);             % filter daje obojeni šum
    [cor, lags] = xcorr(out(:, k), 'coeff'); % racunanje autocorelacije, normalizacija
    %
    % prikaz autokorelacije
    subplot(1, 2, k);
        plot(lags(1,:), cor(:,1), 'k', 'LineWidth', 2); % autokorelacija kroz lag vektor
            axis([-100 100 -.5 1.1]);
            ylabel('R_x_x');
            xlabel('Lags(n)');
            title(['Bandwidth = ' num2str(wc) ', colored noise ' num2str(k)]);
            grid on;
end

figure
    plot(out(:, 2), 'LineWidth', 2, 'Color', [0 0.9 0.9]); hold on;
    plot(out(:, 1), 'LineWidth', 2, 'Color', [0 0 0]); hold off;
        title('Colored noise - time domain');
        grid on;
        legend('colored noise 2', 'colored noise 1')
        xlim([0 N]);
        xlabel('samples');
        
figure
fft1 = abs(fft(out(:, 1)));
fft2 = abs(fft(out(:, 2)));
    plot(fft2, 'LineWidth', 2, 'Color', [0 0.9 0.9]); hold on;
    plot(fft1, 'LineWidth', 2, 'Color', [0 0 0]); hold off;
        title('Colored noise - FFT');
        grid on;
        legend('colored noise 2', 'colored noise 1')
        xlim([0 length(fft1)/2]);
        xlabel('samples');