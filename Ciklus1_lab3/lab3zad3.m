% Sampling frequency: 
    fs = 64;
% Heart rate: 
    bpm = 90;
% Duration in seconds: 
    duration = 9;
% Aprox num of R peaks:
    Nrr = 6;
% Number of experiments for every time counting
    N = 10;

ecgsyn_time = 0;
for i = 1:N
    tic
        ecgsyn(fs, Nrr, 0, bpm);
    time = toc;
    ecgsyn_time = ecgsyn_time + time / N;
end

ECGwaveGen_time = 0;
for i = 1:N
    tic
        ECGwaveGen(bpm, duration, fs);
    time = toc;
    ECGwaveGen_time = ECGwaveGen_time + time / N;
end

QRSpulse_time = 0;
for i = 1:N
    tic
        QRSpulse(0.12, bpm, fs);
    time = toc;
    QRSpulse_time = QRSpulse_time + time / N;
end

fprintf(1, 'Average execution time:\n');
fprintf(1, 'ecgsyn: %.3f\n', ecgsyn_time);
fprintf(1, 'ECGwaveGen: %.3f\n', ECGwaveGen_time);
fprintf(1, 'QRSpulse: %.3f\n', QRSpulse_time);

% Spektar

% ecgsyn

X_ecgsyn = ecgsyn(fs, Nrr, 0, bpm);
L = length(X_ecgsyn);
nfft = 2 ^ nextpow2(L); 
Y = fft(X_ecgsyn, nfft) / L;
f = fs / 2 * linspace(0, 1, nfft / 2 + 1);

% Plot single-sided amplitude spectrum.
figure(8)
    plot(f,2 * abs(Y(1 : nfft / 2 + 1))) 
        title('Jednostrani spektar ecgsyn')
        xlabel('Frekvencija (Hz)')
        ylabel('|Y(f)|')

% ECGwaveGen

X_ECGwaveGen = ECGwaveGen(bpm, duration, fs);
L = length(X_ECGwaveGen);
nfft = 2 ^ nextpow2(L); % Next power of 2 from length of y
Y = fft(X_ECGwaveGen, nfft) / L;
f = fs / 2 * linspace(0, 1, nfft / 2 + 1);

% Plot single-sided amplitude spectrum.
figure(9)
    plot(f,2 * abs(Y(1 : nfft / 2 + 1))) 
        title('Jednostrani spektar ECGwaveGen')
        xlabel('Frekvencija (Hz)')
        ylabel('|Y(f)|')

% QRSpulse

X_QRSpulse = QRSpulse(0.12, bpm, fs);
L = length(X_QRSpulse);
nfft = 2 ^ nextpow2(L); % Next power of 2 from length of y
Y = fft(X_QRSpulse, nfft) / L;
f = fs / 2 * linspace(0, 1, nfft / 2 + 1);

% Plot single-sided amplitude spectrum.
figure(10)
    plot(f,2 * abs(Y(1 : nfft / 2 + 1))) 
        title('Jednostrani spektar QRSpulse')
        xlabel('Frekvencija (Hz)')
        ylabel('|Y(f)|')