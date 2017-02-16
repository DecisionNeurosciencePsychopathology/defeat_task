function Start_round
%launches the game (45 minutes) and gives the challenge's result

score = system('C:\python27\python.exe snake2.py');

figure('Visible','on','MenuBar','none','Toolbar', 'none', 'Position',[420,260,600,300])
set(gca,'visible','off')
Outcome_window = uicontrol('Style','text','String',sprintf('Your score is %d.\nYou won/lost against your opponent.\nLet''s find out your new position in the ranking.',score),'Position',[150,150,300,50],'BackgroundColor','g')
OK_button = uicontrol('Style','pushbutton','String','OK','Position',[250,100,100,25],'BackgroundColor','w')
end
