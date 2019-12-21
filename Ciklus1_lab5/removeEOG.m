function removeEOG(figno, trial)
% function - remove EOG
labels = {'c3'; 'c4'; 'p3'; 'p4'; 'o1'; 'o2'; 'EOG'};
figure(figno)
task1 = double(trial{4});

kernel = fft(task1(7,:));
M = max(kernel);
kernel = kernel / M;

% c3
subplot(7,1,1);
sigf = fft(task1(1,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);
    plot(real(sigt));
        axis([0 2500 -50 50]);
        ylabel(labels(1));
        title(['EOG removed',' ',trial{1},' ',trial{3},' ',trial{2}]);

%c4
subplot(7,1,2);
sigf = fft(task1(2,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);
    plot(real(sigt));
        axis([0 2500 -50 50]);
        ylabel(labels(2));

%p3
subplot(7,1,3);
sigf = fft(task1(3,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);
    plot(real(sigt));
        axis([0 2500 -50 50]);
        ylabel(labels(3));

%p4
subplot(7,1,4);
sigf = fft(task1(4,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);
    plot(real(sigt));
        axis([0 2500 -50 50]);
        ylabel(labels(4));

%o1
subplot(7,1,5);
sigf = fft(task1(5,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);
    plot(real(sigt));
        axis([0 2500 -50 50]);
        ylabel(labels(5));

%o2
subplot(7,1,6);
sigf = fft(task1(6,:));
sigf = sigf.*(1-kernel);
sigt = ifft(sigf);
    plot(real(sigt));
        axis([0 2500 -50 50]);
        ylabel(labels(6));

%EOG
subplot(7,1,7);
    plot(fftshift(abs(kernel)));
        axis([0 2500 0 1]);
        ylabel(labels(7));
%%%%%