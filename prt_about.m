%% prt_about
% generates ../about.html, ../img/png's

%%
function prt_about
%% created 2016/02/23 by Bas Kooijman; modified 2016/04/26, 2016/06/02

%% Syntax
% <../prt_about *prt_about*>

%% Description
% Runs plotting routines, creates png-files and link them in an html-file
%
% Output: 
%
%  * files are written in ../img: 
%
%      - entries.png, 
%      - pie_Animal.png
%      - pie_model.png  
%      - COMPLETE.png
%      - MRE.png
%      - COMPLETE_MRE.png
%      - Fm.png
%      - kapX.png
%      - pAm.png
%      - v.png
%      - kap.png
%      - pM.png
%      - EG.png
%      - kJ.png
%      - EHb.png
%      - EBp.png
%      - ha.png
%      - sG.png
%
% * file is written in ../about.html 

%% Remarks
% Copy png files to 
%   /home/websites/www.bio.vu.nl/webroot/thb/deb/deblab/add_my_pet/img
% and about.html file to
%   /home/websites/www.bio.vu.nl/webroot/thb/deb/deblab/add_my_pet
% to present them on the web.
% Don't forget to refresh species_tree_js with prt_species_tree_js.m

close all
clear all

% write_allStat; % update Staristics structure allStat.mat

pie_Animalia;
tightfig;
saveas (gca, '../img/pie_Animalia.png')
close all

pie_model;
tightfig;
saveas (gca, '../img/pie_model.png')
close all

% # of entries in time
[dates entries_new dates_new] = get_date_subm;
surv_dates = surv(dates, 2006); 
surv_dates([1; end - 1; end],:) = [];    
n = size(surv_dates, 1)/2;
    
plot(surv_dates(:,1), n * (1 - surv_dates(:,2)), 'b', 'Linewidth', 2)
set(gca, 'FontSize', 15, 'Box', 'on')
xlabel('time, yr')
ylabel('# of add\_my\_pet entries')
xlim([2009; max(dates)])
saveas (gca,'../img/entries.png')
close all

% COMPLETE, MRE plots
CM = read_allStat('COMPLETE', 'MRE'); n_entries = size(CM,1);
C_median = median(CM(:,1)); M_median = median(CM(:,2));
plot(CM(:,1), CM(:,2), '.b', 'MarkerSize', 20)
set(gca, 'FontSize', 15, 'Box', 'on')
xlabel('COMPLETE')
ylabel('MRE')
saveas (gca,'../img/COMPLETE_MRE.png')
close all

surv_COMPLETE = surv(CM(:,1),0);
plot([0; C_median; C_median], [0.5;0.5;0], 'r', surv_COMPLETE(:,1), surv_COMPLETE(:,2), 'b', 'Linewidth', 2)
set(gca, 'FontSize', 15, 'Box', 'on')
xlabel('COMPLETE')
ylabel('survivor function')
saveas (gca,'../img/COMPLETE.png')
close all

surv_MRE = surv(CM(:,2),0);
plot([0; M_median; M_median], [0.5;0.5;0], 'r', surv_MRE(:,1), surv_MRE(:,2), 'b', 'Linewidth', 2)
set(gca, 'FontSize', 15, 'Box', 'on')
xlabel('Mean Relative Error')
ylabel('survivor function')
saveas (gca,'../img/MRE.png')
close all

shprimpar % primary parameters

% Write about.html
path = 'entries_web/results_'; % path to entries
fid_about = fopen('../about.html', 'w+'); % open file for writing, delete existing content

fprintf(fid_about, '<!DOCTYPE html>\n');
fprintf(fid_about, '<HTML>\n');
fprintf(fid_about, '<HEAD>\n');
fprintf(fid_about, '  <TITLE>About AmP</TITLE>\n');
fprintf(fid_about, '  <link rel="stylesheet" type="text/css" href="sys/style.css"> \n');
fprintf(fid_about, '  <script src="sys/dropdown.js"></script>\n');
fprintf(fid_about, '</HEAD>\n');
fprintf(fid_about, '<BODY>\n\n');

fprintf(fid_about, '<!-- image with stays fixed in the background  -->\n');
fprintf(fid_about, '<div id="h1_container">\n');
fprintf(fid_about, '  <h1>\n');
fprintf(fid_about, '    <!--  Add-my-pet -->\n');
fprintf(fid_about, '    <img alt="add-my-pet" src = "img/addmypet.png"  width = "400px"> \n'); 
fprintf(fid_about, '  </h1>\n');
fprintf(fid_about, '</div>\n\n');

