%% アプリ作成用オリジナルファイル
% サンプル用音声ファイルの準備
clear, clc
load mtlb.mat;                  % サンプル音声ファイル
mtlb = mtlb/max(mtlb);          % 最大を+1とする
audiowrite('mtlb.wav',mtlb,Fs); % WAVE形式で保存
load handel.mat;                % サンプル音声ファイル2
audiowrite('handel.wav',y,Fs);
clear

%% 音声データの可視化・再生
[y,fs] = audioread('mtlb.wav'); % ファイルの読み込み
t = 0 : 1/fs : numel(y)/fs - 1/fs; % 時間ベクトルの定義
plot(t,y)                   % 時間軸でのデータ表示
figure,
[p,f] = pspectrum(y,fs);    % パワースペクトルの計算
plot(f,10*log10(p))         % 周波数軸でのデータ表示
sound(y,fs)                 % 音の再生

%% フィルタリング処理と可視化・再生
filterflag = 0; % 0:HPF, 1:LPF
fpass = 1000;   % フィルタ通過域周波数
gain = 50;      % ゲイン

if filterflag == 1
    y2 = lowpass(y,fpass,fs);
else
    y2 = highpass(y,fpass,fs);
end

y2 = 0.01 * gain * y2;

plot(t,y2)
figure,
[p,f] = pspectrum(y2,fs);
plot(f,10*log10(p))
sound(y2,fs)

%% 処理後のファイルの保存
[nfname,npath]=uiputfile('.wav','Save sound','new_sound.wav');
filename=fullfile(npath,nfname);
audiowrite(filename,y2,fs)