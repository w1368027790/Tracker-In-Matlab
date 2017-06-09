%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ߣ�qw
%E-mail��1406820937@qq.com
%�ӳ����������㷨�õ���Ŀ��λ������ʵĿ��λ�õ����
%��positions�㷨�õ���λ��,ground_truthĿ����ʵλ��,title�ļ�·����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
function show_precision(positions, ground_truth, title)	
	max_threshold = 50;  %used for graphs in the paper
	
	
	if size(positions,1) ~= size(ground_truth,1),
		disp('Could not plot precisions, because the number of ground')
		disp('truth frames does not match the number of tracked frames.')
		return
	end
	%%
    target_sz = [ground_truth(:,4), ground_truth(:,3)];
	pos = [ground_truth(:,2), ground_truth(:,1)] + floor(target_sz/2);
	%% calculate distances to ground truth over all frames
	distances = sqrt((positions(:,1) - pos(:,1)).^2 + ...
				 	 (positions(:,2) - pos(:,2)).^2);
	distances(isnan(distances)) = [];

	%compute precisions
	precisions = zeros(max_threshold, 1);
	for p = 1:max_threshold,
		precisions(p) = nnz(distances < p) / numel(distances);
	end
	
	%plot the precisions
	figure('Number','off', 'Name',['Precisions - ' title])
	plot(precisions, 'k-', 'LineWidth',2)
    grid on
	xlabel('Threshold'), ylabel('Precision')

end
