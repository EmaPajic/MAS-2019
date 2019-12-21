% Primer3_Iciklus.m (example10_1.m)

% ECGwaveGen, signal 1
Norm = ECGwaveGen(60, 5, 64, 1000);
time = [(1:length(Norm)) / 64];
figure(1)
    plot(time, Norm);
        title('ECGwaveGen synthesis');
        xlabel('Time in seconds');
        ylabel('Amplitude in microvolts');
        
% ECGwaveGen, signal 2
Norm = ECGwaveGen(110, 5, 64, 1000);
time = [(1:length(Norm)) / 64];
figure(2)
    plot(time, Norm);
        title('ECGwaveGen synthesis of Sinus Tachycardia');
        xlabel('Time in seconds');
        ylabel('Amplitude in microvolts');

% ecgsyn, signal 1
s = ecgsyn(64, 10, 0, 60);
figure(3)
    plot(s(1:256))
    
% ecgsyn, signal 2
s = ecgsyn(64, 16, 0, 110);
figure(4)
    plot(s(1:256))