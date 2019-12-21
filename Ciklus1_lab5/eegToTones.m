function eegToTones(eegdata,numTones,lowf,highf,win,shift,duration,filename)
%  eegToTones(eeg,numTones,lowf,highf,win,shift,duration,filename)
%
%  eeg:      1 x nSamples of EEG (or any) data
%  numTones: number of maximum amplitude tones to play for each window
%  lowf:     lowest frequency in eeg to map to audible range
%  highf:    highest frequency in eeg to map to audible range
%  win:      window size in eeg to apply FFT to
%  shift:    samples of eeg to shift window, coarseness of spectrogram
%  duration: seconds (or fraction of) to play tones for each window
%  filename: name of au file to store tones
%
%  Only first argument is required.
%
%  Example, with default values shown for all arguments.
%
%  eegToTones(eegdata{2,3,4}(1,:),3,5,20,512,10,10/256,'eegsound');
%  data{1}{4}(1,:)
%  by Chuck Anderson, Dept. of Commputer Science, Colorado State University
%  see http://www.cs.colostate.edu/eeg  for more information
%
%  This code may be copied, distributed, and modified, as long as
%  the author is credited. Also, if you publish this or any derived
%  code on the web, include a link to the above URL.

if nargin < 2, numTones = 3; end;
if nargin < 3, lowf = 5; end
if nargin < 4, highf = 20; end
if nargin < 5, win = 512; end
if nargin < 6, shift = 10; end
if nargin < 7, duration = shift / 256; end
if nargin < 8, filename = 'eegsound'; end

[signal,f] = myspecgram(eegdata,lowf,highf,win,shift); 
drawnow;
f = f';

frange = f([1 end]);
tonerange = [500 2000];  %audible range, matched to lowf:highf EEG range

maxsignal = max(signal(:));
scaled = signal / maxsignal;

Fs = 8000;
seconds = duration;

nwinners = numTones;
freqs = zeros(nwinners,size(signal,2));
amps =  zeros(nwinners,size(signal,2));
for col = 1:size(signal,2)
  [junk,order] = sort(-scaled(:,col));
  winners = order(1:nwinners);
  freqs(:,col) = f(winners);
  amps(:,col) = scaled(winners,col);
end

if 0
  figure(2);
  subplot(2,1,1);
  plot(freqs');
  subplot(2,1,2);
  plot(amps');
  figure(1);
  drawnow;
end
  
uniqfreqs = sort(unique(freqs(:)));
numUniqFreqs = length(uniqfreqs);
scaledFreqs = (uniqfreqs - frange(1))/(frange(2)-frange(1)) * ...
    (tonerange(2)-tonerange(1)) + tonerange(1);

%tones * [0:seconds] is outer product
tones = sin(2*pi/Fs * scaledFreqs * [0:(Fs*seconds*size(signal,2))]);
for col = 1:size(signal,2)
  toneCols = round((col-1)*Fs*seconds+1 : col*Fs*seconds);
  toneRows = zeros(1,numTones);
  for i = 1:size(freqs,1)
    toneRows(i) = find(uniqfreqs == freqs(i,col));
  end
  tones(toneRows,toneCols) = tones(toneRows,toneCols) .* ...
      repmat(amps(:,col),1,length(toneCols));
  tones(setdiff(1:numUniqFreqs,toneRows),toneCols) = 0.;
end

melody = sum(tones);
melody = melody / size(tones,1);

auwrite(melody',Fs,filename);
!play eegsound.au

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [signal,f] = myspecgram(eegdata,lowf,highf,win,shift)
% [signal,f] = myspecgram(eegdata,lowf,highf,win,shift)
%
% [signal,f] = myspecgram(eegdata,5,20,512,20);

signal = [];
n = length(eegdata);
for w = 1:shift:n-win

  [mag,f] = myfft(eegdata(w:w+win));

  if 0
    plot(f,mag);
    pause(0.2);
    drawnow;
  end
  signal = [signal mag'];
end

plotspecgram(signal,f,lowf,highf);
drawnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [mag,f] = myfft(eegdata)
Fs = 256;
Fn = Fs/2;

%see http://www.mathworks.com/support/tech-notes/1700/1702.shtml
NFFT = 2.^(ceil(log(length(eegdata))/log(2)));
z = fft(eegdata,NFFT);
NumUniquePts = ceil((NFFT+1)/2);
z = z(1:NumUniquePts);
z = abs(z);
z = z*2; %threw out half the points
z(1) = z(1)/2; %but not DC or Nyquist freq
if ~rem(NFFT,2)
  z(length(z)) = z(length(z)) / 2;
end
z = z/length(eegdata);
%now make frequency vector
f = (0:NumUniquePts-1)*2/NFFT;
% Multiply this by the Nyquist frequency 
% (Fn ==1/2 sample freq.)
f = f*Fn;

mag = z;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotspecgram(signal,f,lowf,highf)
% plotspecgram(signal,f,lowf,highf)

lowcut = find(f > lowf);
lowcut = lowcut(1);
highcut = find(f > highf);
highcut = highcut(1);
signal = signal(lowcut:highcut,:);
f = f(lowcut:highcut);
f = f';

imagesc(signal);
axis xy
yticks = get(gca,'YTick');
labels = cell(1,length(yticks));
for i = 1:length(yticks)
  labels{i} = num2str(f(yticks(i)),'%.1f');
end
set(gca,'YTickLabel',labels);
ylabel(['Freq from ' num2str(f(1)) ' to ' num2str(f(end)) ' Hz']);
xlabel('time [s]')
colorbar