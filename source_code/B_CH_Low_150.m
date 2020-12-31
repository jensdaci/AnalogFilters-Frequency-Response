clear;
clc;

% Butterworth Filter -----------------------------------------------
N = 6;                       % Filter Order
wo = 2 * pi * 150 * 10^3;    % Cutoff Frequency

Q1 = 1.9320;
Q2 = 0.7071;
Q3 = 0.5176;

HButterworth1 = tf([wo^2], [1 wo/Q1 wo^2]);
HButterworth2 = tf([wo^2], [1 wo/Q2 wo^2]);
HButterworth3 = tf([wo^2], [1 wo/Q3 wo^2]);

HButterworth = HButterworth1 * HButterworth2 * HButterworth3;

% Chebyshev Filter ------------------------------------------------
wp = 2 * pi * 150 * 10^3;    % Cutoff Frequency

wo1 = 0.9771 * wp;
wo2 = 0.7224 * wp;
wo3 = 0.2980 * wp;

Q1 = 12.7893;
Q2 = 3.4600;
Q3 = 1.0441;

HChebyshev1 = tf([0.8909*wo1^2], [1 (wo1/Q1) wo1^2]);
HChebyshev2 = tf([0.8909*wo2^2], [1 (wo2/Q2) wo2^2]);
HChebyshev3 = tf([0.8909*wo3^2], [1 (wo3/Q3) wo3^2]);

HChebyshev = HChebyshev1 * HChebyshev2 * HChebyshev3;

%-----------------------------------------------------------------
opts = bodeoptions('cstprefs');
opts.MagVisible = 'on';
opts.PhaseVisible = 'off'; 
opts.FreqUnits = 'Hz';
opts.Grid = 'on';
opts.YlimMode = 'manual';
opts.Ylim = [-50, 5];         % For the magnitude response
%opts.Ylim = [-550, 10];      % For the phase response
opts.XlimMode = 'manual';
opts.Xlim = [1e2, 10e6];
opts.Title.String = '6th Order - Lowpass - [150 kHz]';
opts.Title.FontSize = 12;
opts.Title.FontWeight = 'Bold';
opts.XLabel.FontSize = 12;
opts.XLabel.FontWeight = 'Bold';
opts.YLabel.FontSize = 12;
opts.YLabel.FontWeight = 'Bold';
opts.TickLabel.FontSize = 12;
opts.TickLabel.FontWeight = 'Bold';

bodeplot(HButterworth, HChebyshev, opts)
legend('Butterworth', 'Chebyshev')