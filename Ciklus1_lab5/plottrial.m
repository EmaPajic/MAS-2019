function plottrial(figno, trial)
% function - plottrial
% Uncomment to display subject, task, and trial number for all data
% for i=1:length(data)
%   {i, data{i}{1} data{i}{2} data{i}{3}}
% end

%Extract and plot one trial from subject 1 for each of the five tasks.
labels = {'c3'; 'c4'; 'p3'; 'p4'; 'o1'; 'o2'; 'EOG'};
% data{1}
figure(figno)
task1 = trial{4};

% c3
subplot(7,1,1);
    plot(task1(1,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(1));

title([trial{1},' ',trial{3},' ',trial{2}]);

%c4
subplot(7,1,2);
    plot(task1(2,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(2));

%p3
subplot(7,1,3);
    plot(task1(3,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(3));

%p4
subplot(7,1,4);
    plot(task1(4,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(4));

%o1
subplot(7,1,5);
    plot(task1(5,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(5));

%o2
subplot(7,1,6);
    plot(task1(6,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(6));

%EOG
subplot(7,1,7);
    plot(task1(7,:)');
        axis([0 2500 -50 50]);
        ylabel(labels(7));

%%%%%

% task1 = data{1}{4};
% for i = 1:7
%     subplot(7,1,i);
%       plot(task1(i,:)');
%           axis([0 2500 -50 50]);
%           ylabel(labels(i));
% end 
% title('Baseline Task');

% data{6}
% figure(2)
% 
% task2 = data{6}{4};
% for i = 1:7
%     subplot(7,1,i);
%       plot(task2(i,:)');
%           axis([0 2500 -50 50]);
%           ylabel(labels(i));
% end
% title('Multiplication Task');

% data{11}
% task3 = data{11}{4};
% subplot(5,1,3);
%   plot(task3');
%       title('Letter Task');
% 
% data{16}
% task4 = data{16}{4};
% subplot(5,1,4);
%   plot(task4');
%       title('Rotation Task');
% 
% data{21}
% task5 = data{21}{4};
% subplot(5,1,5);
%   plot(task5');
%       title('Counting Task');

% disp(' ');
% disp('Now plotting again without the EOG channel. Just plotting the 6 EEG channels');
% disp('Press return.');
% pause;
% 
% subplot(5,1,1)
%   plot(task1(1:6,:)');
%       title('Baseline Task');
% 
% subplot(5,1,2)
%   plot(task2(1:6,:)');
%       title('Multiplication Task');
% 
% subplot(5,1,3)
%   plot(task3(1:6,:)');
%       title('Letter Task');
% 
% subplot(5,1,4)
%   plot(task4(1:6,:)');
%       title('Rotation Task');
% 
% subplot(5,1,5)
%   plot(task5(1:6,:)');
%       title('Counting Task');
% 
% disp(' ');
% disp('Now variables  task1, task2, task3, task4, and task5 are 7x2500 matrices')
% disp([' First 6 channels are EEG electrode data and the 7th one is the EOG '...
%     ' channel for eyeblink detection']);