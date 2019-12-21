%
%  This  routine computes the autocorrelation of the bipolar and 
%  patch channels for ventricular fibrillation and ventricular tachycardia
%
%  name = name of the data file
%  start = starting index
%  samples = number of samples to examine
%
function [autocorr,peak_direct,index_direct] = Primer1_IIciklus(s,name,start,samples,rho_start,rho_end,method);
%
%
% the sampling rate for this data is 125 Hz
%
  fs = 125;   
  
%  get our data segment
%
  x = s(start:start+samples);
  N = length(x);
  time = [0:N-1] / fs;
  
%
%  Compute the normalized autocorrelation
  if strcmp(method, 'direct')
    rho = directAutocorr(name,x,N,time,rho_start,rho_end);
  elseif strcmp(method,'hybrid sign')
    rho = hybridSignAutocorr(name,x,N,time,rho_start,rho_end);
  elseif strcmp(method, 'modified hybrid sign')
    rho = modHybridSignAutocorr(name,x,N,time,rho_start,rho_end);
  elseif strcmp(method, 'relative magnitude')
    rho = relativeMagnitudeAutocorr(name,x,N,time,rho_start,rho_end);
  end 
  autocorr = rho;
  [peak_direct, index_direct] = max(rho);
  peak_direct = peak_direct(1);
  index_direct = index_direct(1); 
%
% Plot the results
%  figure
%    subplot(2,1,1)
%      plot(x);
%      title(['Original Data, Interval = ' num2str(N/fs) ' seconds, Data File = ' name]);
%      xlabel('Time [seconds]');
%      ylabel('Amplitude [microV]');
%    subplot(2,1,2)
%      plot(rho_start:rho_end, rho(rho_start:rho_end));
%      hold on 
%      plot(index_direct, peak_direct);
%      hold off;
%      title(['Normalized Autocorrelation, (' method ') peak = ' num2str(peak_direct) ' at lag ' num2str(index_direct)]);
%      xlabel('Lag');
%      ylabel('Normalized Autocorrelation a.u.');
      
  
function rho = directAutocorr(name,x,N,time,rho_start,rho_end);
   
  rho = zeros(rho_end + 1);
  for k = rho_start : rho_end
    ro_k_up = sum(x(1:N-k).*x(k+1:N));
    ro_k_down = sqrt(sum(x(1:N-k).^2)).*sqrt(sum(x(k+1:N).^2));
    ro = ro_k_up / ro_k_down;
    rho(k) = ro;
  end 

function rho = hybridSignAutocorr(name,x,N,time,rho_start,rho_end);
   
  rho = zeros(rho_end + 1);
  for k = rho_start : rho_end
    ro_k_up = sum(sign(x(1:N-k).*x(k+1:N)).*abs(x(1:N-k)));
    ro_k_down = sum(abs(x(1:N-k)));
    ro = ro_k_up / ro_k_down;
    rho(k) = ro;
  end 

     
function rho = modHybridSignAutocorr(name,x,N,time,rho_start,rho_end);
   
  rho = zeros(rho_end + 1);
  for k = rho_start : rho_end
    ro_k_up = sum(sign(x(1:N-k).*x(k+1:N)).*((abs(x(1:N-k))).+abs(x(k+1:N))));
    ro_k_down = sum(abs(x(1:N-k)).+abs(x(k+1:N)));
    ro = ro_k_up / ro_k_down;
    rho(k) = ro;
  end 
  
  
function rho = relativeMagnitudeAutocorr(name,x,N,time,rho_start,rho_end);
   
  rho = zeros(rho_end + 1);
  for k = rho_start : rho_end
    min_sum = sum(sign(x(1:N-k).*x(k+1:N)).*min(abs(x(1:N-k)),abs(x(k+1:N))));
    max_sum = sum(max(abs(x(1:N-k)),abs(x(k+1:N))));
    ro_k_up = 2*min_sum*max_sum;
    ro_k_down = max_sum*max_sum+min_sum*min_sum;
    ro = ro_k_up / ro_k_down;
    rho(k) = ro;
  end 