fprintf(fid_about, '<!-- image with stays fixed in the background  -->\n');
fprintf(fid_about, '<div id="h2_container">\n');
fprintf(fid_about, '  <h1>\n');
fprintf(fid_about, '    <img alt="add-my-pet" src = "img/bannercycle.png"  > \n');
fprintf(fid_about, '  </h1>\n');
fprintf(fid_about, '</div>\n\n');

fprintf(fid_about, '<!--------------------------------------------------------------->\n');
fprintf(fid_about, '<!--   PART 1                                                  -->\n');
fprintf(fid_about, '<!--   TOP PART OF WEBPAGE IS FIXED                            -->\n');
fprintf(fid_about, '<!--   It has the logo and the menu with Javascript            -->\n');
fprintf(fid_about, '<!--  dropdown menus                                           -->\n');
fprintf(fid_about, '<!--  Please put in bold and in fancy the right links          -->\n');
fprintf(fid_about, '<!--------------------------------------------------------------->\n');
fprintf(fid_about, '<div id="top"> \n');
fprintf(fid_about, '  <div class="logo">\n');  
fprintf(fid_about, '    <a href="http://www.bio.vu.nl/thb/deb/deblab/"><img src="img/bannercycle.png"  height = "60px"></a>\n');
fprintf(fid_about, '  </div>\n\n');
fprintf(fid_about, '  <div id="navwrapper">\n');
fprintf(fid_about, '    <div class = "dropdown"><button onclick="context()" class="dropbtn">CONTEXT</button>\n');
fprintf(fid_about, '      <div id="contextDropdown" class="dropdown-content">\n');
fprintf(fid_about, '        <a href="index.html" >Pet Portal</a>\n');
fprintf(fid_about, '        <a href="http://http://www.debtheory.org/wiki/index.php?title=Main_Page/" target="_blank">DEB Portal</a>\n');
fprintf(fid_about, '        <a href="http://www.bio.vu.nl/thb/deb/" target="_blank">DEB info</a>\n');
fprintf(fid_about, '        <a href="http://www.bio.vu.nl/thb/deb/deblab/" target="_blank">DEBlab</a>\n');
fprintf(fid_about, '      </div>\n');
fprintf(fid_about, '    </div>\n\n');
fprintf(fid_about, '    <div class = "dropdown"><button onclick="collection()" class="dropbtn"><b>COLLECTION</b></button> <!--   notice that collection should be bold because we are in about  -->\n');
fprintf(fid_about, '      <div id="collectionDropdown" class="dropdown-content">\n');
fprintf(fid_about, '        <a href="species_list.html">Species List</a>\n');
fprintf(fid_about, '        <a href="species_tree.html">Species Tree</a>\n');
fprintf(fid_about, '        <a class="menu" href="about.html">About</a>\n');
fprintf(fid_about, '      </div>\n');
fprintf(fid_about, '    </div>\n\n');
fprintf(fid_about, '    <div class = "dropdown"><button onclick= "window.open(''http://www.debtheory.org/wiki/index.php?title=Add-my-pet_Introduction'', ''_blank'')" class="dropbtn"> WIKI</a></button>\n');
fprintf(fid_about, '    </div>\n');
fprintf(fid_about, '  </div> <!-- end navwrapper -->\n');
fprintf(fid_about, '</div> <!-- end top -->\n\n');

fprintf(fid_about, '<!--------------------------------------------------------------->\n');
fprintf(fid_about, '<!--   PART 2                                                  -->\n');
fprintf(fid_about, '<!--   Where all of the text is placed                         -->\n');
fprintf(fid_about, '<!--   use "contentFull" for 1 column                          -->\n');
fprintf(fid_about, '<!--   use "content" if you want two columns"                  -->\n');
fprintf(fid_about, '<!--------------------------------------------------------------->\n'); 
fprintf(fid_about, '<div id = "main">\n');
fprintf(fid_about, '  <div id = "main-wrapper">    \n');
fprintf(fid_about, '    <div id="content">\n');

%%
fprintf(fid_about, '    <H1 id = "portaltop">About Add-my-pet</H1>\n'); 
fprintf(fid_about, '    <H2 id = "aims">Overview of the collection</H2>\n\n');


