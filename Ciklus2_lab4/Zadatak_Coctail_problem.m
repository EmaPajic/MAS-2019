    close all;
    clear all;
    clc;
%
% Ucitavanje miksovanih signala iz WAV formata u matricu
%    
    mix1 = wavread('110101000mix1.wav');
    mix2 = wavread('110101000mix2.wav');
    mix3 = wavread('110101000mix3.wav');
    mix4 = wavread('110101000mix4.wav');
    x = [mix1 mix2 mix3 mix4]';
    
%% algoritmi

%%%%%%%%%%%%%%%%%%%%%%%%%%%% ROBUST ICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Termination Threshold Parameter
    ttp = 1e-3;
% Maximum number of iterations per independent component
    max_it = 1000;
% regression-based deflation
    [y_robustICA, H_robustICA] = robustica(x, [], ttp, max_it, 1, 'r', 0, [], 0);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SOBI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [H_SOBI,y_SOBI] = acsorbiro(x,size(x,1),100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% JADE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    H_JADE = jadeR(x,size(x,1)); 
    y_JADE = H_JADE*x; 
    y_JADE = real(y_JADE);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [y_CCA,H_CCA,r] = ccabss_test_cc(x);
    y_CCA = real(y_CCA);

%% izvorne komponente u WAV formatu za svaki od algoritama
%
% robust ICA metoda
%
    wavwrite(y_robustICA(1,:),'ICA_1.wav');
    wavwrite(y_robustICA(2,:),'ICA_2.wav');
    wavwrite(y_robustICA(3,:),'ICA_3.wav');
    wavwrite(y_robustICA(4,:),'ICA_4.wav');
%
% SOBI metoda
%
    wavwrite(y_SOBI(1,:),'SOBI_1.wav');
    wavwrite(y_SOBI(2,:),'SOBI_2.wav');
    wavwrite(y_SOBI(3,:),'SOBI_3.wav');
    wavwrite(y_SOBI(4,:),'SOBI_4.wav');
%
% JADE metoda
%
    wavwrite(y_JADE(1,:),'JADE_1.wav');
    wavwrite(y_JADE(2,:),'JADE_2.wav');
    wavwrite(y_JADE(3,:),'JADE_3.wav');
    wavwrite(y_JADE(4,:),'JADE_4.wav');
%
% CCA metoda
%
    wavwrite(y_CCA(1,:),'CCA_1.wav');
    wavwrite(y_CCA(2,:),'CCA_2.wav');
    wavwrite(y_CCA(3,:),'CCA_3.wav');
    wavwrite(y_CCA(4,:),'CCA_4.wav');