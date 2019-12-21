function diff = processavg(avgdata, sr)
% function - processavg
% Calculates bandpass as three-dimensional cell array

CL = 1; CR = 2; PL = 3; PR = 4; OL = 5; OR = 6; EOG = 7;

WAVE{1} = {'delta', 0, 2};
WAVE{2} = {'theta', 2, 7};
WAVE{3} = {'alpha', 7, 13};
WAVE{4} = {'betalow', 14, 20};
WAVE{5} = {'betahigh', 20, 64};

clear diff;
if iscell(avgdata)
     curravg = avgdata;
else
     curravg{1} = avgdata;
end
diff = cell(3, length(WAVE));
isvector = 1;

for m = 1:length(curravg) % for each trial
    for n = 1 : length(WAVE) % for each band:
        c3 = sum(bpf(WAVE{n}{2}, WAVE{n}{3}, sr, curravg{m}(CL,:), 'f')); %power of left central wave
        c4 = sum(bpf(WAVE{n}{2}, WAVE{n}{3}, sr, curravg{m}(CR,:), 'f')); %power of central wave
        p3 = sum(bpf(WAVE{n}{2}, WAVE{n}{3}, sr, curravg{m}(PL,:), 'f')); %power of pareital wave
        p4 = sum(bpf(WAVE{n}{2}, WAVE{n}{3}, sr, curravg{m}(PR,:), 'f')); %power of pareital wave
        o1 = sum(bpf(WAVE{n}{2}, WAVE{n}{3}, sr, curravg{m}(OL,:), 'f')); %power of occipital wave
        o2 = sum(bpf(WAVE{n}{2}, WAVE{n}{3}, sr, curravg{m}(OR,:), 'f')); %power of occipital wave
       
        diff{1,n,m} = (c3-c4)./(c3 + c4 + eps)*100;
        diff{2,n,m} = (p3-p4)./(p3 + p4 + eps)*100;
        diff{3,n,m} = (o1-o2)./(o1 + o2 + eps)*100;
    end
end