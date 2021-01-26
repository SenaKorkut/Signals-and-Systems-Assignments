clc 
clear 
close all 
prompt = "Hello! Choose your pulse for D-C conversion:"; prompt = prompt + newline + 
         "1-Standard square pulse"; prompt = prompt + newline + 
         "2-Standard triangular pulse"; prompt = prompt + newline + 
         "3-Pulse consisting of three parabolic segments"; prompt = prompt + newline + 
         "4-Truncated ideal pulse" + newline; 
choice = input(prompt); 
prompt_period = "Enter the sampling period: " + newline; 
T_s = input(prompt_period); % sampling period Ts F_s = 1/T_s; 
%sampling frequency fs 
if (choice == 1) 
  pulse = @(t, T_s) rectangularPulse(-T_s/2, T_s/2, t); 
end 
if(choice == 2) 
  pulse = @(t, T_s) triangularPulse(-T_s, T_s, t); 
 end 
if (choice == 3) 
  pulse = @(t, T_s) ((-2*T_s < t) & (t <=2*T_s)).*(sinc(t/T_s)); 
end 
if(choice == 4) 
  pulse = @(t, T_s) ((-3*T_s < t) & (t <= 3*T_s)).*(sinc(t/T_s)); 
end
%Create signal for part a 
n_a=-3:6; 
yn_a = [2,-1,0,7,0,3,0,-3,0,3]; 
% stem (n_a, yn_a) % xlabel('n values'); 
% ylabel('y[n] values'); 
% title('Discrete Data Values of Function y[n]'); 
%Create signal for part b n_b = -12:12; 
yn_b = 10*exp(-abs(n_b)/4); 
% stem (n_b, yn_b) 
% xlabel('n values'); 
% ylabel('y[n] values'); 
% title('Discrete Data Values of Function y[n]');
prompt_example = "Enter example a, b or c: " + newline; 
example = input(prompt_example, 's'); t = -12:0.001:12; 
if( example == 'a') 
  rc = zeros(length(yn_a),length(t)); 
  for n = n_a 
    rc(n+4, :) = yn_a(n+4)*pulse(t-n*T_s, T_s); 
  end 
plot(t, sum(rc), 'color', 'b');
hold on 
legend('reconstructed waveform'); 
stem(n_a,yn_a, 'LineStyle', '--', 'Color','red', 'MarkerSize',2);hold off xlabel('time-t'); 
ylabel('value-y(t)'); 
title('Discrete Time Sequence vs Reconstructed Waveform'); 
legend('reconstructed waveform'); 
grid 
end
if ( example == 'b') 
  rc = zeros(length(yn_b),length(t)); 
  for n = n_b 
    rc(n+13, :) = yn_b(n+13)*pulse(t-n*T_s, T_s); 
  end 
  plot(t, sum(rc), 'color', 'b');hold on stem(n_b,yn_b, 'LineStyle', '--', 'Color','red', 'MarkerSize',2);hold off xlabel('time-t'); ylabel('value-y(t)'); title('Discrete Time Sequence and Reconstructed Waveform'); legend({'reconstruction','discrete sequence'}); grid end
if ( example == 'c') 
  pulse_3 = @(t, T_s) ((-3*T_s <= t) & (t <= 3*T_s)).*(sinc(t/T_s)); 
  pulse_5 = @(t, T_s) ((-5*T_s <= t) & (t <= 5*T_s)).*(sinc(t/T_s)); 
  %For Part A rc_3 = zeros(length(yn_a),length(t)); 
  for n = n_a 
    rc_3(n+4, :) = yn_a(n+4)*pulse_3(t-n*T_s, T_s); 
  end 
  rc_5 = zeros(length(yn_a),length(t)); 
  for n = n_a 
    rc_5(n+4, :) = yn_a(n+4)*pulse_5(t-n*T_s, T_s);
  end 
  figure 
  plot(t, sum(rc_3),'b' , t, sum(rc_5), 'm'); legend({'truncated at 3Ts','truncated at 5Ts'}); 
  xlabel('time-t'); 
  ylabel('value-y(t)'); 
  title('Truncated Ideal Pulse Reconstruction Truncated at 3Ts vs 5Ts'); 
  %legend('truncated at 3Ts','truncated at 5Ts'); 
  grid %For Part B rc_3 = zeros(length(yn_b),length(t)); 
  for n = n_b 
    rc_3(n+13, :) = yn_b(n+13)*pulse_3(t-n*T_s, T_s); 
  end rc_5 = zeros(length(yn_b),length(t)); 
  for n = n_b 
    rc_5(n+13, :) = yn_b(n+13)*pulse_5(t-n*T_s, T_s); 
  end 
  figure; 
  plot(t, sum(rc_3), 'b',t, sum(rc_5), 'm') 
  legend({'truncated at 3Ts','truncated at 5Ts'}); 
  xlabel('time-t'); 
  ylabel('value-y(t)'); 
  title('Truncated Ideal Pulse Reconstruction Truncated at 3Ts vs 5Ts'); 
  grid 
  end
