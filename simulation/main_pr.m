%% 三层神经网络算法的matlab实现
clear,clc,close all
% 构造样例数据
x = linspace(-10,10,2000)';
y = sin(x);
% 训练测试集分割
a = rand(length(x),1);
%m：a的升序排列；n：a的各个元素的索引
[m,n] = sort(a);
%前1400个元素
x_train = x(n(1:floor(0.7*length(a))));
%后600个元素
x_test = x(n(floor(0.7*length(a))+1:end));
y_train = y(n(1:floor(0.7*length(a))));
y_test = y(n(floor(0.7*length(a)+1):end));
% 数据归一化
[x_train_regular,x_train_maxmin] = mapminmax(x_train');
x_train_regular = x_train_regular';
x_test_regular = mapminmax('apply',x_test',x_train_maxmin);
x_test_regular = x_test_regular';