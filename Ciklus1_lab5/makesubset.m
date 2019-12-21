% Uncomment to display cell, subject, task, and trial number for all data
% for i = 1:length(data)
%   {i, data{i}{1} data{i}{2} data{i}{3}}
% end

% Extract and plot one trial from subject 1 for each of the five tasks.
data{1}
task1 = data{1}{4};
subplot(5,1,1);
    plot(task1');
        title('Baseline Task');

data{6}
task2 = data{6}{4};
subplot(5,1,2);
    plot(task2');
        title('Multiplication Task');

data{11}
task3 = data{11}{4};
subplot(5,1,3);
    plot(task3');
        title('Letter Task');

data{16}
task4 = data{16}{4};
subplot(5,1,4);
    plot(task4');
        title('Rotation Task');

data{21}
task5 = data{21}{4};
subplot(5,1,5);
    plot(task5');
        title('Counting Task');

disp(' ');
disp('Now plotting again without the EOG channel. Just plotting the 6 EEG channels');
disp('Press return.');
pause;

subplot(5,1,1)
    plot(task1(1:6,:)');
        title('Baseline Task');

subplot(5,1,2)
    plot(task2(1:6,:)');
        title('Multiplication Task');

subplot(5,1,3)
    plot(task3(1:6,:)');
        title('Letter Task');

subplot(5,1,4)
    plot(task4(1:6,:)');
        title('Rotation Task');

subplot(5,1,5)
    plot(task5(1:6,:)');
        title('Counting Task');

disp(' ');
disp('Now variables  task1, task2, task3, task4, and task5 are 7x2500 matrices')
disp([' First 6 channels are EEG electrode data and the 7th one is the EOG '...
    ' channel for eyeblink detection']);
    
data{97}
eeg1 = data{97}{4};
time = (1:length(eeg1)) / 250;

figure(2)
    plot(time, eeg1');
        title('Subject 3, Counting Task, Trial 2');
        xlabel('Time [s]');
        ylabel('Amplitude [mV]');