fprintf(fid_about, '    <div class="sidelement2">\n');
fprintf(fid_about,['      <img src="img/pie_','Animalia','.png" width="350px">\n']);
fprintf(fid_about, '      <div class = "caption">   \n');
fprintf(fid_about, '        The collection is complete for large <a href="phyla.html" target="_blank">phyla</a> (perhaps excluding the sponges). \n');
fprintf(fid_about, '        Chordates are complete at order level, primates at family level.\n');
fprintf(fid_about, '      </div>\n');
fprintf(fid_about, '    </div>\n\n');
fprintf(fid_about, '    <div class="sidelement2">\n');
fprintf(fid_about,['      <img src="img/pie_','model.png" width="350px"> \n']);
fprintf(fid_about, '        <div class = "caption">   \n');
fprintf(fid_about, '          A <a href="http://www.debtheory.org/wiki/index.php?title=Typified_models" TARGET="_blank">variety of related models</a> captures animal life-cycle diversity and quantifies properties in <a href="pars.html" target="_blank">parameters</a>.\n');
fprintf(fid_about, '        </div>\n');
fprintf(fid_about, '      </div>\n\n');
fprintf(fid_about, '      <H2 class="clear"> Data completeness and mean relative errors</H2>\n\n');  
fprintf(fid_about, '      <div class="sidelement2">\n');
fprintf(fid_about,['        <img src="img/COMPLETE.png" width','="350px">\n']);
fprintf(fid_about, '        <div class = "caption">   \n');
fprintf(fid_about, '          Survivor function of <a href="http://www.debtheory.org/wiki/index.php?title=Completeness" TARGET="_blank">data completness</a>.\n');
fprintf(fid_about, '        </div>\n');
fprintf(fid_about, '      </div>\n\n');
fprintf(fid_about, '      <div class="sidelement2">\n');
fprintf(fid_about,['        <img src="img','/MRE.png" width="350px">\n']);
fprintf(fid_about, '        <div class = "caption">   \n');
fprintf(fid_about, '          Survivor function of the <a href="http://www.debtheory.org/wiki/index.php?title=Add-my-pet_Introduction#Data_quality_and_availability" TARGET="_blank">Mean Relative Error (MRE)</a>.\n');
fprintf(fid_about, '        </div>\n');
fprintf(fid_about, '      </div>\n\n');
fprintf(fid_about, '      <div class="sidelement2">\n');
fprintf(fid_about,['        <img src="img/COMPLETE','_MRE.png" width="350px">\n']);
fprintf(fid_about, '        <div class = "caption">   \n');
fprintf(fid_about, '          The relationship between the mean relative error and data completeness. \n');
fprintf(fid_about, '        </div>\n');
fprintf(fid_about, '      </div>\n\n');
        
fprintf(fid_about, '      <H2 id="disclaimer" class = "clear"> Disclaimer</H2>\n\n');    
fprintf(fid_about, '      <p>\n');
fprintf(fid_about, '      Add-my-pet is optimized for learning, training and research.\n');
fprintf(fid_about, '      Some of the text on this website might be simplified to improve reading and basic understanding.\n');
fprintf(fid_about, '      Files, references, and code are constantly reviewed to avoid errors, but we cannot warrant full correctness of all content.\n');
fprintf(fid_about, '      <p>\n');
fprintf(fid_about, '      The entries continue to change as the collection grows for several reasons: \n');
fprintf(fid_about, '      errors are spotted and corrected; more data is included; assumptions about data quality change; entries are split up by population; \n');
fprintf(fid_about, '      our understanding of what are the best priors to use for particular taxa increases; algorithms for estimation are improved; the model changed. \n');
fprintf(fid_about, '      <p>\n');
fprintf(fid_about, '      Add-my-pet makes explicit a number of wide spread scientific problems such as: data quality, differences between experiments etc. \n');
fprintf(fid_about, '      The resulting parameter estimates depends on a lot of assumptions concerning which data we choose to include and exclude as well as how the data is interpreted\n');
fprintf(fid_about, '      (e.g. what we are willing to assume about the initial conditions of the organism.)\n\n');
fprintf(fid_about, '    <!--------------------------------------------------------------->\n');
fprintf(fid_about, '    <!--   This div closes the content box                         -->\n');
fprintf(fid_about, '    <!--   Do not delete                                           -->\n');
fprintf(fid_about, '    <!--------------------------------------------------------------->\n');
fprintf(fid_about, '    </div> <!-- end of content -->\n\n');
%%
fprintf(fid_about, '    <!--------------------------------------------------------------->\n');
fprintf(fid_about, '    <!--   EDIT the content of the second column                   -->\n');
fprintf(fid_about, '    <!--   remove if we use contentFull (see above)                -->\n');
fprintf(fid_about, '    <!--------------------------------------------------------------->\n');

fprintf(fid_about, '    <div id = "sidebar">\n\n');  
fprintf(fid_about, '      <H1 id = "portaltop"> &nbsp;</H1> <!--   Notice that I put this here to make heading across both columns even  -->\n');   
fprintf(fid_about, '      <H2 class="clear"> Entries in time </H2>\n\n');

