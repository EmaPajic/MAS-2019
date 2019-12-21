%% 4. zad a)

x = ecg(500).';
y = sgolayfilt(x,0,5);  
figure
    plot(1:length(y), y);
        xlabel('a.u.');
        ylabel('Milivolts[mV]');

%% 4. zad b)
        
[b, a] = butter(5,1/3);
x=[zeros(1,15), 10*ones(1,10), zeros(1,15)];
figure
subplot(121);
  plot(sgolayfilt(x),"r;sgolay(3,5);",...
      filtfilt(ones(1,5)/5,1,x),"g;5 sample average;",...
      filtfilt(b,a,x),"c;order 5 butterworth;",...
      x,"+b;original data;");
  axis([1 40 -2 15]);
  title("boxcar");

  x=x+randn(size(x))/2;
  subplot(122);
  plot(sgolayfilt(x,3,5),"r;sgolay(3,5);",...
      filtfilt(ones(1,5)/5,1,x),"g;5 sample average;",...
      filtfilt(b,a,x),"c;order 5 butterworth;",...
      x,"+b;original data;");
  axis([1 40 -2 15]);
  title("boxcar+noise");
