% Ovaj program sadrži izmenjen primer sa Matlab sajta iz help-a za fft
% funkciju
close all; clear all; clc;

Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 1000;             % Length of signal
t = (0:L-1)*T;        % Time vector

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

figure
    plot(1000*t(1:50), S(1:50), 'LineWidth', 2, 'Color', [0 0 0])
        title('Signal Corrupted with Zero-Mean Random Noise')
        xlabel('t (milliseconds)')
        ylabel('X(t) [V]')
        grid on;
        legend('0.7*sin(2*pi*50*t) + sin(2*pi*120*t)');

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

figure
    plot(f, P1, 'LineWidth', 2, 'Color', [0 0 0])
        title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)| [V]')
        grid on;