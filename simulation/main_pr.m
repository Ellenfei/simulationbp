%% �����������㷨��matlabʵ��
clear,clc,close all
% ������������
x = linspace(-10,10,2000)';
y = sin(x);
% ѵ�����Լ��ָ�
a = rand(length(x),1);
%m��a���������У�n��a�ĸ���Ԫ�ص�����
[m,n] = sort(a);
%ǰ1400��Ԫ��
x_train = x(n(1:floor(0.7*length(a))));
%��600��Ԫ��
x_test = x(n(floor(0.7*length(a))+1:end));
y_train = y(n(1:floor(0.7*length(a))));
y_test = y(n(floor(0.7*length(a)+1):end));
% ���ݹ�һ��
[x_train_regular,x_train_maxmin] = mapminmax(x_train');
x_train_regular = x_train_regular';
x_test_regular = mapminmax('apply',x_test',x_train_maxmin);
x_test_regular = x_test_regular';