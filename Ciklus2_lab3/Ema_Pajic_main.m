% 2. primer, II ciklus, primer i zadatak za rad
close all; clear all; clc;

while (1 == 1)
  izbor = menu('PRIMER 3 CIKLUS II', 'izaberite signal', 'prikaz signala', ...
      'unesite alpha', 'unesite N','unesite fraction', ...
      'pokrenite Pan Tompkins metodu', 'sacuvaj slike', 'kraj');
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
  
    fs = input('\nUnesite fs u Hz (200 za 7.txt; 200 za 8.txt) ' , 's');
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
if (izbor == 3) % unos alpha

    alpha = input('\nUnesite alpha ' , 's');
    alpha = str2double(alpha);
end
%--------------------------------------------------------------------------
if (izbor == 4) % unos N

    N = input('\nUnesite sirina prozora integracije ', 's');
    N = str2double(N);

 end
%--------------------------------------------------------------------------
if (izbor == 5) % unos fraction

  fraction = input('\nUnesite fraction (0<=fraction<=1) ', 's');
  fraction = str2double(fraction);
end
%--------------------------------------------------------------------------
if (izbor == 6) % pokrece pan tompkins
    beat = Pan_Tompkins_QRS(file, fs, start, samples, alpha, N, fraction)
end
%--------------------------------------------------------------------------
if (izbor == 7)
% cuva slike EKG signal.jpeg i SPEKTAR.jpg u trenutnom radnom direktorijumu
    print(figure(1), '-djpeg', 'PanTompkinsObrada.jpg')
    pause
    print(figure(2), '-djpeg', 'Rezultat.jpg')
    pause
    close
    close
end
%--------------------------------------------------------------------------
if (izbor == 8)
    clc
    close
    clear
return
end
%--------------------------------------------------------------------------
end