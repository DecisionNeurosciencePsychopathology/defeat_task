#!/usr/bin/python

from Tkinter import *
from random import randrange

def recoupeQ():
	global x, y, snake, flag
	i = 0
	while i < len(snake):
		tmp = snake[i]
		if (tmp[0] == x) and (tmp[1] == y):
			break
		i += 1
	if i != len(snake):
		flag = 0
		perdu()

def start(event):
	global flag, timeout
	if flag == 2:
		flag = 1
		fen.bind('<Up>', thaut)
		fen.after(timeout, exitScore)
		move()

def dessine():
	global snake, pomme, points
	can.delete(ALL)
	i = 0
	while i < len(snake):
		tmp = snake[i]
		can.create_rectangle(tmp[0], tmp[1], tmp[0]+tmp[2], tmp[1]+tmp[2], fill = 'green')
		i += 1
	Label(fen, text = str(points), width = 8, height = 1).grid(row = 1, column = 1)
	if len(pomme) > 0:
		can.create_oval(pomme[0], pomme[1], pomme[0] + pomme[2], pomme[1] + pomme[2], fill = 'red')

def move():
	global snake, x, y, dx, dy, flag, points
	x = (x + dx) % 500
	y = (y + dy) % 500
	
	recoupeQ()
	snake[0:0] = [[x, y, 10]]
	pommeQ()
	dessine()
	if flag == 1:
		fen.after((80 - 2 * (points/3)), move)

def pommeQ():
	global x, y, pomme, points
	if (x == pomme[0]) and (y == pomme[1]):
		points += 1
		apple()
	else:
		del(snake[len(snake) - 1])

def apple():
	global pomme, snake
	px = randrange(50) * 10 + 1
	py = randrange(50) * 10 + 1
	flag = 0
	while flag != 1:
		i = 0
		while i < len(snake):
			tmp = snake[i]
			if (tmp[0] == px) and (tmp[1] == py):
				break
			i += 1
		if i == len(snake):
			flag = 1
		else:
			px = randrange(50) * 10 + 1
			py = randrange(50) * 10 + 1
	pomme = [px, py, 10]


def thaut(event):
	global dx, dy
	if (dx != 0) and (dy == 0):
		dx = 0
		dy = -10

def tbas(event):
	global dx, dy
	if (dx != 0) and (dy == 0):
		dx = 0
		dy = 10

def tgauche(event):
	global dx, dy
	if (dy != 0) and (dx == 0):
		dy = 0
		dx = -10

def tdroite(event):
	global dx, dy
	if (dy != 0) and (dx == 0):
		dy = 0
		dx = 10

def perduQ(x, y):
	if (x > 500) or (x < 0) or (y > 500) or (y < 0):
		return 1
	else:
		return 0

def perdu():
	exitScore()

def exitScore():
	fen.destroy()
	exit(points)


## Constantes


snake = [[241, 241, 10], [241, 251, 10]] #, [241, 261, 10], [241, 271, 10], [241, 281, 10], [241, 291, 10], [241, 301, 10], [241, 311, 10], [241, 321, 10], [241, 331, 10]]
x, y, dx, dy, flag = 241, 241, 0, -10, 2
timeout = 45000 # in milliseconds, 60s = 1min
points = 0
pomme = []

## Creation de la fenetre principale, canevas et boutons

fen = Tk()
can = Canvas(fen, height = 501, width = 501, bg = 'light grey')
can.grid(row = 0, rowspan = 20, column = 0, padx = 3, pady = 3)
Label(fen, text = 'Score :', width = 8, height = 1).grid(row = 0, column = 1)
Label(fen, text = str(points), width = 8, height = 1).grid(row = 1, column = 1)
#Button(fen, text = 'Jouer', width = 8, command = move).grid(row = 2, column = 1)
#Button(fen, text = 'Pause', width = 8, command = pause).grid(row = 3, column = 1)
#Button(fen, text = 'Quitter', width = 8, height = 1, command = fen.destroy).grid(row = 19, column = 1)

dessine()
apple()

fen.bind('<Down>', tbas)
fen.bind('<Right>', tdroite)
fen.bind('<Left>', tgauche)
fen.bind('<Up>', start)
#fen.bind('<Return>', start)
fen.mainloop()
