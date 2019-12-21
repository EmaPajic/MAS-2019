%% 2. zad, a)
% ecgsyn, signal 1
s = ecgsyn(64, 10, 0, 60);
time = [(1:256) / 64];
figure(4)
    plot(time, s(1:256))
        title('1st signal ecgsyn generation');
        xlabel('Time in seconds');
        ylabel('Amplitude in milivolts');
    
% ecgsyn, signal 2
s = ecgsyn(64, 16, 0, 110);
time = [(1:256) / 64];
figure(5)
    plot(time, s(1:256))
        title('2nd signal ecgsyn generation');
        xlabel('Time in seconds');
        ylabel('Amplitude in milivolts');

%% 2. zad, b)
% ECGwaveGen, signal 1
Norm = ECGwaveGen(60, 10, 64, 1000);
time = [(1:length(Norm)) / 64];
figure(6)
    plot(time, Norm);
        title('10s ECGwaveGen generation');
        xlabel('Time in seconds');
        ylabel('Amplitude in microvolts');
        
%% 2. zad, c)
s_stari = ecgsyn(64, 10, 0, 60);
time_stari = [(1:256) / 64];
s_dupli = ecgsyn(128, 10, 0, 60);
time_dupli = [(1:512) / 128];
figure(7)
    stem(time_stari, s_stari(1:256), 'r')
    hold on
    stem(time_dupli, s_dupli(1:512), 'g')
        title('Signal vs signal with doubled sampling frequency');
        xlabel('Time in seconds');
        ylabel('Amplitude in milivolts');
    hold off