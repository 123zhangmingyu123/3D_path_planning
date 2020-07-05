%���� ���� �ùķ������Դϴ�.

clear;
clc;

[Z, ref] = dted('n37.dt0');

N_s = 100;
x_s = linspace(1, N_s,N_s);
y_s = linspace(1, N_s,N_s);

x_2d_s = repmat(x_s,N_s,1);
y_2d_s = repmat(y_s',1,N_s);

x_1d_s = zeros(1,N_s*N_s);
y_1d_s = zeros(1,N_s*N_s);

z_1d_s = zeros(1,N_s*N_s);
z_2d_s = zeros(N_s,N_s);

cnt = 1;
for i = 1: N_s %1�ڷ� ����ºκ�
    for j = 1: N_s
        x_1d_s(cnt) = x_2d_s(i,j);
        y_1d_s(cnt) = y_2d_s(i,j);
        z_1d_s(cnt) = Z(i,j);
        z_2d_s(i,j) = Z(i,j);
        cnt = cnt+1;
    end
end

%1�ܰ� ������� ȹ��
% figure(1);
% set(gcf,'numbertitle','off','name', '�������');
% contour(x_2d_s,y_2d_s,z_2d_s,'ShowText','on');
% xlabel('km');
% ylabel('km');

%% height
%2�ܰ� ����ǥ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���� ����(���� ����)
flight_height = 700;% ���� ���̺��� ���� ���̰� ���� ������ �Ұ����� ��(��ֹ�)
% ��ֹ��� ��ġ�� xn_new, yn_new, z_new �� ����Ǿ�����
i_site = find(z_1d_s > flight_height);  %���� ���ִºκ� ������ ���� ũ�� �Ǵ�
xn_new = zeros(1,length(i_site));  
yn_new = zeros(1,length(i_site));  
z_new = zeros(1,length(i_site));

for sitetmp = 1:length(i_site) % ���̿� ���ؼ� �ɷ��� xy��ġ ����
   xn_new(sitetmp) = x_1d_s(i_site(sitetmp));
   yn_new(sitetmp) = y_1d_s(i_site(sitetmp)); 
   z_new(sitetmp) = z_1d_s(i_site(sitetmp)); 
end

[vx, vy] = voronoi(xn_new,yn_new);

% 1���� ������ ȹ��
vx1 = vx(1,:); 
vy1 = vy(1,:);

% 2���� ������ ȹ��
vx2 = vx(2,:);
vy2 = vy(2,:);

c_r = 1;
vx_new = vx;
vy_new = vy;

for i = 1 : length(xn_new)
    % 1���� ������ ȹ��
    vx1 = vx_new(1,:); 
    vy1 = vy_new(1,:);

    % 2���� ������ ȹ��
    vx2 = vx_new(2,:);
    vy2 = vy_new(2,:);

    r_sq = (vx1-xn_new(i)).^2+(vy1-yn_new(i)).^2;
    idx1 = find((r_sq < c_r^2));
    
    r_sq = (vx2-xn_new(i)).^2+(vy2-yn_new(i)).^2;
    idx2 = find((r_sq < c_r^2));
    
    idx = union(idx1,idx2);
    
   
    vx_new(:,idx) = [];
    vy_new(:,idx) = [];
    
end



% figure(2);
% set(gcf,'numbertitle','off','name', '����ǥ��');
% contour(x_2d_s,y_2d_s,z_2d_s,'ShowText','on');
% xlabel('km');
% ylabel('km');
% hold on;
% %plot(vx_new,vy_new,'b.-')
% plot(xn_new,yn_new,'r.');
% axis([0 N_s 0 N_s]);

%%
%3�ܰ� ���װ��� ��� ǥ��

% figure(3);
% set(gcf,'numbertitle','off','name', '���ǥ��');
% contour(x_2d_s,y_2d_s,z_2d_s,'ShowText','on');
% xlabel('km');
% ylabel('km');
% hold on;
% plot(vx_new,vy_new,'b.-')
% plot(xn_new,yn_new,'r.');
% axis([0 N_s 0 N_s]);

%4�ܰ� ������Ʈ ��� ǥ��
th = 0:0.01:2*pi; %���� �׸������� ���� �迭
%c_cx = 15; c_cy = 17; c_r =5;
c_cx = 0; c_cy = 0; c_r = 0;
xc = c_r*cos(th)+c_cx; 
yc = c_r*sin(th)+c_cy;

vx1 = vx_new(1,:); 
vy1 = vy_new(1,:);
r_sq = (vx1-c_cx).^2+(vy1-c_cy).^2;
idx1 = find((r_sq < c_r^2));

vx2 = vx_new(2,:);
vy2 = vy_new(2,:);

r_sq = (vx2-c_cx).^2+(vy2-c_cy).^2;
idx2 = find((r_sq < c_r^2));

idx = union(idx1,idx2);


vx_new(:,idx) = [];
vy_new(:,idx) = [];

% figure(4);
% set(gcf,'numbertitle','off','name', '������Ʈ�ݿ�');
% contour(x_2d_s,y_2d_s,z_2d_s,'ShowText','on');
% xlabel('km');
% ylabel('km');
% hold on;
% plot(vx_new,vy_new,'b.-')
% plot(xn_new,yn_new,'r.');
% h = fill(xc,yc,'red');
% set(h,'facealpha',.5)
% axis([0 N_s 0 N_s]);


%5�ܰ� �������

% �������κ��� ������ ���� ������ �Ÿ�(km)
height = 5;

% xpoint = [10;49;22;46;14;30];
% ypoint = [10;42;53;13;29;17];

%xpoint = [14; 10; 10];
%ypoint = [29; 55; 10];

% ���� 1
% xpoint = [35; 83];
% ypoint = [95; 59];

% ���� 2
% xpoint = [43; 100];
% ypoint = [105; 60];

% ���� 3
% xpoint = [33; 75];
% ypoint = [102; 50];

% ���� 4
% xpoint = [10; 90];
% ypoint = [90; 50];

% ���� 4 - part
xpoint = [10; 50];
ypoint = [90; 50];

%order = tsp(xpoint,ypoint);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2����Ʈ�� ���Ͽ� ����
if(length(xpoint) > 3)
    order = tsp(xpoint, ypoint);
    
else
    order = [1 2];
    
end

% figure(5);
set(gcf,'numbertitle','off','name', '�������');
hold on;

lgd = legend('�����','������');
lgd.AutoUpdate = 'off';
contour(x_2d_s,y_2d_s,z_2d_s,'ShowText','on');
xlabel('km');
ylabel('km');

% plot(vx_new,vy_new,'b.-');
plot(xn_new,yn_new,'r.');
h = fill(xc,yc,'red');
set(h,'facealpha',.5);
axis([0 N_s 0 N_s]);

% ��ȸ ��� �� ����
path_length_all = 0;

part_length = [];

% �ִ� ��� ����(�ִ� ��� ��)
max_flight_height = 1000;

%% ��� 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z�� ����
z_alpha = 20;

% ��ֹ� ��ġ �ľ�
x_obs = [];
y_obs = [];

count_obs = 0;

% ������ ������ : y = ax + b
res = polyfit(xpoint, ypoint, 1);
x_equation = xpoint(1) : (x_s(2)-x_s(1)) : xpoint(2);
y_equation = res(1)*x_equation + res(2);

% ��� �� �ϰ����� ���̰� ���� ����
z_lift_height = [];
% flight height�� �ݿ��� ���� ����
lift_height = [];

y_index = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���� ��ο� �ִ� ������ ��ġ�ϴ� y ���� ã��
for i = 1 : length(y_equation)

    flag = 0;

    for j = 2 : N_s-1
        num = find( y_equation(i) == y_s(j) );

        if(num)
            y_equation(i) = y_s(j);
            flag = 1;
            break;

        else
            flag = 0;

        end

    end

    if(flag == 0)
        y_equation(i) = y_s(knnsearch(y_s', y_equation(i)));

    end

    y_index(i) = knnsearch(y_s', y_equation(i));

end

%x_equation
%y_equation

lift_height = [];



obs_index = [];

% ��ֹ��� ����
count_obs = 0;

% ���� ��ο� �ִ� ������ ��ġ�ϴ� z ���� ã��
for k = 1 : length(y_equation)
    for i = 1 : N_s
        
        % x�� ������ ���� 2d���� ã��
        if(find( x_equation(k) == x_s(i) ))
            z_lift_height(k) = z_2d_s( (y_index(k)-1)*N_s + i );
            
            if(z_lift_height(k) < flight_height)
                lift_height(k) = flight_height;
                
%             elseif(z_lift_height(k) == flight_height)
                count_obs = count_obs + 1;
%                 lift_height(k) = z_lift_height(k);
                obs_index(count_obs) = k;

            else
                lift_height(k) = z_lift_height(k);

            end
            
        end


    end

end

% z_lift_height

% plot3(x_equation, y_equation, lift_height + z_alpha, 'black', 'LineWidth',4);

%% ��°� ���ϱ�

% obs_index

% ��ֹ��� ��ġ ���� ����
x_obs = [];
y_obs = [];

th = [];

% x_equation
% y_equation
% lift_height

% for k = 1 : length(y_equation)
%         
%     if((lift_height(k)-3) == flight_height)
%         % ��ֹ� ��ġ �ľ�
% %         count_obs = count_obs + 1;
%         x_obs(count_obs) = x_equation(k);
%         y_obs(count_obs) = y_equation(k);
%         
%         z_obs(count_obs) = lift_height(k);
% 
%     end
% 
% end 

temp_away = 5;

% k == obs_index(i)
for i = 1 : count_obs
    
    k = obs_index(i);
    
    if( (k > temp_away) && (k ~= obs_index(end)) )
        
%         disp('yes');

        if( lift_height(k) < lift_height(k+1) )
%             disp('up');

    %         y_equation(k+1)
    %         y_equation(k)
    %         x_equation(k+1)
    %         x_equation(k)

            a = ( (lift_height(k+1) - lift_height(k-temp_away)) / (x_equation(k+1) - x_equation(k-temp_away)) );
            th_temp = atan(a);
            % radian -> degree
            th(i) = th_temp * 180 / pi;

        elseif( lift_height(k) < lift_height(k-1) )
    %         disp('down');

        else
    %         disp('nothing');

        end
        
    end

end

% x_obs
% y_obs
% z_obs

count_obs

th

%% ��ü ��� ��� ���� ���ϱ�

% ��� �� �ϰ� ��� �� ����
lift_length = 0;
%z_lift_height
lift_length_part = [];
%lift_heigth

for i = 1 : length(y_equation)-1
    lift_length_part(i) = sqrt( (x_equation(i+1)-x_equation(i))^2 + (y_equation(i+1)-y_equation(i))^2 + ( (lift_height(i+1)-lift_height(i))/1000 )^2 );

    lift_length = lift_length + sqrt( (x_equation(i+1)-x_equation(i))^2 + (y_equation(i+1)-y_equation(i))^2 + ( (lift_height(i+1)-lift_height(i))/1000 )^2 );

end

disp('��ü ��� ��� ����');
lift_length

%% 
for mainloof = 1 : length(order)-1

    xy_start = [xpoint(order(mainloof)) ypoint(order(mainloof))];
    xy_dest = [xpoint(order(mainloof+1)) ypoint(order(mainloof+1))];
    
    %��� �� �ϰ�
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % �߰� 
    
    x_obs_pos = []; 
    y_obs_pos = [];
    
    x_obs_location = [];
    y_obs_location = [];
    
    obs_pos = [];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ��ֹ� ��ġ �ľ�
    x_obs = [];
    y_obs = [];
    
    count_obs = 0;
    
    % ������ ������ : y = ax + b
    res = polyfit(xpoint, ypoint, 1);
    x_equation = xpoint(1) : (x_s(2)-x_s(1)) : xpoint(2);
    y_equation = res(1)*x_equation + res(2);
    
    % ��� �� �ϰ����� ���̰� ���� ����
    z_lift_height = [];
    % flight height�� �ݿ��� ���� ����
    lift_height = [];
    
    y_index = [];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ���� ��ο� �ִ� ������ ��ġ�ϴ� y ���� ã��
    for i = 1 : length(y_equation)

        flag = 0;

        for j = 2 : N_s-1
            num = find( y_equation(i) == y_s(j) );

            if(num)
                y_equation(i) = y_s(j);
                flag = 1;
                break;

            else
                flag = 0;

            end

        end

        if(flag == 0)
            y_equation(i) = y_s(knnsearch(y_s', y_equation(i)));

        end

        y_index(i) = knnsearch(y_s', y_equation(i));

    end

    %x_equation
    %y_equation

    % ���� ��ο� �ִ� ������ ��ġ�ϴ� z ���� ã��
    for k = 1 : length(y_equation)
        for i = 1 : N_s

            % x�� ������ ���� 2d���� ã��
            if(find( x_equation(k) == x_s(i) ))
                z_lift_height(k) = z_2d_s( (y_index(k)-1)*N_s + i );
                
                if(z_lift_height(k) < flight_height)
                    lift_heigth(k) = flight_height;
                    
                    z_lift_height(k) = 300 + z_lift_height(k);
                    
                else
                    % ��ֹ� ��ġ �ľ�
                    count_obs = count_obs + 1;
                    x_obs(count_obs) = x_equation(k);
                    y_obs(count_obs) = y_equation(k);
                    
                    lift_heigth(k) = z_lift_height(k);
                    
                end

            end


        end

    end

    %z_lift_height
    lift_length_part = [];
    %lift_heigth
    
%     for i = 1 : length(y_equation)-1
%         lift_length_part(i) = sqrt( (x_equation(i+1)-x_equation(i))^2 + (y_equation(i+1)-y_equation(i))^2 + ( (lift_heigth(i+1)-lift_heigth(i))/1000 )^2 );
%         
%         lift_length = lift_length + sqrt( (x_equation(i+1)-x_equation(i))^2 + (y_equation(i+1)-y_equation(i))^2 + ( (lift_heigth(i+1)-lift_heigth(i))/1000 )^2 );
%         
%     end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    z_alpha = 10;
    
%     if(z_lift_height < flight_height)
%         z_lift_height = z_lift_height + flight_height;
%         
%     end
    
    % ��� �� �ϰ� ����
    figure(3)
    % making 3D MAP
    meshc(x_2d_s, y_2d_s, z_2d_s);
    hold on;
%     plot3(x_equation, y_equation, z_lift_height + z_alpha, 'black', 'LineWidth',4);
    plot3(x_equation, y_equation, lift_heigth + z_alpha, 'red', 'LineWidth',4);
    
    
    for i = 1 : length(x_equation)
        
        x_obs_pos = find(x_equation(i) == xn_new);
        y_obs_pos = find(y_equation(i) == yn_new);
        
    end
    
    for i = 1 : length(x_obs_pos)
        obs_pos = find(x_obs_pos(i) == y_obs_pos);
        %obs_pos
        
        if(obs_pos)
            x_obs_location(i) = xn_new(x_obs_pos(obs_pos));
            y_obs_location(i) = yn_new(y_obs_pos(obs_pos));
            
        end
         
    end
    
    % ���� ����
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    vx_all = vx_new(:);
    vy_all = vy_new(:);

    dr = kron(ones(length(vx_all),1),xy_start)-[vx_all vy_all];
    [min_val,min_id] = min(sum(dr.^2,2));

    vx_new = [vx_new [xy_start(1); vx_all(min_id)]];
    vy_new = [vy_new [xy_start(2); vy_all(min_id)]];

    dr = kron(ones(length(vx_all),1),xy_dest)-[vx_all vy_all];
    [min_val,min_id] = min(sum(dr.^2,2));

    vx_new = [vx_new [xy_dest(1); vx_all(min_id)]];
    vy_new = [vy_new [xy_dest(2); vy_all(min_id)]];

    xy_all = unique([vx_new(:) vy_new(:)],'rows');
    dv = [vx_new(1,:); vy_new(1,:)] - [vx_new(2,:); vy_new(2,:)];
    edge_dist = sqrt(sum(dv.^2));

    G = sparse(size(xy_all,1),size(xy_all,1));

    for kdx = 1:length(edge_dist)
        xy_s = [vx_new(1,kdx) vy_new(1,kdx)];
        idx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_s)).^2,2)==0);
        xy_d = [vx_new(2,kdx) vy_new(2,kdx)];
        jdx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_d)).^2,2)==0);
        G(idx,jdx) = edge_dist(kdx);
        G(jdx,idx) = edge_dist(kdx);
    end

    st_idx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_start)).^2,2)==0);
    dest_idx = find(sum((xy_all-kron(ones(size(xy_all,1),1),xy_dest)).^2,2)==0);

    [dist,paths,pred] = graphshortestpath(G,st_idx,dest_idx);
    xy_opt_path = xy_all(paths,:);
    % for i = 1 : length(xy_opt_path)
    %    
    % end
    %1���� ������ ȹ��
    d_r = 1.4;
    d_r2 = 0.9;
    xd = xy_opt_path(:,1); 
    yd = xy_opt_path(:,2);
    trues = zeros(1,length(xy_opt_path));
    for i = 1 : length(xy_opt_path)
        r_sq = (xd(i)-xn_new).^2+(yd(i)-yn_new).^2;
        idx1 = find((r_sq < d_r^2));
        r_sq = (xd(i)-xc).^2+(yd(i)-yc).^2;
        idx2 = find((r_sq < d_r2^2));

        if (isempty(idx1)==1) && (isempty(idx2)==1)
            trues(i) = 1;
        end
    end
    
