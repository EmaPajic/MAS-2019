function y = bpf(low, high, sr, dt, domain, sb)
% function - bandpass filter 
% y = bpf(low, high, sr, dt, domain, sb)
%
% Applies a bandpass or stopband filter to a given set of data in the time or frequency domain
%     low - low cutoff frequency, in Hz
%     high - high cutoff frequency, in Hz
%     sr - number of samples per second
%     dt - vector of data points in the time or frequency domain
%     domain - the char 't' or 'f', corresponding to time or frequency domain, respectively
%     sb - stopband (1) or bandpass (0)
%
% Returns the filtered signal in the same domain as dt
%
% Created: 11 November 2004: Devin Fensterheim

if nargin == 5 sb = 0; end
freq = sr*(0:2500/2)/2500;
if (domain == 't')
    z = fft(dt);
else
    z = dt;
end
if (sb == 0)
    z(find((freq < low)|(freq > high))) = 0;
else
    z(find(freq > low & freq < high)) = 0;
end

if (domain == 't')
    y = real(ifft(z));
elseif (domain == 'f')
    y = z;
end