%% 1b)

fs = 200;
bpm = 72;
amp = 1000;
d = 0.120;
pulse = QRSpulse();
RR = 60 / 72;
time = [(1:length(pulse)) / length(pulse) * 0.35];

figure(1)
    subplot(2,1,1)
      plot(time, pulse);
          title('QRSpulse plot');
          xlabel('Time in seconds');
          ylabel('Amplitude in microvolts');
    subplot(2,1,2)
    stem(time, pulse);
          title('QRSpulse stem');
          xlabel('Time in seconds');
          ylabel('Amplitude in microvolts');
        
%% 1c), 1d)
d_wider = 0.15;
pulse_wider = QRSpulse(d_wider, bpm, fs, amp);
RR = 60 / 72;
time_wider = [(1:length(pulse_wider)) / length(pulse_wider) * 0.35];
figure(2)
    plot(time_wider, pulse_wider);
        title('QRSpulse plot promenjene sirine');
        xlabel('Time in seconds');
        ylabel('Amplitude in microvolts');
       
d_wider = 0.55;
pulse_wider = QRSpulse(d_wider, bpm, fs, amp);
RR = 60 / 72;
time_wider = [(1:length(pulse_wider)) / length(pulse_wider) * 0.35];
figure(3)
    plot(time_wider, pulse_wider);
        title('QRSpulse plot promenjene sirine');
        xlabel('Time in seconds');
        ylabel('Amplitude in microvolts');