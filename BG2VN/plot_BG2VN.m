% Generate a graph of BG2VN
function plot_BG2VN(x,N,adjacency_matrix,MU_set)

%% graph of k sets of two-dimensional Gaussian distributed samples
figure;
scatter(x(:, 1), x(:, 2), 10, 'filled', 'MarkerFaceColor', 'b' ,'DisplayName', 'Ordinary Samples');
hold on;
scatter(MU_set(:, 1), MU_set(:, 2), 30, 'filled', 'MarkerFaceColor', 'r','DisplayName', 'Mean');

xlabel('X-coordinate','FontSize', 15, 'FontWeight', 'bold');
ylabel('Y-coordinate','FontSize', 15, 'FontWeight', 'bold');
axis equal; % Setting the axes to scale equally
hold off;
legend show; 


%% graph of BG2VN
figure;
hold on;

% Plot all points
%scatter(x(:, 1), x(:, 2), 10, 'filled', 'MarkerFaceColor', 'b');

for i = 1:N-1
    for j = i+1:N % Avoiding double counting 
        % Draw a line if edges exist in adjacency_matrix
        if adjacency_matrix(i,j)==1
            plot([x(i, 1), x(j, 1)], [x(i, 2), x(j, 2)], 'g');
        end
    end
end
scatter(x(:, 1), x(:, 2), 10, 'filled', 'MarkerFaceColor', 'b' ,'DisplayName', 'ordinary Samples');
hold on;
scatter(MU_set(:, 1), MU_set(:, 2), 30, 'filled', 'MarkerFaceColor', 'r','DisplayName', 'Mean');

axis equal; % Setting the axes to scale equally
axis off;
hold off;
