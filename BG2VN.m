function [vital_idx,adjacency_matrix]=BG2VN(k,N,p,mean,std_dev,interval,varargin)

default_parameter = inputParser;                             % Input parser for functions
addParameter(default_parameter,'Link_constraint',-1);        % Link_constraint defaults to the length of 30% of the edges of a distribution
addParameter(default_parameter,'Visualization',false);       % VisualizationVisualization defaults to false.
parse(default_parameter,varargin{:});                        % Parses the input variable and updates the value of the variable if it detects a previous assignment.
link_constraint=default_parameter.Results.Link_constraint;
visualization=default_parameter.Results.Visualization;

%vital_idx records the id of the vital node
vital_idx=zeros(k,1);

% MU_set records the coordinates of vital nodes
MU_set=zeros(k,2);

% quotient remainder
quotient=floor(N/k);
remainder=mod(N,k);
%simple_size is the number of samples from each 2D Gaussian distribution, N/k for the first one and N/k+N%k for the last one
simple_size=quotient;


%% Generate the coordinates of k Gaussian distributed points
x=[];%x records the coordinates of all samples

for iter_gauss=1:k

   MU=MU_rand(MU_set,iter_gauss,mean,std_dev,interval);%Coordinates of vital nodes
   MU_set(iter_gauss,1)= MU(1);
   MU_set(iter_gauss,2)= MU(2);

   SIGMA=[1,0;0,1];%σ1=σ2=1,(statistics) covariance=0

   if  iter_gauss==k
       simple_size=quotient + remainder;
   end

   sub_gauss=mvnrnd(MU, SIGMA, simple_size-1);%simple_size-1,Because to add(μ1,μ2)[vital node]
   vital_idx(iter_gauss)=length(x)+1;
   x=[x;MU;sub_gauss];
end

%% Use the default link_constraint
if link_constraint==-1

    % link_constraint is obtained based on the proportions of the 1 distribution
    dis_len=quotient*(quotient-1)/2;
    dis=zeros(dis_len,1);
    dis_num=1;
    for i=1:quotient-1
        for j=i+1:quotient
            dis(dis_num)=distance(x(i,1),x(i,2),x(j,1),x(j,2));
            dis_num=dis_num+1;
        end
    end

    % Sort the column vector in descending order and get the subscripts
    [Values] = sort(dis, 'descend');
    % Set the edge constraints to the top 30% of all edges in 1 distribution
    threshold=floor(0.7*dis_num);
    link_constraint=Values(threshold);

    disp('link_constraint=');
    disp(link_constraint);
end



%% Constructing an adjacency matrix
adjacency_matrix=zeros(N);
% Construct the upper triangular matrix from the distance between two points and the constraints
for i=1:N-1
    for j=i+1:N    
        if  distance(x(i,1),x(i,2),x(j,1),x(j,2))<link_constraint

            if ismember(i, vital_idx)==1 || ismember(j, vital_idx)==1
                is_vital=1;
            end

            if  is_vital==1 || (is_vital==0 && rand()<p) % If both sides are ordinary nodes, the constraint p needs to be satisfied
                adjacency_matrix(i,j)=1;
            end
            
            is_vital=0;
        end
    end
end

% Construct symmetric matrices from upper triangular matrices
adjacency_matrix=adjacency_matrix+adjacency_matrix';


%% visualization
if visualization==true
    plot_BG2VN(x,N,adjacency_matrix,MU_set);
end
