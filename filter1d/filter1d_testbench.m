%% Test Bench for filter1d.m

T = 2;
dt = 0.001;
N = T/dt+1;
sample_time = 0:dt:T;

df = 1/dt;
sample_freq = linspace(-1/2,1/2,N).*df;

% input signal with noise
x_in = cos(2.*pi.*(sample_time).*(1+(sample_time).*75)).';

% filter coefficients
h1 = -0.1339; h2 = -0.0838; h3 = 0.2026; h4 = 0.4064;

len = length(x_in);
y_out = zeros(1,len);
x_out = zeros(1,len);

for n=1:len
    data = x_in(n);
    [y_out(n), x_out(n)] = filter1d(data, h1, h2, h3, h4);
end

figure('Name', '1D Filter Plot');
subplot(3,1,1);
plot(1:len,x_in,'-b');
xlabel('Time (ms)')

ylabel('Amplitude')
title('Chirp Signal (noisy input)')

subplot(3,1,2); plot(1:len,y_out,'-b');
xlabel('Time (ms)')
ylabel('Amplitude')
title('Output Signal (filtered)')

freq_fft = @(x) abs(fftshift(fft(x)));

subplot(3,1,3); semilogy(sample_freq,freq_fft(x_in),'-b');
hold on
semilogy(sample_freq,freq_fft(y_out),'-r')
hold off
xlabel('Frequency (Hz)')
ylabel('Amplitude (dB)')
title('Input and Output Signals (Frequency domain)')
legend({'FilterIn', 'FilterOut'}, 'Location','South')
axis([-500 500 1 100])
