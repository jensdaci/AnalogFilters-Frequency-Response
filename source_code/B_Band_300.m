clear;
clc;

N = 6;                      % Filter Order
wo = 2 *pi * 300 * 10^3;    % Center Frequency

Q1 = 1.9320;
Q2 = 0.7071;
Q3 = 0.5176;

% Butterworth Filter
HButterworth1 = tf([wo/Q1 0], [1 0.5176*wo wo^2]);
HButterworth2 = tf([wo/Q2 0], [1 1.4142*wo wo^2]);
HButterworth3 = tf([wo/Q3 0], [1 1.9320*wo wo^2]);

HButterworth = HButterworth1 * HButterworth2 * HButterworth3;

opts = bodeoptions('cstprefs');
opts.MagVisible = 'on';
opts.PhaseVisible = 'off'; 
opts.FreqUnits = 'Hz';
opts.Grid = 'on';
opts.YlimMode = 'manual';
opts.Ylim = [-50, 5];         % For the magnitude response
%opts.Ylim = [-550, 10];      % For the phase response
opts.XlimMode = 'manual';
opts.Xlim = [1e3, 10e6];
opts.Title.String = '6th Order - Butterworth - Bandpass [300 kHz]';
opts.Title.FontSize = 12;
opts.Title.FontWeight = 'Bold';
opts.XLabel.FontSize = 12;
opts.XLabel.FontWeight = 'Bold';
opts.YLabel.FontSize = 12;
opts.YLabel.FontWeight = 'Bold';
opts.TickLabel.FontSize = 12;
opts.TickLabel.FontWeight = 'Bold';

bodeplot(HButterworth, opts)