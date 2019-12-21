close all; clear all; clc;

PATH = '/home/user/Desktop/4.god/MAS/MAS2_1/1ZadatakSnimciEKG/';
VT_PA_FILENAME = fopen(strcat(PATH,'pt2 vt.pa'), 'r');
VT_BI_FILENAME = fopen(strcat(PATH,'pt2 vt.bi'), 'r');
VF_PA_FILENAME = fopen(strcat(PATH,'pt2 vf.pa'), 'r');
VF_BI_FILENAME = fopen(strcat(PATH,'pt2 vf.bi'), 'r');

[vt_pa_EKG] = fscanf(VT_PA_FILENAME, '%d');
[vt_bi_EKG] = fscanf(VT_BI_FILENAME, '%d');
[vf_pa_EKG] = fscanf(VF_PA_FILENAME, '%d');
[vf_bi_EKG] = fscanf(VF_BI_FILENAME, '%d');

rho_start = 16;
rho_end = 64;
%% vt pa
[autocorr_direct_vt_pa, peak_direct_vt_pa, index_direct_vt_pa] = ...
    Primer1_IIciklus(vt_pa_EKG, 'pt2 vt.pa', 1, length(vt_pa_EKG) - 1, ...
                     16, 64, 'direct');
[autocorr_hybrid_vt_pa, peak_hybrid_vt_pa, index_hybrid_vt_pa] = ...
    Primer1_IIciklus(vt_pa_EKG, 'pt2 vt.pa', 1, length(vt_pa_EKG) - 1, ...
                     16, 64, 'hybrid sign');
[autocorr_m_hybrid_vt_pa, peak_m_hybrid_vt_pa, index_m_hybrid_vt_pa] = ...
    Primer1_IIciklus(vt_pa_EKG, 'pt2 vt.pa', 1, length(vt_pa_EKG) - 1, ...
                     16, 64, 'modified hybrid sign');
[autocorr_relative_vt_pa, peak_relative_vt_pa, index_relative_vt_pa] = ...
    Primer1_IIciklus(vt_pa_EKG, 'pt2 vt.pa', 1, length(vt_pa_EKG) - 1, ... 
                     16, 64, 'relative magnitude');

figure
  subplot(2,1,1)
    plot(vt_pa_EKG);
    title(['Original Data, Data File = pt2 vt.pa']);
    xlabel('Time [seconds]');
    ylabel('Amplitude [microV]');
  subplot(2,1,2)
    plot(rho_start:rho_end, autocorr_direct_vt_pa(rho_start:rho_end));
    hold on 
    plot(rho_start:rho_end, autocorr_hybrid_vt_pa(rho_start:rho_end), 'g');
    hold on
    plot(rho_start:rho_end, autocorr_m_hybrid_vt_pa(rho_start:rho_end), 'r');
    hold on
    plot(rho_start:rho_end, autocorr_relative_vt_pa(rho_start:rho_end), 'y');
    xlabel('Lag');
    ylabel('Normalized Autocorrelation a.u.');
    legend('Direct','Hybrid Sign','Modified Hybrid Sign','Relative Magnutude');
    title({['Normalized Autocorrelation, ' ...
       '(Direct) peak = ' num2str(peak_direct_vt_pa) ' at lag ' num2str(index_direct_vt_pa)]; ...
       ['(hybrid sign) peak = ' num2str(peak_hybrid_vt_pa) ' at lag ' num2str(index_hybrid_vt_pa)]; ...
       ['(m hybrid sign) peak = ' num2str(peak_m_hybrid_vt_pa) ' at lag ' num2str(index_m_hybrid_vt_pa)]; ...
       ['(relative) peak = ' num2str(peak_relative_vt_pa) ' at lag ' num2str(index_relative_vt_pa)]});

%% vt bi
[autocorr_direct_vt_bi, peak_direct_vt_bi, index_direct_vt_bi] = ...
    Primer1_IIciklus(vt_bi_EKG, 'pt2 vt.bi', 1, length(vt_bi_EKG) - 1, ...
                     16, 64, 'direct');
