clc
clear all
close all
%% ================== Part 1: ��������������� ===================
%bp �������Ԥ�����
%�����������������
%ר��1---��Ƶ����
%load E:\Ellen_study\simulationdata\video_train_in.data;
%load E:\Ellen_study\simulationdata\video_train_out.data;
%ר��2---������������
%load E:\Ellen_study\simulationdata\e_train_in.data;
%load E:\Ellen_study\simulationdata\e_train_out.data;
%ר��3---��ý������
load E:\Ellen_study\simulationdata\media_train_in.data;
load E:\Ellen_study\simulationdata\media_train_out.data;
%ר��4---�����ʼ����ļ�����
load E:\Ellen_study\simulationdata\mail_train_in.data;
load E:\Ellen_study\simulationdata\mail_train_out.data;
%save video_train_in.mat;
%save video_train_out.mat;%ע��t����Ϊ������

%% ================== Part 2: BP�����繹��ģ�� ===================
%��ֵ������p�����t
%ר��1---��Ƶҵ������
%p=video_train_in';
%t=video_train_out';
%ר��2---������������
%p=e_train_in';
%t=e_train_out';
%ר��3---��ý��
p=media_train_in';
t=media_train_out';
%ר��4---�����ʼ����ļ�����
p=mail_train_in';
t=mail_train_out';
%���ݵĹ�һ������������mapminmax������ʹ��ֵ��һ����[-1.1]֮��
%�ú���ʹ�÷������£�[y,ps] =mapminmax(x,ymin,ymax)��x��黯���������룬
%ymin��ymaxΪ��黯���ķ�Χ������Ĭ��Ϊ�黯��[-1,1]
%���ع黯���ֵy���Լ�����ps��ps�ڽ������һ���У���Ҫ����
[p1,ps]=mapminmax(p,0,1);
[t1,ts]=mapminmax(t,0,1);
%ȷ��ѵ�����ݣ���������,һ��������Ĵ�������ѡȡ70%��������Ϊѵ������
%15%��������Ϊ�������ݣ�һ����ʹ�ú���dividerand����һ���ʹ�÷������£�
%[trainInd,valInd,testInd] = dividerand(Q,trainRatio,valRatio,testRatio)
[trainsample.p,valsample.p,testsample.p] =dividerand(p,0.7,0.15,0.15);
[trainsample.t,valsample.t,testsample.t] =dividerand(t,0.7,0.15,0.15);
%num1=sum(valsample.t>-1)
%�������򴫲��㷨��BP�����磬ʹ��newff��������һ���ʹ�÷�������
%net = newff(minmax(p),[�������Ԫ�ĸ�������������Ԫ�ĸ���],{������Ԫ�Ĵ��亯���������Ĵ��亯����,'���򴫲���ѵ������'),����pΪ�������ݣ�tΪ�������
%tfΪ������Ĵ��亯����Ĭ��Ϊ'tansig'����Ϊ����Ĵ��亯����
%purelin����Ϊ�����Ĵ��亯��
%һ�������ﻹ�������Ĵ���ĺ���һ������£����Ԥ�������Ч�����Ǻܺã����Ե���
%TF1 = 'tansig';TF2 = 'logsig';
%TF1 = 'logsig';TF2 = 'purelin';
%TF1 = 'logsig';TF2 = 'logsig';
%TF1 = 'purelin';TF2 = 'purelin';
TF1='tansig';TF2='purelin';
%net=newff(minmax(p),[10,2],{TF1 TF2},'traingdm');%���紴��
net = feedforwardnet(6);
%net;
%view(net)
%pref=perform(net,y,trainsample.t);
%net.divideParam.trainRatio=0.8;
%net.divideParam.valRatio=0.2;
%net.divideParam.testRatio=0;
%�������������
net.trainParam.epochs=1000;%ѵ����������
net.trainParam.goal=1e-6;%ѵ��Ŀ������
net.trainParam.lr=0.01;%ѧϰ������,Ӧ����Ϊ����ֵ��̫����Ȼ���ڿ�ʼ�ӿ������ٶȣ����ٽ���ѵ�ʱ�����������������ʹ�޷�����
net.trainParam.mc=0.9;%�������ӵ����ã�Ĭ��Ϊ0.9
net.trainParam.show=10;%��ʾ�ļ������
% ָ��ѵ������
% net.trainFcn = 'traingd'; % �ݶ��½��㷨
% net.trainFcn = 'traingdm'; % �����ݶ��½��㷨
% net.trainFcn = 'traingda'; % ��ѧϰ���ݶ��½��㷨
% net.trainFcn = 'traingdx'; % ��ѧϰ�ʶ����ݶ��½��㷨
% (�����������ѡ�㷨)
% net.trainFcn = 'trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
% �����ݶ��㷨
% net.trainFcn = 'traincgf'; %Fletcher-Reeves�����㷨
% net.trainFcn = 'traincgp'; %Polak-Ribiere�����㷨,�ڴ������Fletcher-Reeves�����㷨�Դ�
% net.trainFcn = 'traincgb'; % Powell-Beal��λ�㷨,�ڴ������Polak-Ribiere�����㷨�Դ�
% (�����������ѡ�㷨)
%net.trainFcn = 'trainscg'; % ScaledConjugate Gradient�㷨,�ڴ�������Fletcher-Reeves�����㷨��ͬ,�����������������㷨��С�ܶ�
% net.trainFcn = 'trainbfg'; %Quasi-Newton Algorithms - BFGS Algorithm,���������ڴ�������ȹ����ݶ��㷨��,�������ȽϿ�
% net.trainFcn = 'trainoss'; % OneStep Secant Algorithm,���������ڴ��������BFGS�㷨С,�ȹ����ݶ��㷨�Դ�
% (�����������ѡ�㷨)
%net.trainFcn = 'trainlm'; %Levenberg-Marquardt�㷨,�ڴ��������,�����ٶ����
% net.trainFcn = 'trainbr'; % ��Ҷ˹�����㷨
% �д����Ե������㷨Ϊ:'traingdx','trainrp','trainscg','trainoss', 'trainlm'
%������һ����ѡȡ'trainlm'������ѵ��������Զ�Ӧ����Levenberg-Marquardt�㷨
net.trainFcn='trainlm';
[net,tr]=train(net,trainsample.p,trainsample.t);
%������棬��һ����sim����
[normtrainoutput,trainPerf]=sim(net,trainsample.p,[],[],trainsample.t);%ѵ�������ݣ�����BP�õ��Ľ��
%disp(normtrainoutput)
[normvalidateoutput,validatePerf]=sim(net,valsample.p,[],[],valsample.t);%��֤�����ݣ���BP�õ��Ľ��
[normtestoutput,testPerf]=sim(net,testsample.p,[],[],testsample.t);%�������ݣ���BP�õ��Ľ��
%�����õĽ�����з���һ�����õ�����ϵ�����
trainoutput=mapminmax('reverse',normtrainoutput,ts);
%disp(trainoutput)
validateoutput=mapminmax('reverse',normvalidateoutput,ts);
testoutput=mapminmax('reverse',normtestoutput,ts);
%num2=sum(validateoutput>-1)
%������ֵ
threshold=selectThreshold(valsample.t,validateoutput)
%��ѵ������������ݽ��з���
%ppval = (validateoutput > 0.85);
%������������ݵķ���һ���Ĵ������õ�����ʽֵ
trainvalue=mapminmax('reverse',trainsample.t,ts);%��������֤����
validatevalue=mapminmax('reverse',valsample.t,ts);%��������֤������
testvalue=mapminmax('reverse',testsample.t,ts);%�����Ĳ�������
%disp(testoutput)
%��Ԥ�⣬����ҪԤ�������pnew
%pnew=[4,9,16.3429,12.1939,0.0304]';
%pnewn=mapminmax(pnew);
%anewn=sim(net,pnewn);
%anew=mapminmax('reverse',anewn,ts);
%�������ļ���
errors=trainvalue-trainoutput;

%% ================== Part 3: �������ʺ����� ===================
testoutput=(testoutput>threshold);
%trainoutput=(trainoutput>threshold);
%validateoutput=(validateoutput>threshold);
%valsampleabnormal=sum(valsample.t==0);
%validateabnormal=sum(validateoutput==0);

%accuracy=validateabnormal/valsampleabnormal
%TP:�쳣----�쳣��FN���쳣----������FP������----�쳣��TN������----����
TP=sum((testsample.t == 0) & (testoutput == 0))
FN=sum((testsample.t == 0) & (testoutput == 1))
TN=sum((testsample.t == 1) & (testoutput == 1))
FP=sum((testsample.t == 1) & (testoutput == 0))
%�����
DR=TP/(TP+FN)
%����
FA=FP/(TN+FP)

%% ================== Part 4: ���ͼ ===================
%plotregression���ͼ
figure,plotregression(trainvalue,trainoutput)
%���ͼ
figure,plot(1:length(errors),errors,'-b')
title('���仯ͼ')
%���ֵ����̬�Եļ���
figure,hist(errors);%Ƶ��ֱ��ͼ
figure,normplot(errors);%Q-Qͼ
[muhat,sigmahat,muci,sigmaci]=normfit(errors); %�������� ��ֵ,����,��ֵ��0.95��������,�����0.95��������
%[h1,sig,ci]= ttest(errors,muhat);%�������
%figure, ploterrcorr(errors);%�������������ͼ
%figure, parcorr(errors);%����ƫ���ͼ