% H∞制御設計デモ用
close all
clear variables
w = logspace(-2,6,100);

% 一般化プラントの作成
gplant

% H∞制御器の設計
[K,CL,gamma] = hinfsyn(Gsys,1,1);

% 制御器ボード線図の表示
contplot

% シミュレーション
%simu

