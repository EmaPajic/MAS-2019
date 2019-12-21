% 1. i 2. zadatak

file = fopen('EEG_signal.txt','r');
formatSpec = '%f';
fs = 1000;
eeg = fscanf(file, formatSpec);
figure()
specgram(eeg, 256, fs, 150, 75);

% 3. zadatak
file_emg = fopen('emg_signal.txt','r');
emg = fscanf(file_emg, formatSpec);
time = (1:1:length(emg)) / 1000;
figure()
plot(time, emg);
xlabel('Time [s]')
ylabel('Amplitude [mV]')
title('Signal iz emg signal.txt')

% 4. zadatak
file_ssvep = fopen('EEG_signal_SSVEP.txt','r');
formatSpec = '%f';
fs = 500;
eeg_ssvep = fscanf(file_ssvep, formatSpec);
figure()
specgram(eeg_ssvep, 1024, fs, 500, 250);