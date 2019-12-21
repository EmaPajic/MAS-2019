% 2. primer, II ciklus, primer i zadatak za rad
close all; clear all; clc;

while (1 == 1)
  izbor = menu('PRIMER II CILUS II', 'izaberite signal', 'slika signala', ...
      '1. filter bazne linije', '2. MA filter signala', 'slika OBRADA', ...
      'sacuvati sliku OBRADA', 'odstampati sliku OBRADA', ...
      'sacuvati filtriran signal', 'prikaz bazne linije', 'kraj');
%--------------------------------------------------------------------------
if (izbor == 1) % ucitavanje signala iz fajla
    [file] = uigetfile('*.txt', 'Ucitajte signal po izboru');
    fid = fopen(file, 'r'); % otvara se fajl za citanje - 'r'
    % cita se tekstualni fajl sa podacima tipa floating point ('f'):
    [s, broj] = fscanf(fid, '%f');
    fclose(fid);

    disp(['Broj ucitanih odbiraka je ' num2str(broj)]);
    start = input('\nUnesite pocetni odbirak ' , 's');
    start = str2double(start);
  
    samples = input('\nUnesite broj odbiraka ' , 's');
    samples = str2double(samples);
  
    x = s( start:(start + samples) );
    N = length(x);
  
    fs = input('\nUnesite fs u Hz (1000 za 6.txt; 200 za 7.txt) ' , 's');
    fs = str2double(fs);
    time = (0:N-1)/fs;
    st = start/fs; % pocetni trenutak izdvojenog signala
    samp = (start+samples)/fs; % kraj izdvojenog signala
    
    % racunanje frekvencijskih karakteristika signala
    f = (fs/N)*((-N/2+1):(N/2));
    xx = abs(fft(x));
    xxfreqshift = fftshift(xx);
  
end
%--------------------------------------------------------------------------
if (izbor == 2) % prikaz signala
    clf
    subplot(2,1,1);
        plot(time,x);
            xlabel('vreme [s]');
            ylabel(['EKG signal  ' num2str(file)]);
            title(['signal izdvojen od ' num2str(st) ' do '...
                num2str(samp) ' [s]']); 
    subplot(2,1,2); 
        plot(f, xxfreqshift);
          xlabel('frekvencija [hz]');
          ylabel('Spektar EKG signala [a.u.]');
           title('Spektar EKG signala sa slike iznad');
    pause
    close
end
%--------------------------------------------------------------------------
if (izbor == 3) % filter bazne linije

    alpha = input('\nUnesite pol filtra (<= 1) ' , 's');
    alpha = str2double(alpha);
    % primena filtra za odstranjivanje bazne linije
    % definisanje a i b parametara
    a = [1 , -alpha];
    b = [(1+alpha/2) , -(1+alpha/2)];
    % filtriranje signala
    p = filter(b, a, x);

    % frekvencijski odziv filtra
    [H1, Omega] = freqz(b, a);
    Fr = 0.5 * fs * Omega / pi;
    clf
    figure(1);
        plot(Fr, abs(H1), 'g-', 'Linewidth', 1); hold on;
            grid;
            title(['pol 1.filtra = ' num2str(alpha) ]);
            xlabel('frekvencija [Hz]');
            ylabel('|H_1(e^{j})|');
    pause

    pp = abs(fft(p));
    ppfreqshift = fftshift(pp);
    clf
    figure(2);
        subplot(2,1,1);
            plot(time, x, time, p, 'g');
                grid;
                xlabel('vreme [s]');
                ylabel(['EKG signal  ' num2str(file)]);
                title(['za pol 1. filtra = ' num2str(alpha) ]);
                legend('originalni', 'odstranjena bazna linija'); 
        subplot(2,1,2);
            plot(f, ppfreqshift, 'g');
                title(['spektar filtriranog EKG signala ' num2str(file)]);
                xlabel('ucestanost [Hz]');
                axis([-200 200 0 max(ppfreqshift)]);
    pause
    close
    close
end
%--------------------------------------------------------------------------
if (izbor == 4) % MA filter signala
    % implementiranje MA filtra
    order = input('\nUnesite red MA filtra ', 's');
    order = str2double(order);
    aM = [1 zeros(1,order-1)];
    bM = ones(1,order)/order;

    % filtriranje signala
    y = filter(bM, aM, p);
    filtriranEKG = y;
    save filtriranEKG;

    % frekvencijski odziv
    [H2, Omega] = freqz(bM, aM);
    Fr = 0.5 * fs * Omega / pi;
    clf
    figure(1);
        plot(Fr, abs(H2), 'r-', 'Linewidth', 1); hold on;
            grid;
            title(['red 2. filtra = ' num2str(order) ]);
            xlabel('frekvencija [Hz]');
            ylabel('|H_2(e^{j})|');
            
    pause
    clf
    figure(2);
        subplot(2,1,1);
            plot(time, x, time, y, 'r');
                grid;
                xlabel('vreme [s]');
                ylabel(['EKG signal ' num2str(file)]);
                title(['pol 1. filtra = ' num2str(alpha) ...
                    ' red 2.filtra (MA) = ', num2str(order) ]);
                legend('originalni', 'filtriran');  
                 
    yy = abs(fft(filtriranEKG));
    yyfreqshift = fftshift(yy);

    subplot(2,1,2);
        plot(f, yyfreqshift, 'r');
            title(['spektar filtriranog EKG signala ' num2str(file)]);
            xlabel('ucestanost [Hz]');
            axis([-200 200 0 max(yyfreqshift)]);
    pause
    close
    close
