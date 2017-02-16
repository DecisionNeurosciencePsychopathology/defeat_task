function simple_ui
% simple_ui creates a user interface with text and different buttons that you can
% push to make a choice
clear all
close all

% create the list of names and ranks
names = {'Sherman' 'Woodrow' 'Rosaria' 'Rashad' 'Larita' 'Danna' 'Jacques' 'Cassi' 'Garth' 'Merilyn' 'Chanel' 'Bernardina' 'Mathew' 'Jenell' 'Bee' '>YOU<' 'Jackie' 'Leanora' 'Chantell' 'Oscar' 'Joleen' 'Gerald' 'Ronald' 'Carlyn' 'Mariette' 'Tera' 'Philip' 'Justina' 'Karrie' 'Forest' 'Sharyn'}
ranks = [1:length(names)]

% create the ranking in the figure
for i = 1:length(ranks)
    ranking(i,:) = {sprintf('%d. %s',ranks(i), names{i})};
end

% create radiobuttons for challengable opponents in a range of 5 above and under player
current_ranking = strmatch('>YOU<', names)

% create the user interface window
f = figure('Visible','on','MenuBar','none','Toolbar', 'none', 'Position',[360,50,450,800])
set(gca,'visible','off')
% create a button-group
bg = uibuttongroup('Visible','off','Position',[0 0 1 1])
bg.Visible = 'on'

% create radiobuttons for challengable opponents above and under player
for i = [max(1,current_ranking-5):current_ranking-1, current_ranking+1:min(length(names),current_ranking+5)]
    hopponent (i) = uicontrol(bg,'Style','radiobutton','String',ranking{i},'Position',[200,790-25*i,100,15],'HandleVisibility','on')
end

% create the player's box in the ranking
    hopponent(current_ranking) = uicontrol('Style','text','String',ranking{current_ranking},'Position',[200,790-25*current_ranking,100,15],'BackgroundColor','y')

% create the others' box in the ranking
for i = [1:current_ranking-6, current_ranking+6:length(ranks)]
    hopponent(i) = uicontrol('Style','text','String',ranking{i},'Position',[200,790-25*i,100,15],'BackgroundColor',[0.9400 0.9400 0.9400])
end

%add a challenge button to confirm choice of opponent and start the game
start_button = uicontrol('Style','pushbutton','String','Start the game','Position',[350,400,80,50],'Callback','Start_round','BackgroundColor','g')

%retrieves information about the opponent's ranking
choice = bg.SelectedObject
chosen_opponent = getfield(choice,'String')
opponent_ranking = strmatch(chosen_opponent, ranking)
opponent_name = names(opponent_ranking)
diff_player_opponent = current_ranking - opponent_ranking

% save information about opponent in a .csv file
fopponent = fopen('opponents.csv','w');
fprintf(fopponent,'\n Round;1;Current ranking;%d;Opponent''s name;%s;Opponent''s ranking;%d;Diff(player-opponent);%d', current_ranking, opponent_name{1}, opponent_ranking, diff_player_opponent)
fclose(fopponent)
end