[autocorr_hybrid_vt_bi, peak_hybrid_vt_bi, index_hybrid_vt_bi] = ...
    Primer1_IIciklus(vt_bi_EKG, 'pt2 vt.bi', 1, length(vt_bi_EKG) - 1, ...
                     16, 64, 'hybrid sign');
[autocorr_m_hybrid_vt_bi, peak_m_hybrid_vt_bi, index_m_hybrid_vt_bi] = ...
    Primer1_IIciklus(vt_bi_EKG, 'pt2 vt.bi', 1, length(vt_bi_EKG) - 1, ...
                     16, 64, 'modified hybrid sign');
[autocorr_relative_vt_bi, peak_relative_vt_bi, index_relative_vt_bi] = ...
    Primer1_IIciklus(vt_bi_EKG, 'pt2 vt.bi', 1, length(vt_bi_EKG) - 1, ... 
                     16, 64, 'relative magnitude');

figure
  subplot(2,1,1)
    plot(vt_bi_EKG);
    title(['Original Data, Data File = pt2 vt.bi']);
    xlabel('Time [seconds]');
    ylabel('Amplitude [microV]');
  subplot(2,1,2)
    plot(rho_start:rho_end, autocorr_direct_vt_bi(rho_start:rho_end));
    hold on 
    plot(rho_start:rho_end, autocorr_hybrid_vt_bi(rho_start:rho_end), 'g');
    hold on
    plot(rho_start:rho_end, autocorr_m_hybrid_vt_bi(rho_start:rho_end), 'r');
    hold on
    plot(rho_start:rho_end, autocorr_relative_vt_bi(rho_start:rho_end), 'y');
    xlabel('Lag');
    ylabel('Normalized Autocorrelation a.u.');
    legend('Direct','Hybrid Sign','Modified Hybrid Sign','Relative Magnutude');
    title({['Normalized Autocorrelation, ' ...
       '(Direct) peak = ' num2str(peak_direct_vt_bi) ' at lag ' num2str(index_direct_vt_bi)]; ...
       ['(hybrid sign) peak = ' num2str(peak_hybrid_vt_bi) ' at lag ' num2str(index_hybrid_vt_bi)]; ...
       ['(m hybrid sign) peak = ' num2str(peak_m_hybrid_vt_bi) ' at lag ' num2str(index_m_hybrid_vt_bi)]; ...
       ['(relative) peak = ' num2str(peak_relative_vt_bi) ' at lag ' num2str(index_relative_vt_bi)]});

%% vf pa
[autocorr_direct_vf_pa, peak_direct_vf_pa, index_direct_vf_pa] = ...
    Primer1_IIciklus(vf_pa_EKG, 'pt2 vf.pa', 1, length(vf_pa_EKG) - 1, ...
                     16, 64, 'direct');
[autocorr_hybrid_vf_pa, peak_hybrid_vf_pa, index_hybrid_vf_pa] = ...
    Primer1_IIciklus(vf_pa_EKG, 'pt2 vf.pa', 1, length(vf_pa_EKG) - 1, ...
                     16, 64, 'hybrid sign');
[autocorr_m_hybrid_vf_pa, peak_m_hybrid_vf_pa, index_m_hybrid_vf_pa] = ...
    Primer1_IIciklus(vf_pa_EKG, 'pt2 vf.pa', 1, length(vf_pa_EKG) - 1, ...
                     16, 64, 'modified hybrid sign');
[autocorr_relative_vf_pa, peak_relative_vf_pa, index_relative_vf_pa] = ...
    Primer1_IIciklus(vf_pa_EKG, 'pt2 vf.pa', 1, length(vf_pa_EKG) - 1, ... 
                     16, 64, 'relative magnitude');

