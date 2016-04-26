%% mydata_shstat

% generate updated allStat if necessary
% write_allStat(C2K(20),1); % notice that default allStat is at T_typical

% compose your legend if you wish
% mylegend = select_legend; % replace legend_* by mylegend is you active this

close all % remove any existing figure

example = 6; % edit this number
switch example
  case 1 % close to default settings
    shstat_options('default');
    shstat({'g', 'g_Hb'}, legend_RSED); 

  case 2 % more tricks: no transformation (default is log10)
    shstat_options('default');
    shstat_options('x_transform', 'none');
    shstat_options('y_transform', 'none');
    shstat_options('x_label', 'on');
    shstat_options('y_label', 'on');
    [Hfig sskap entries missing] = shstat({'s_s', 'kap'}, legend_vert, date);

    figure(Hfig) % add items to figure
    kap = linspace(0,1,100); ss = kap.^2 .* (1 - kap); 
    plot(ss, kap, 'k', 'Linewidth', 2)

  case 3 % equals 2, but with logarithmic transformation on indpendent variable only
    shstat_options('default');
    %shstat_options('x_transform', 'none');
    shstat_options('y_transform', 'none');
    shstat_options('x_label', 'on');
    shstat_options('y_label', 'on');
    [Hfig sskap entries missing] = shstat({'s_s', 'kap'}, legend_fish, date);

    figure(Hfig) % add items to the plot
    kap = linspace(1e-6,1,100); ss = kap.^2 .* (1 - kap); 
    plot(log10(ss), kap, 'k', 'Linewidth', 2)


  case 4 % 3D plotting: hit rotation-tool in the toolbar of the figure
    shstat_options('default');
    shstat_options('x_transform', 'none');
    shstat_options('y_transform', 'none');
    shstat_options('z_transform', 'none');
    [Hfig sskapep entries missing] = shstat({'s_s', 'kap', 'ep_min'}, legend_vert);
    
    figure(Hfig) % add items to the plot
    kap = linspace(0,1,200); ss = kap .* kap .* (1 - kap); f = (ss * 27/4).^(1/3);
    plot3(ss,kap,f,'k','linewidth',2)
    axis square
    
  case 5 % single variable 
    shstat_options('default');
    shstat_options('x_transform', 'none');
    shstat_options('y_label', 'on');
    [Hfig kap entries missing] = shstat({'kap'});
      
  case 6 % bypass shstat if computations are required
    vsM = read_allStat('v', 's_M'); logv = log10(vsM(:,1)); logvj = log10(prod(vsM,2));
    v_median = median(logv); vj_median = median(logvj);
    surv_v = surv(logv); surv_vj = surv(logvj);
    hold on
    plot([-3.5; vj_median; vj_median], [0.5;0.5;0], 'r', surv_vj(:,1), surv_vj(:,2), 'r', 'Linewidth', 2)
    plot([-3.5; v_median; v_median], [0.5;0.5;0], 'b', surv_v(:,1), surv_v(:,2), 'b', 'Linewidth', 2)
    set(gca, 'FontSize', 15, 'Box', 'on')
    xlabel('_{10} log v, cm/d')
    title('v at T_{ref}, before and after acceleration')

end