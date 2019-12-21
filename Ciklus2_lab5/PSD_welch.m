%% Power Spectral Density (FFT i Welch)
function PSD_welch(signal, fs, title)

signal1 = signal;
N = length(signal1);
f = (fs/N)*((-N/2+1):(N/2));
time = [0:N-1]/fs;
PSD = (abs(fft(signal1))).^2;

figure
    subplot(3,1,1);
        plot(time,signal1)
                xlabel('vreme [s]'); ylabel('amplituda'); axis tight; 
                title('Signal u vremenskom domenu');
    subplot(3,1,2);
        plot(f,fftshift(abs(fft(signal1))));
                title(['FFT']); ylabel('PSD');
                xlabel('frekvencija [Hz]'); xlim([0 30]);
   
% podrazumevane vrednosti za Welch metod, signal se deli na N1 delova
% koristi se hamming-ov prozor, 50% preklapanja   
window = round(N/4.5);
N1 = 15;
window = round(N/N1);
% za korak vremena bira se polovina sirine prozora (50% overlap)
noverlap = 0.5;
 
    subplot(3,1,3);
    [PSD_welch,f2] = pwelch(signal1,window,noverlap,[],fs);
        plot(f2,PSD_welch);
            xlim([0 30]);
            xlabel('frekvencija [Hz]');  ylabel('PSD');
            title('Welch-ova methoda');