fprintf(fid_about, '      <div class="sidelement">\n');
fprintf(fid_about,['        <img src="img/','entries.png" width="350px">\n']);
fprintf(fid_about, '        <div class = "caption">   \n');
fprintf(fid_about, '          The add-my-pet collection started at 2009/02/12 as part of the \n');
fprintf(fid_about, '          <A HREF ="http://deb.akvaplan.com/teledescription.html" target="_blank">DEB tele course</A>.\n');
fprintf(fid_about,['          It has ', num2str(n_entries), ' entries at ', datestr(date,26), '\n']);
fprintf(fid_about, '        </div>\n');
fprintf(fid_about, '      </div>\n\n');
    
fprintf(fid_about, '      <!--------------------------------------------------------------->\n');
fprintf(fid_about, '      <!--  Latest entries                                           -->\n');
fprintf(fid_about, '      <!---------------------------------------------------------------> \n');
fprintf(fid_about, '      <TABLE id="t02">\n');
fprintf(fid_about, '        <TR><TH colspan="2"><b>Latest additions to the collection:</b></TH></TR>\n');
fprintf(fid_about, '        <TR>\n');
fprintf(fid_about,['          <TD WIDTH=300><a HREF = "', path, entries_new{1}, '.html "><I>', entries_new{1}, '</I></a></TD>\n']);
fprintf(fid_about,['          <TD WIDTH=100>', dates_new(1,:), '</TD>\n']);
fprintf(fid_about, '        </TR>\n');
fprintf(fid_about, '        <TR>\n');
fprintf(fid_about,['          <TD WIDTH=300><a HREF = "', path, entries_new{2}, '.html "><I>', entries_new{2}, '</I></a></TD>\n']);
fprintf(fid_about,['          <TD WIDTH=100>', dates_new(2,:), '</TD>\n']);
fprintf(fid_about, '        </TR>\n');
fprintf(fid_about, '        <TR>\n');
fprintf(fid_about,['          <TD WIDTH=300><a HREF = "', path, entries_new{3}, '.html"><I>', entries_new{3}, '</I></a></TD>\n']);
fprintf(fid_about,['          <TD WIDTH=100>', dates_new(3,:), '</TD>\n']);
fprintf(fid_about, '        </TR>\n');
fprintf(fid_about, '        <TR>\n');
fprintf(fid_about,['          <TD WIDTH=300><a HREF = "', path, entries_new{4}, '.html "><I>', entries_new{4}, '</I></a></TD>\n']);
fprintf(fid_about,['          <TD WIDTH=100>', dates_new(4,:), '</TD>\n']);
fprintf(fid_about, '        </TR>\n');
fprintf(fid_about, '        <TR>\n');
fprintf(fid_about,['          <TD WIDTH=300><a HREF = "', path, entries_new{5}, '.html "><I>', entries_new{5}, '</I></a></TD>\n']);
fprintf(fid_about,['          <TD WIDTH=100>', dates_new(5,:), '</TD>\n']);
fprintf(fid_about, '        </TR>\n');
fprintf(fid_about, '      </TABLE>\n\n');

fprintf(fid_about, '      <H2 class="clear"> Background documentation </H2>\n\n');
    
fprintf(fid_about, '      <p>\n');
fprintf(fid_about, '      <a href="http://www.debtheory.org/wiki/index.php?title=Add-my-pet_Introduction#Add-my-pet_papers" TARGET="_blank">An increasing number of papers has been published on the add-my-pet collection, both on the methodology and ecological and evolutionary patterns in parameter values among species.</a>\n');
                
fprintf(fid_about, '      <p>\n');   
fprintf(fid_about, '      <a href="http://www.bio.vu.nl/thb/deb/DEB_papers.pdf" TARGET="_blank">Many papers have been written on specific entries</a>, which have been cited at entry-pages. \n');
fprintf(fid_about, '    </div> <!-- end of sidebar -->\n\n');
   
fprintf(fid_about, '    <!--------------------------------------------------------------->\n');
fprintf(fid_about, '    <!--   FOOTER                                                  -->\n');
fprintf(fid_about, '    <!---------------------------------------------------------------> \n');  
fprintf(fid_about, '    <div id="footer">\n');
fprintf(fid_about, '      <div class="aligncenter" style="padding:20px">\n');
fprintf(fid_about, '        &#169; 2016 Add-my-pet\n');
fprintf(fid_about, '      </div>\n');
fprintf(fid_about, '    </div>\n');
fprintf(fid_about, '  </div> <!-- main wrapper -->\n');
fprintf(fid_about, '</div> <!-- main -->\n');
% ----------------------------------------------------------
fprintf(fid_about, '</BODY>\n');
fprintf(fid_about, '</HTML>\n');
fclose(fid_about);