end
%--------------------------------------------------------------------------
if (izbor == 5) % prikaz
    clf
    figure(1);                                                                                                                                                  
        orient tall;
        subplot(3,1,1); % originalni signal
          plot(time,x);
              xlabel('vreme [s]');
              ylabel(['EKG signal  ' num2str(file)]);
              title(['signal izdvojen od ' num2str(st) ' do '...
                  num2str(samp) ' [s]']); 
        subplot(3,1,2); % odstranjena bazna linija
          plot(time, p);
                xlabel('vreme [s]');
                ylabel(['EKG signal  ' num2str(file)]);
                title(['za pol 1. filtra = ' num2str(alpha) ]); 
        subplot(3,1,3); % potisnut sum
          plot(time, y, 'r');
                xlabel('vreme [s]');
                ylabel(['EKG signal ' num2str(file)]);
                title(['pol 1. filtra = ' num2str(alpha) ...
                    ' red 2.filtra (MA) = ', num2str(order) ]);
    hold on;
    pause
    %clf
    figure(2);
        orient tall;
        subplot(3,1,1); % frekvencijski odziv 1. filtra
          plot(Fr, abs(H1), 'g-', 'Linewidth', 1); hold on;
            grid;
            title(['pol 1.filtra = ' num2str(alpha) ]);
            xlabel('frekvencija [Hz]');
            ylabel('|H_1(e^{jOmega})|');
        subplot(3,1,2); % frekvencijski odziv 2. filtra
          plot(Fr, abs(H2), 'r-', 'Linewidth', 1); hold on;
            grid;
            title(['red 2. filtra = ' num2str(order) ]);
            xlabel('frekvencija [Hz]');
            ylabel('|H_2(e^{jOmega})|');
        subplot(3,1,3); % spektar originalnog i filtriranog signala
          plot(f, xxfreqshift, f, yyfreqshift, 'r');
            title(['spektar filtriranog i obicnog EKG signala ' num2str(file)]);
            xlabel('ucestanost [Hz]');
            axis([-200 200 0 max(yyfreqshift)]);
            legend('originalni', 'filtriran');
    pause
 end
%--------------------------------------------------------------------------
if (izbor == 6)
% cuva slike EKG signal.jpeg i SPEKTAR.jpg u trenutnom radnom direktorijumu
    print(figure(1), '-djpeg', 'EKG signal.jpg')
    pause
    print(figure(2), '-djpeg', 'SPEKTAR.jpg')
    pause
    close
    close
end
%--------------------------------------------------------------------------
if (izbor == 7) % stampa sliku OBRADA.jpeg
    print(figure(1), '-dwinc', 'EKG signal.pdf')
    pause
    print(figure(2), '-djpeg', 'SPEKTAR.pdf')
    pause
    close
end
%--------------------------------------------------------------------------
if (izbor == 8) % cuva se filtriran signal
    load filtriranEKG; % mat format
    fid = fopen('filtriran EKG.doc','a'); % word dokument
    fprintf(fid, ['\nfiltriran EKG signal ', num2str(file), '\n']);
    fprintf(fid, '\n');
    fprintf(fid, '%8.2f  \n', y');
    fclose(fid);
    
    fid = fopen('filtriran EKG.txt', 'a');  % txt file (Word pad)
    fprintf(fid, ['\nfiltriran EKG signal ', num2str(file), '\n']);
    fprintf(fid, '\n');
    fprintf(fid, '%8.2f  \n', y');
    fclose(fid);
    
    pause
    close
end
%--------------------------------------------------------------------------
if (izbor == 9)
    figure
        plot(time, x, time, x - p, 'g');
            grid;
            xlabel('vreme [s]');
            ylabel(['EKG signal  ' num2str(file)]);
            title(['za pol 1. filtra = ' num2str(alpha) ]);
            legend('originalni signal', 'bazna linija');
return
end
%--------------------------------------------------------------------------
if (izbor == 10)
    clc
    close
    clear
return
end
%--------------------------------------------------------------------------
end