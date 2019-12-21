%
%  this script implements the Pan Tompkins method for QRS detection
%
%
function beat = Pan_Tompkins_QRS(fajl, fs, start_ind, samples, alpha, N, fraction)
%
% load the data
%
  data = load(fajl);
  data = data(start_ind:start_ind+samples);
%
%  remove the baseline wander
%

  B = [(1+0.8)/2, -(1+0.8)/2];
  A = [1 , -0.8];
%
%  Now filter the signal
%
  x = filter(B,A,data);
%
%  normalize the signal
%
  n = floor(log(0.02)/log(alpha)+1);
  x = x/max(x(n:end));
%
% setup the lowpass filter
%
  B = cat(2, 1, zeros(1,5), -2, zeros(1,5), 1);
  A = cat(2, 1, -2, 1, zeros(1,10));
%
% lowpass filter the signal
%
  x1 = filter(B,A,x);
%
% setup the lowpass part of the highpass filter
%
  B = cat(2, 1, zeros(1,31), -1);
  A = cat(2, 1, -1, zeros(1,31));
%
% lowpass filter the signal
%
  x2 = filter(B,A,x1);
%
  p = zeros(length(x1),1);
  p(16:end) = x1(1:end-15)-(1/32)*x2(16:end);
%
%  now do the differentiation
%
  y = zeros(1, length(x));
  for i=1:length(p)
    y(i) = 2*p(i);
    if i > 4
      y(i) = y(i) - 2*p(i-4);
    end;
    if i > 3
      y(i) = y(i) - p(i-3);
    end;
    if i > 1
      y(i) = y(i) + p(i-1);
    end;
    y(i) = y(i) / 8;
  end;
%
%  square the result
%
  y2 = y.^2;
%
%  Now integrate
%
  N2 = length(y2);
%
  i = 1;
  while( i < N )
      yi(i) = (1/i)*sum(y2(1:i));
      yi(i) = sum(y2(1:i));
      i = i+1;
  end;
%
  for i = N:N2
      yi(i) = (1/N)*sum(y2(i-N+1:i));
      yi(i) = sum(y2(i-N+1:i));
  end;
%
%  Use the following code if using a simple threshold method
%  Find the first peaks in the time integrated vector

  blanking = 60; % the blanking period
  ii = blanking;
  index = 1;
  beat = [];
  threshold = fraction*max(yi);
 %
  while(ii < (N2-blanking))
      if (yi(ii) > threshold) % we have a beat
          beat(index) = ii;
          index = index+1;
          ii = ii + blanking;
      else
          ii = ii + 1;
      end;
  end;
  beat
%
% Now undo the delays in the filters
%
 delay = 5 + 16;
 beat = beat - delay;
%
%  get the time array
%
  time_x = [0:length(x)-1]/fs;
%
%  plot the original and filtered signal
%
  figure;
  orient landscape
  subplot(4,1,1); plot(time_x,x); grid;   
    xlabel('Time (sec)'); ylabel('x');% axis([0 max(time_x) -1 1]);
    title(['Ime fajla: ' fajl ', Pan Tompkins \alpha = ' num2str(alpha) ', N = ' num2str(N) ', fraction - ' num2str(fraction)]);
  subplot(4,1,2); plot(time_x,p); grid; 
    xlabel('Time (sec)'); ylabel('p'); 
  subplot(4,1,3); plot(time_x,y); grid; 
    xlabel('Time (sec)'); ylabel('dp/dt');
  subplot(4,1,4); plot(time_x,yi,'-',time_x,threshold*ones(1,length(yi)),'--'); grid; 
    xlabel('Time (sec)'); ylabel('integrated');
  figure;
  
  orient landscape
  subplot(2,1,1); plot(time_x,yi,'-',beat/fs,yi(beat),'s'); grid; 
    xlabel('Time (sec)'); ylabel('integrated');
     title(['Ime fajla:' fajl ', Pan Tompkins \alpha = ' num2str(alpha) ', N = ' num2str(N) ', fraction - ' num2str(fraction)]);
  subplot(2,1,2); plot(time_x,data,'-',beat/fs,data(beat),'s'); grid;
  xlabel('Time (sec)');