%     % ���� ��� ������
%     ttemp_xy_path_all{mainloof} = xy_opt_path;
% 
%     rootCount = 0;
% 
%     % ��ü ��� ���� ������ ���
%     path1 = 0;
% 
%     for i = 1 : length(xy_opt_path)-1
% 
%         path_part = sqrt((xy_opt_path(i,1) - xy_opt_path(i+1,1))^2 + (xy_opt_path(i,2) - xy_opt_path(i+1,2))^2);
%         path1 = path_part + path1;
%         %part_length(i) = path_part;
% 
%     end
% 
%     path_length(mainloof) = path1;
%     %part_length_all{mainloof} = part_length;
% 
% %         path_length_all = path_length(mainloof) + path_length_all;
%     path_length_all = path1 + path_length_all;
    
    figure(1);
    plot(xy_start(1),xy_start(2),'S',xy_dest(1),xy_dest(2),'D','MarkerSize',10, 'MarkerFaceColor','black');
%     plot(xy_opt_path(:,1),xy_opt_path(:,2), 'green', 'LineWidth',4);
    
    
    
%     for i = 1 : length(xy_opt_path)
%         if trues(i) == 0
%             xx = [xy_opt_path(i,1) xy_opt_path(i+1,1)];
%             yy = [xy_opt_path(i,2) xy_opt_path(i+1,2)];
%             plot(xx,yy, 'r-','LineWidth',3);
%         end
%     end
    %���߿� �ذ�    
    
    
    figure(2)
    % making 3D MAP
    meshc(x_2d_s, y_2d_s, z_2d_s);
    hold on;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % z ���� ������ ����
    
    zd = [];
    z_data = [];
    
    for i = 1 : length(xd)
        
        pos_x = 10000;
        pos_y = 10000;
        
        x_data = 0;
        y_data = 0;
        
        % ���� ����� ��ġ�� ����
        for j = 1 : length(x_s)
           
            x_length = abs( x_s(j) - xd(i) );
            y_length = abs( y_s(j) - yd(i) );
            
            if( pos_x > x_length )
                pos_x = x_length;
                
                x_data = x_s(j);
            else
                pos_x = pos_x;
                x_data = x_data;
            end
            
            if( pos_y > y_length )
                pos_y = y_length;
                y_data = y_s(j);
            else
                pos_y = pos_y;
                y_data = y_data;
            end
            
        end
        
        % �ش� ��ġ�� x��ǥ�� ���� y��ǥ�� ���� ã�� ����
        temp_pos_x = find( x_data == x_2d_s );
        temp_pos_y = find( y_data == y_2d_s );
        temp_pos_z = 0;
        
        for k = 1 : length(temp_pos_x)
            temp = find( temp_pos_x(k) == temp_pos_y );
            
            if( temp )
                temp_pos_z = temp;
                
                z_data(i) = z_2d_s(temp_pos_z);
                
                % ����� ���� ���
                if( z_data(i) < flight_height )
                    z_data(i) = flight_height + height;
                end
                
            else
                temp_pos_z = temp_pos_z;
                
            end
            
        end
        
    end
    
    %z_data
    
    % ��ȸ ���� ��� ������
    ttemp_xy_path_all{mainloof} = xy_opt_path;

    rootCount = 0;

    % ��ü ��� ���� ������ ���
    path1 = 0;

    for i = 1 : length(xy_opt_path)-1

        path_part = sqrt((xy_opt_path(i,1) - xy_opt_path(i+1,1))^2 + (xy_opt_path(i,2) - xy_opt_path(i+1,2))^2 + ( (z_data(i+1)-z_data(i)) /1000)^2);
        path1 = path_part + path1;
        part_length(i) = path_part;

    end

    path_length(mainloof) = path1;
    part_length_all{mainloof} = part_length;

%     path_length_all = path_length(mainloof) + path_length_all;
    path_length_all = path1 + path_length_all;

    % using plot3 function   ex. plot3(x1, y1, z1, ...)
    plot3(xy_opt_path(:,1),xy_opt_path(:,2), z_data, 'red', 'LineWidth',4);
    
    
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
end

disp('��ü ��ȸ ��� ����');
path_length_all






















