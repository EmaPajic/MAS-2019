% Ema Pajic, lab1

%problem 3

pkg load signal 

function EmaPajicLab1()
  
  problem_3()
  problem_4()
  
endfunction

function problem_3()
  k = 0:100;
  x = 100 * sin(k*pi/2 + pi);
  b = [1 1];
  a = [4 -2];

  y = filtfilt(b,a,x);

  figure(1)
    plot(k, x, 'g')
    hold on
    plot(k, y, 'r')
    hold off
      title('3. zadatak')
      xlabel('Time [s]')
      ylabel('Signal [a.u.]')
      legend('Nefiltrirani signal', 'Filtrirani signal')
    
endfunction

function data = read_data()
  txt_file = "EMG.txt"
  file = fopen(txt_file, 'r');
  data = fscanf(file, '%f', [16 77063]);
endfunction

function problem_4()
  data = read_data();
  
  [b_butter, a_butter] = butter(3, 5/500, 'high');
  y_butter = filtfilt(b_butter, a_butter, data(1,:));
  [b_notch, a_notch] = pei_tseng_notch(50/500, 50/35/500);
  y = filtfilt(b_notch, a_notch, y_butter);
  
  time = (0:1:77062) /1000;

  figure(2)
    plot(time, data(1,:), 'g')
    hold on
    plot(time, y, 'r')
    hold off
      title('EMG, 4. zadatak')
      xlabel('Time [s]')
      ylabel('EMG signal [V]')
      legend('Nefiltrirani signal', 'Filtrirani signal')
   
endfunction
