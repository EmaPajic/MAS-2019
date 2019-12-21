    clear all;
    close all; 
    clc; 
%
    Fs = 256;                 % frekvencija odabiranja EEG signala
    T = 30;                   % trajanje signala u sekundama
    time = 0:1/Fs:T-1/Fs;     % vremenska osa
%
    L = length(time);
    brojac = 0; 
%
% ucitavanje EEG signala
%
    load EEG_clean; 
    EEG = EEG(:, 1:T*256);    % izdvojeno je odabrano trajanje EEG snimka duzine T
%
% formiranje sintetickog suma pomocu funkcije QRS_pulse
%
    s(1,:) = QRSpulse(0.12,82,Fs,1000,T)./10;
    s(2,:) = QRSpulse(0.12,82,Fs,1000,T).*5/10;
%
    alg_number = 4;         % broj algoritama koji se koriste u kodu
    scale = 3;              % faktor skaliranja amplitude suma
% 
    A = zeros(size(EEG,1), 2);
    ch = ceil(size(EEG,1).*rand);    % slucajan  broj izmedju 1 i 20
%
    br_zasumljenih_kanala = 5;       % broj kanala koji se zeli zasumiti u EEG signalu (EEG signal ima 20 kanala)
%
% u ch promenljivu se beleze redni brojevi kanala koji su slucajno odabrani
% za zasumljivanje (sledeca while petlja)
%
    while ~( size(ch,1) == br_zasumljenih_kanala )
        pom = ceil(size(EEG,1).*rand);
        %
        if isempty ( find(ch == pom) )
            ch = [ch; pom]; 
        end
        %    
    end
%
    A(ch(1:round(br_zasumljenih_kanala/2)),1) = 5;                      % amplituda jedne polovine suma
    A(ch(round(br_zasumljenih_kanala/2):br_zasumljenih_kanala),2) = 1;  % amplituda druge polovine suma
    B = A;
%
% zasumljivanje EEG signala sa jednim i drugim sumom po random kanalima
%
    A = 0.005*2^scale*B; 
    sum = A*s;
    x = sum + EEG;          % zasumljeni EEG signali na slucajnim kanalima
    
%% algoritmi

%%%%%%%%%%%%%%%%%%%%%%%%%%%% ROBUST ICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Termination Threshold Parameter
    tic 
    ttp = 1e-3;
% Maximum number of iterations per independent component
    max_it = 1000;
% regression-based deflation
    tic
    [y_robustICA, H_robustICA] = robustica(x, [], ttp, max_it, 1, 'r', 0, [], 0);
    brojac = brojac + 1;
    toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SOBI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic
    [H_SOBI,y_SOBI] = acsorbiro(x,size(x,1),100);
    toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% JADE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic
    H_JADE = jadeR(x,size(x,1)); 
    y_JADE = H_JADE*x; 
    y_JADE = real(y_JADE);
    toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic
    [y_CCA,H_CCA,r] = ccabss_test_cc(x);
    y_CCA = real(y_CCA);
    toc

%%
% Pronalazenje odogovarajucih komponenata koje su maksimalno korelisane sa
% dobijenim nezavisnim komponentama
    [s, y_robustICA] = matching_components(s,y_robustICA);
    [s, y_SOBI] = matching_components(s,y_SOBI);
    [s, y_JADE] = matching_components(s,y_JADE);
    [s, y_CCA] = matching_components(s,y_CCA);

%% grafici
%

figure;
  subplot(2,1,1)
    plot(time, EEG(ch(1),:))
    title('EEG signal bez dodatog suma')
    xlabel('Time [s]');
    ylabel('Voltage [microV]');
  subplot(2,1,2)
    plot(time, x(ch(1),:))
    title('EEG signal sa dodatim sumom')
    xlabel('Time [s]');
    ylabel('Voltage [microV]');

figure;
  title('EEG bez i sa sumom')
  plot(time, EEG(ch(1),:), 'm')
  hold on
  plot(time, x(ch(1),:), 'g')
  xlabel('Time [s]');
  legend('bez suma', 'sa sumom')
  ylabel('Voltage [microV]');
  hold off
    
for i = 1:size(s,1)
    figure;
    subplot(5,1,1)
        plot(time, s(i,:));
        title('Originalni signal'); xlim([0 10]);
    subplot(5,1,2)
        plot(time, y_robustICA(i,:),'r'); title('robustICA'); xlim([0 10]);
    subplot(5,1,3)
        plot(time, y_SOBI(i,:),'m'); title('SOBI'); xlim([0 10]);
    subplot(5,1,4)
        plot(time, y_JADE(i,:),'g'); title('JADE'); xlim([0 10]);
    subplot(5,1,5)
        plot(time, y_CCA(i,:),'c'); title('CCA' ); xlim([0 10]);
end

%% poredjenje algoritama
%    
    rr = zeros(size(s,1),4);        % Spearman-ova korelacija
    rc = zeros(size(s,1),4);        % Korelacija
%
% Petlja prolazi kroz onoliko iteracija koliko je vrsta amplitude
% definisano na linijama 50 i 51
%
    for j = 1:size(s,1)
        rr(j,1) = spearman(s(j,:)',y_robustICA(j,:)'); 
        rr(j,2) = spearman(s(j,:)',y_SOBI(j,:)'); 
        rr(j,3) = spearman(s(j,:)',y_JADE(j,:)'); 
        rr(j,4) = spearman(s(j,:)',y_CCA(j,:)'); 
        %
        rc(j,1) = corr(s(j,:)',y_robustICA(j,:)'); 
        rc(j,2) = corr(s(j,:)',y_SOBI(j,:)'); 
        rc(j,3) = corr(s(j,:)',y_JADE(j,:)'); 
        rc(j,4) = corr(s(j,:)',y_CCA(j,:)'); 
    end
%NIJE KAO MATLAB, NE MOZE TIP U corr
    absCor1 = abs(rc(1,:));
    absCor2 = abs(rc(2,:)); 
    absCorSpearman1 = abs(rr(1,:)); 
    absCorSpearman2 = abs(rr(2,:));
%    
% Odnos signal sum
%
    SNR = log10( rmss(A*s)/rmss(x) );     % dB (rmss je funkcija koja racuna snagu signala)
%
% root mean square (RMS) greska
%
    r_rms(:,1) = rmse(s,y_robustICA);    
    r_rms(:,2) = rmse(s,y_SOBI);
    r_rms(:,3) = rmse(s,y_JADE);
    r_rms(:,4) = rmse(s,y_CCA);
    

save r_rms.mat r_rms
save absCor1.mat absCor1
save absCor2.mat absCor2
save absCorSpearman1.mat absCorSpearman1
save absCorSpearman2.mat absCorSpearman2

absCor1
absCor2
absCorSpearman1
absCorSpearman2
r_rms