figure
  subplot(2,1,1)
    plot(vf_pa_EKG);
    title(['Original Data, Data File = pt2 vf.pa']);
    xlabel('Time [seconds]');
    ylabel('Amplitude [microV]');
  subplot(2,1,2)
    plot(rho_start:rho_end, autocorr_direct_vf_pa(rho_start:rho_end));
    hold on 
    plot(rho_start:rho_end, autocorr_hybrid_vf_pa(rho_start:rho_end), 'g');
    hold on
    plot(rho_start:rho_end, autocorr_m_hybrid_vf_pa(rho_start:rho_end), 'r');
    hold on
    plot(rho_start:rho_end, autocorr_relative_vf_pa(rho_start:rho_end), 'y');
    xlabel('Lag');
    ylabel('Normalized Autocorrelation a.u.');
    legend('Direct','Hybrid Sign','Modified Hybrid Sign','Relative Magnutude');
    title({['Normalized Autocorrelation, ' ...
         '(Direct) peak = ' num2str(peak_direct_vf_pa) ' at lag ' num2str(index_direct_vf_pa)]; ...
         ['(hybrid sign) peak = ' num2str(peak_hybrid_vf_pa) ' at lag ' num2str(index_hybrid_vf_pa)]; ...
         ['(m hybrid sign) peak = ' num2str(peak_m_hybrid_vf_pa) ' at lag ' num2str(index_m_hybrid_vf_pa)]; ...
         ['(relative) peak = ' num2str(peak_relative_vf_pa) ' at lag ' num2str(index_relative_vf_pa)]});

%% vf bi
[autocorr_direct_vf_bi, peak_direct_vf_bi, index_direct_vf_bi] = ...
    Primer1_IIciklus(vf_bi_EKG, 'pt2 vf.bi', 1, length(vf_bi_EKG) - 1, ...
                     16, 64, 'direct');
[autocorr_hybrid_vf_bi, peak_hybrid_vf_bi, index_hybrid_vf_bi] = ...
    Primer1_IIciklus(vf_bi_EKG, 'pt2 vf.bi', 1, length(vf_bi_EKG) - 1, ...
                     16, 64, 'hybrid sign');
[autocorr_m_hybrid_vf_bi, peak_m_hybrid_vf_bi, index_m_hybrid_vf_bi] = ...
    Primer1_IIciklus(vf_bi_EKG, 'pt2 vf.bi', 1, length(vf_bi_EKG) - 1, ...
                     16, 64, 'modified hybrid sign');
[autocorr_relative_vf_bi, peak_relative_vf_bi, index_relative_vf_bi] = ...
    Primer1_IIciklus(vf_bi_EKG, 'pt2 vf.bi', 1, length(vf_bi_EKG) - 1, ... 
                     16, 64, 'relative magnitude');
                     
figure
  subplot(2,1,1)
    plot(vf_bi_EKG);
    title(['Original Data, Data File = pt2 vt.pa']);
    xlabel('Time [seconds]');
    ylabel('Amplitude [microV]');
  subplot(2,1,2)
    plot(rho_start:rho_end, autocorr_direct_vf_bi(rho_start:rho_end));
    hold on 
    plot(rho_start:rho_end, autocorr_hybrid_vf_bi(rho_start:rho_end), 'g');
    hold on
    plot(rho_start:rho_end, autocorr_m_hybrid_vf_bi(rho_start:rho_end), 'r');
    hold on
    plot(rho_start:rho_end, autocorr_relative_vf_bi(rho_start:rho_end), 'y');
    xlabel('Lag');
    ylabel('Normalized Autocorrelation a.u.');
    legend('Direct','Hybrid Sign','Modified Hybrid Sign','Relative Magnutude');
    title({['Normalized Autocorrelation, ' ...
         '(Direct) peak = ' num2str(peak_direct_vf_bi) ' at lag ' num2str(index_direct_vf_bi)]; ...
         ['(hybrid sign) peak = ' num2str(peak_hybrid_vf_bi) ' at lag ' num2str(index_hybrid_vf_bi)]; ...
         ['(m hybrid sign) peak = ' num2str(peak_m_hybrid_vf_bi) ' at lag ' num2str(index_m_hybrid_vf_bi)]; ...
         ['(relative) peak = ' num2str(peak_relative_vf_bi) ' at lag ' num2str(index_relative_vf_bi)]});