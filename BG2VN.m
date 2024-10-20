function [vital_idx,adjacency_matrix]=BG2VN(k,N,p,mean,std_dev,interval,varargin)

default_parameter = inputParser;                             % 函数的输入解析器
addParameter(default_parameter,'Link_constraint',-1);        % Link_constraint默认为一个分布的30%边的长度
addParameter(default_parameter,'Visualization',false);       % Visualization可视化默认为false
parse(default_parameter,varargin{:});                        % 对输入变量进行解析，如果检测到前面的变量被赋值，则更新变量取值
link_constraint=default_parameter.Results.Link_constraint;
visualization=default_parameter.Results.Visualization;

%vital_idx记录关键节点的id
vital_idx=zeros(k,1);

% MU_set记录关键节点的坐标
MU_set=zeros(k,2);

% 计算商和余数 商quotient 余数remainder
quotient=floor(N/k);
remainder=mod(N,k);
%simple_size为每个二维高斯分布的点的数量，前面的为N/k，最后一个为N/k+N%k
simple_size=quotient;


%% 生成k个高斯分布的点的坐标
x=[];%x记载所有样本坐标

for iter_gauss=1:k

   MU=MU_rand(MU_set,iter_gauss,mean,std_dev,interval);%关键节点的坐标
   MU_set(iter_gauss,1)= MU(1);
   MU_set(iter_gauss,2)= MU(2);

   SIGMA=[1,0;0,1];%σ1和σ2都是1，协方差为0

   if  iter_gauss==k
       simple_size=quotient + remainder;
   end

   sub_gauss=mvnrnd(MU, SIGMA, simple_size-1);%simple_size要-1，因为要加入(μ1,μ2)作为关键节点
   vital_idx(iter_gauss)=length(x)+1;
   x=[x;MU;sub_gauss];
end

%% 使用默认link_constraint
if link_constraint==-1

    % 根据1个分布的比例得到边约束的阈值
    dis_len=quotient*(quotient-1)/2;
    dis=zeros(dis_len,1);
    dis_num=1;
    for i=1:quotient-1
        for j=i+1:quotient
            dis(dis_num)=distance(x(i,1),x(i,2),x(j,1),x(j,2));
            dis_num=dis_num+1;
        end
    end

    % 对列向量进行降序排序，并获取下标
    [Values] = sort(dis, 'descend');
    % 设置边的约束为1个分布中所有边的前30%
    threshold=floor(0.7*dis_num);
    link_constraint=Values(threshold);

    disp('link_constraint=');
    disp(link_constraint);
end

%% 可视化
if visualization==true
    % 生成GMM的图
    plot_BG2VN(x,N,link_constraint,MU_set);
end

%% 构建邻接矩阵
adjacency_matrix=zeros(N);
% 根据两点间距离和约束构建上三角矩阵
for i=1:N-1
    for j=i+1:N    
        if  distance(x(i,1),x(i,2),x(j,1),x(j,2))<link_constraint

            if ismember(i, vital_idx)==1 || ismember(j, vital_idx)==1
                is_vital=1;
            end

            if  is_vital==1 || (is_vital==0 && rand()<p)
                adjacency_matrix(i,j)=1;
            end
            
            is_vital=0;
        end
    end
end
% 根据上三角矩阵构造对称矩阵
adjacency_matrix=adjacency_matrix+adjacency_matrix';
