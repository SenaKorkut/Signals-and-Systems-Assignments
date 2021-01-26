clc
clear
close all
prompt ="Choose system to plot";
prompt = prompt+newline+"1-System A";
prompt = prompt+newline+"2-System B";
prompt = prompt+newline+"3-System C";
prompt = prompt+newline+"4-System D";
prompt = prompt+newline+"5-System E"+newline;
choice = input(prompt);
if (choice == 1)
    c = [1 1 0 0];
    d = [-1 1 0 0];
end
if (choice == 2)
    c = [0 -1 0 10]; 
    d = [1 0 0 0];
end
if (choice == 3)
    c = [1 -sqrt(2) 1 0];
    d = [0 0 1 0];
end
if (choice == 4)
    c = [-75/2 -5/2 7/2 1/2];
    d = [3/2 -7/2 1 0];
end
if (choice == 5)
    c = [1/3 0 0 0];
    d = [0 1 0 0];
end
%pole_zero_plot(c,d);
plot_freq_response(c,d);
 
function pole_zero_plot(c,d)
    %Draw unit circle
    angle = 0:2*pi/500:2*pi;   
    R = 1;  
    x = R*cos(angle);  
    y = R*sin(angle);
    hold on
    plot(x,y, '--');
    axis equal;
    grid on;
    xlabel('Re\{z\}');
    ylabel('Im\{z\}');
    title('Poles and Zeros for Z-Plane');
    %Find the roots of the functions with coefficients c and d
    clear roots
    %Plot zeros
    coefs = flip(c);
    r_c = roots(coefs);
    r_c = round(r_c,3);
    [root_count,unique_roots] = groupcounts(r_c);
    for root = 1:length(unique_roots)
        if(root_count(root) == 1) 
            scatter(real(unique_roots(root)),imag(unique_roots(root)), 60, 'g', 'o','LineWidth',1.1);
        elseif(root_count(root) == 2)
            scatter(real(unique_roots(root)),imag(unique_roots(root)), 60, 'g', 's','LineWidth',1.1);
        else 
            scatter(real(unique_roots(root)),imag(unique_roots(root)), 60, 'g', 'filled','LineWidth',1.1);
        end
    end
    %Plot poles
    coefs = flip(d);
    r_d = roots(coefs);
    r_d = round(r_d,3);
    [root_count,unique_roots] = groupcounts(r_d);
    for root = 1:length(unique_roots)
        if(root_count(root) == 1) 
            scatter(real(unique_roots(root)),imag(unique_roots(root)), 60, 'r', 'x','LineWidth',1.1);
        elseif(root_count(root) == 2)
            scatter(real(unique_roots(root)),imag(unique_roots(root)), 60, 'r', '+','LineWidth',1.1);
        else 
            scatter(real(unique_roots(root)),imag(unique_roots(root)), 60, 'r', '*','LineWidth',1.1);
        end
    end
    if (length(r_d) == length(r_c)) 
       text(0,2,'No poles or zeros at z = infinity');
    end
    if (length(r_d) < length(r_c))
       text(0,2,sprintf('%d poles at z = infinity', length(r_c) - length(r_d)));
    end
    if (length(r_c) < length(r_d))
       text(0,2,sprintf('%d zeros at z = infinity', length(r_d) - length(r_c)));
    end
        
    hold off
end
 
function plot_freq_response(c,d)
    rad_freq = -pi:0.01:pi;
    H_func = @(x) (c(1) + c(2)*x + c(3)*x.^2 + c(4)*x.^3)./(d(1) + d(2)*x + d(3)*x.^2 +d(4)*x.^3);
    %Plot frequency response
    subplot(2,1,1);
    %Plot magnitude
    plot(rad_freq,abs(H_func(exp(1i*rad_freq))));
    xticks([ -pi -pi/2 0 pi/2 pi ]);
    xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
    ylabel('Magnitude');
    title('Magnitude Response');
    subplot(2,1,2);
    %Plot phase
    plot(rad_freq,angle(H_func(exp(1i*rad_freq))));
    xlabel('Radian frequency');
    xticks([ -pi -pi/2 0 pi/2 pi ]);
    xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
    ylabel('Phase(radians)');
    yticks([ -pi -pi/2 0 pi/2 pi ]);
    yticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
    title('Phase Response');
 
end
