clc
clear all

% % % % % Uploading EEG Data to Workspace % % % % %
%data=load('SUBJECT11_EEG.txt'); for Subject 1
%data=load('SUBJECT12_EEG.txt'); for Subject 2
%data=load('SUBJECT13_EEG.txt'); for Subject 3

data=load('SUBJECT1_EEG.txt');

s=data(1:1200);
N=length(s); 

% % % % % Feature Extraction by Wavelet Decomposition % % % % %

waveletFunction = 'db8';
[C,L] = wavedec(s,8,waveletFunction); %Level 8 Decomposition
       
cD1 = detcoef(C,L,1); 
cD2 = detcoef(C,L,2);
cD3 = detcoef(C,L,3); 
cD4 = detcoef(C,L,4); 
cD5 = detcoef(C,L,5); 
cD6 = detcoef(C,L,6); 
cD7 = detcoef(C,L,7); 
cD8 = detcoef(C,L,8); 
cA8 = appcoef(C,L,waveletFunction,8);  
D1 = wrcoef('d',C,L,waveletFunction,1); 
D2 = wrcoef('d',C,L,waveletFunction,2); 
D3 = wrcoef('d',C,L,waveletFunction,3); 
D4 = wrcoef('d',C,L,waveletFunction,4); 
D5 = wrcoef('d',C,L,waveletFunction,5); %GAMMA
D6 = wrcoef('d',C,L,waveletFunction,6); %BETA
D7 = wrcoef('d',C,L,waveletFunction,7); %ALPHA
D8 = wrcoef('d',C,L,waveletFunction,8); %THETA
A8 = wrcoef('a',C,L,waveletFunction,8); %DELTA
              

%%%Delta Wave in Time Domain%%%

Delta = A8; 
figure; 
subplot(5,1,1);
plot(1:1:length(Delta),Delta);
title('DELTA');
xlabel('Time');
ylabel('Amplitude');

%%%Theta Wave in Time Domain%%%
Theta = D8; 
subplot(5,1,2); 
plot(1:1:length(Theta),Theta);
title('THETA');
xlabel('Time');
ylabel('Amplitude');


%%%Alpha Wave in Time Domain%%%
Alpha = D7; 
subplot(5,1,3);
plot(1:1:length(Alpha),Alpha);
title('ALPHA');
xlabel('Time');
ylabel('Amplitude');
  

%%%Beta Wave in Time Domain%%%
Beta = D6; 
subplot(5,1,4); 
plot(1:1:length(Beta), Beta); 
title('BETA');
xlabel('Time');
ylabel('Amplitude');
  

%%%Gamma Wave in Time Domain%%%
Gamma = D5; 
subplot(5,1,5); 
plot(1:1:length(Gamma),Gamma);
title('GAMMA');
xlabel('Time');
ylabel('Amplitude');
 

%%%Delta Wave in Frequency Domain and Maximum Delta Frequency%%%  
A8 = detrend(A8,0);
xdft1 = fft(A8);
xdft1 = xdft1(1:length(A8)/2);
figure;subplot(511);plot(abs(xdft1));title('DELTA');
xlabel('Frequency');
ylabel('Amplitude');
[~,I] = max(abs(xdft1));
fprintf('Maximum Delta occurs at %f Hz.\n',I);


%%%Theta Wave in Frequency Domain and Maximum Theta Frequency%%%
D8 = detrend(D8,0);
xdft2 = fft(D8);
xdft2 = xdft2(1:length(D8)/2);
subplot(512);plot(abs(xdft2));title('THETA');
xlabel('Frequency');
ylabel('Amplitude');
[~,I] = max(abs(xdft2));
fprintf('Maximum Theta occurs at %f Hz.\n',(I));


%  Alpha Wave in Frequency Domain and Maximum Alpha Frequency%%% 
D7 = detrend(D7,0);
xdft3 = fft(D7);
xdft3 = xdft3(1:length(D7)/2);
subplot(513);plot(abs(xdft3));title('ALPHA');
xlabel('Frequency');
ylabel('Amplitude');
[~,I] = max(abs(xdft3));
fprintf('Maximum Alpha occurs at %f Hz.\n',(I));


%%%Beta Wave in Frequency Domain and Maximum Beta Frequency%%% 
D6 = detrend(D6,0);
xdft4 = fft(D6);
xdft4 = xdft4(1:length(D6)/2);
subplot(514);plot(abs(xdft4));title('BETA');
xlabel('Frequency');
ylabel('Amplitude');
[~,I] = max(abs(xdft4));
fprintf('Maximum Beta occurs at %f Hz.\n',(I));


%%%Gamma Wave in Frequency Domain and Maximum Gamma Frequency%%% 
D5 = detrend(D5,0);
xdft5 = fft(D5);
xdft5 = xdft5(1:length(D5)/2);
subplot(515);plot(abs(xdft5));title('GAMMA');
xlabel('Frequency');
ylabel('Amplitude');
[~,I] = max(abs(xdft5));
fprintf('Maximum Gamma occurs at %f Hz.\n',(I));
  

% Average Power Calculation

POWER_DELTA = (sum(A8.^2))/length(A8); 
POWER_THETA = (sum(D8.^2))/length(D8);
POWER_ALPHA = (sum(D7.^2))/length(D7);
POWER_BETA  = (sum(D6.^2))/length(D6);
POWER_GAMMA = (sum(D5.^2))/length(D5);

fprintf('\nAVERAGE POWER OF DELTA %3.2f Hz.\n',POWER_DELTA);
fprintf('AVERAGE POWER OF THETA %3.2f Hz.\n',POWER_THETA);
fprintf('AVERAGE POWER OF ALPHA %3.2f Hz.\n',POWER_ALPHA);
fprintf('AVERAGE POWER OF BETA %3.2f Hz.\n',POWER_BETA);
fprintf('AVERAGE POWER OF GAMMA %3.2f Hz.\n',POWER_GAMMA);

