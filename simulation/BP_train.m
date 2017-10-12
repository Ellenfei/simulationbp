function model = BP_train( net_structure,x,y )
[sample_size,n] = size(x);
B1 = n;
B2 = net_structure.hiden_num;
[~,n] = size(y);
B3 = n;
maxgen = net_structure.maxgen;
% 初始化权重和阈值
W12 = rands(B1,B2);
b2 = rands(1,B2);
W23 = rands(B2,B3);
b3 = rands(1,B3);
E = [];
for i = 1:1:maxgen
    e = 0;
    for j = 1:1:sample_size
        alpha = 0.5*rand;
%         alpha = 1/i+0.1;
        H = x(j,:)*W12+b2;
        H = 1./(1+exp(-H));
        O = H*W23+b3;
        delta_W12 = mat_seq(x(j,:)',B2,'h').*mat_seq(H.*(1-H),B1,'v').*mat_seq((O-y(j,:))*W23',B1,'v');
        delta_b2 = H.*(1-H).*((O-y(j,:))*W23');
        delta_W23 = mat_seq(H',B3,'h').*mat_seq(O-y(j,:),B2,'v');
        delta_b3 = O-y(j,:);
        % 更新权阈值
        W12 = W12-alpha*delta_W12;
        b2 = b2-alpha*delta_b2;
        W23 = W23-alpha*delta_W23;
        b3 = b3-alpha*delta_b3;
        e = e+sum((O-y(j,:)).^2);
    end
    E = [E,e];
    disp(['迭代次数：',num2str(i)])
end
model = struct('W12',W12,'b2',b2,'W23',W23,'b3',b3,'E',E);
end

% 矩阵复制成序列
function out_mat = mat_seq(mat,num,axis)
mat0 = mat;
if axis == 'h' % 表示横向复制矩阵
    for i = 1:1:(num-1)
        mat0 = [mat0,mat];
    end
else
    for i = 1:1:(num-1)
        mat0 = [mat0;mat];
    end
end
out_mat = mat0;
end