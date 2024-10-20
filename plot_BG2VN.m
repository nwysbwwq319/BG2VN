% 生成BG2VN的图d
function plot_BG2VN(x,N,link_constraint,MU_set)

%% 普通节点+关键节点
figure;
scatter(x(:, 1), x(:, 2), 10, 'filled', 'MarkerFaceColor', 'b' ,'DisplayName', 'Ordinary Samples');
hold on;
scatter(MU_set(:, 1), MU_set(:, 2), 30, 'filled', 'MarkerFaceColor', 'r','DisplayName', 'Mean');
% 设置图形属性
xlabel('X-coordinate','FontSize', 15, 'FontWeight', 'bold');
ylabel('Y-coordinate','FontSize', 15, 'FontWeight', 'bold');
axis equal; % 设置坐标轴比例相等
hold off;
legend show; 


%% 点+边
figure;
hold on;

% 绘制所有点
%scatter(x(:, 1), x(:, 2), 10, 'filled', 'MarkerFaceColor', 'b');

% 循环遍历所有点并连接距离小于 1 的点
for i = 1:N-1
    for j = i+1:N % 避免重复计算
        % 计算两点之间的距离
        dis=distance(x(i,1),x(i,2),x(j,1),x(j,2));
        
        % 如果距离小于 link_constraint，则画线
        if dis < link_constraint
            plot([x(i, 1), x(j, 1)], [x(i, 2), x(j, 2)], 'g');
        end
    end
end
scatter(x(:, 1), x(:, 2), 10, 'filled', 'MarkerFaceColor', 'b' ,'DisplayName', 'ordinary Samples');
hold on;
scatter(MU_set(:, 1), MU_set(:, 2), 30, 'filled', 'MarkerFaceColor', 'r','DisplayName', 'Mean');

axis equal; % 设置坐标轴比例相等
%grid on; % 添加网格
axis off;
hold off;
