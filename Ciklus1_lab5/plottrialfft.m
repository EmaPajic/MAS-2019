function plottrialfft(figno, trial)
% function - plottrialfft
labels = {'c3'; 'c4'; 'p3'; 'p4'; 'o1'; 'o2'; 'EOG'};
figure(figno)
task1 = double(trial{4});

%plot(fftshift(abs(fft(task1(1,:)))))

% c3
subplot(7,1,1);
    plot(fftshift(abs(fft(task1(1,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(1));
        title(['Frequency spectra',' ',trial{1},' ',trial{3},' ',trial{2}]);
%c4
subplot(7,1,2);
    plot(fftshift(abs(fft(task1(2,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(2));

%p3
subplot(7,1,3);
    plot(fftshift(abs(fft(task1(3,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(3));

%p4
subplot(7,1,4);
    plot(fftshift(abs(fft(task1(4,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(4));

%o1
subplot(7,1,5);
    plot(fftshift(abs(fft(task1(5,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(5));

%o2
subplot(7,1,6);
    plot(fftshift(abs(fft(task1(6,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(6));

%EOG
subplot(7,1,7);
    plot(fftshift(abs(fft(task1(7,:)))))
        % axis([0 2500 -50 50]);
        ylabel(labels(7));
%%%%%