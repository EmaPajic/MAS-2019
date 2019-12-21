% example10_3.m
% Differential brain activity in the left and right hemispheres
%
clc; clear all; close all;
% constants
TRIALS = 5;
EXPERIMENTS = 5;
SESSIONS = 13;
SR = 250; %sample rate

% subject/trial map
SUBJ{1} = 1:50;
SUBJ{2} = 51:75;
SUBJ{3} = 76:125;
SUBJ{4} = 126:175;
SUBJ{5} = 176:250;
SUBJ{6} = 251:300;
SUBJ{7} = 301:325;

load eegdata.mat
for i = 1:length(data) data{i}{4} = double(data{i}{4}); end;
datamag = data; % create copy of data

f = SR*(0:2500/2)/2500; % frequency data

for m = 1:length(data)
    kernel = fft(datamag{m}{4}(7,:));
    kernel = kernel/max(kernel);
    datamag{1};
    for (n = 1:6)
        z = abs(fft(data{m}{4}(n,:)) .*(1 - kernel)); % remove eog   
        z = z(1:length(f));
        z = bpf(59.5, 60.5, SR, z, 'f', 1); % apply bandstop filter at 60Hz (see bpf.m)
        datamag{m}{5}(n,:) = abs(z); % power series for trial
    end
end

clear avgdata;
% average over all experiments
for m = 1 : EXPERIMENTS
    trials = [];    
   for n = 1:SESSIONS
        trials = [trials (m - 1) * TRIALS + (n - 1) * EXPERIMENTS * TRIALS + (1:TRIALS)];
   end
   avgdata{m} = averagedata(datamag, trials);
   
   %by subject
   for i = 1 : length(SUBJ)
       subjdata{i,m} = averagedata(datamag, intersect(trials, SUBJ{i}));
   end
   
   %by age
   for i = 1 : 3
       if (i == 1)
           z = [SUBJ{3} SUBJ{4} SUBJ{5} SUBJ{6} SUBJ{7}]; %age < 30
       elseif (i == 2)
           z = SUBJ{2}; % age 30 - 40
       else
           z = SUBJ{1}; % age 40 - 50
       end
       agedata{i,m} = processavg(averagedata(datamag, intersect(trials, z)), SR);
   end
   
   %by handedness
   for i = 1:2
       if (i == 1)
           z = SUBJ{1}; % LH
       else
           z = setdiff(1:EXPERIMENTS*SESSIONS*TRIALS, SUBJ{1}); % RH, all not in LH
       end
       handdata{i,m} = processavg(averagedata(datamag, intersect(trials, z)), SR);
   end
   
   % by gender
   for i = 1:2
       if (i == 1)
           z = SUBJ{5}; % female
       else
           z = setdiff(1:EXPERIMENTS*SESSIONS*TRIALS, SUBJ{5}); % male (setdiff ==> everyone else)
       end
       genderdata{i,m} = processavg(averagedata(datamag, intersect(trials, z)), SR);
   end
end
trialdiff = processavg(avgdata, SR);
disp('Done');
disp('The results are in the cell arrays subjdata, agedata, handdata, and genderdata');
disp('Table 10.3 is given in the cell array trialdiff');

