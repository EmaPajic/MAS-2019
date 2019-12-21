function plottrialpsd(eegdata, trial, channel)
% function - plottrialpsd
SampRate =  250;
TotalTime =  10;
N =  25000;
t =  (1/SampRate):1/SampRate:TotalTime;
labels = {'c3'; 'c4'; 'p3'; 'p4'; 'o1'; 'o2'; 'EOG'};
lead = labels{channel};
%
x = double(eegdata{trial}{4}(channel,:));
Y =  fft(x,N);
Z =  abs(fft(x,N));
Pyy =  Y.* conj(Y) / N;
%
% Display
%
subplot(2, 1, 1)
    plot(1000*t,x)
        title([eegdata{trial}{1},' ',eegdata{trial}{3},' ',...
            eegdata{trial}{2},' = ',lead]);
        xlabel('time (milliseconds)')
%
f = SampRate*(0:N/2)/N;
subplot(2, 2, 3)
    plot(f,Pyy(1:N/2+1))
        title('Power content of x')
        xlabel('frequency (Hz)')
%
subplot(2, 2, 4)
    plot(f,Z(1:N/2+1))
        title('FFT content of x')
        xlabel('frequency (Hz)')