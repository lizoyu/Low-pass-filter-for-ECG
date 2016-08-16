wp = 0.9*pi;    % Effective passband cutoff frequency
wt = 1*pi;      % Stopband cutoff frequency???
wc = wp;        % Passband cutoff frequency??                                     
alpha =1;       % Maximum attenuation of passband cutoff?
beta =15;       % Minimum attenuation of stopband cutoff?

% Calculation of order N
A = sqrt(10^(alpha/10)-1);               			
B = sqrt(10^(beta/10)-1);
N = acosh(B/A)/acosh(wt/wc);
N = ceil(N);

% Calculate the numerator and denominator of filter
[b,a] = cheby1(N,alpha,wp, 's');
[bz,az] = impinvar(b,a);
%H = dsp.IIRFilter('Numerator',bz,'Denominator',az);
%fvtool(H)
y = filter(bz, az, ECG);

% Plot
plot(Elapsedtime, y, 'r')
hold on
plot(Elapsedtime, ECG)
hold off
title('ECG')
legend('Filtered','Original')
xlabel('Elapsed time/s')
ylabel('Magnitude')