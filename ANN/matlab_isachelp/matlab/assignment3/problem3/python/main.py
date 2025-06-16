from Qtable import Qt 
import numpy as np
import time
from matplotlib import pyplot as plt
import csv
import random


def PlayerhasWon(board):
    for x in range(3):
        if 3==abs(sum(board[x,:])):
            return True
    for y in range(3):
        if 3==abs(sum(board[:,y])):
            return True
    c1 = 3==abs(board[0,0]+board[1,1]+board[2,2])
    c2 = 3==abs(board[2,0]+board[1,1]+board[0,2])
    return c1 or c2

TGamesTrain = 1*pow(10,4)
TGamesTest = pow(10,3)
mu = 0.3
mucopy = 0.3
alpha=0.3
Q1=Qt(1,alpha)
Q2=Qt(-1,alpha)

for iGame in range(TGamesTrain):
    mu-=mucopy/TGamesTrain
    board = np.array([[0,0,0],[0,0,0],[0,0,0]])
    boardOrder= np.array([[0,0,0],[0,0,0],[0,0,0]])
    for iRound in range(5):
        board,boardOrder = Q1.UpdateBoards(board,boardOrder,mu)
        if PlayerhasWon(board):hasWon=1; break
        if iRound==4:hasWon=0; break
        board,boardOrder = Q2.UpdateBoards(board,boardOrder,mu)
        if PlayerhasWon(board):hasWon=1; break
    if hasWon:
        Q1.UpdateQvalues(board,boardOrder,1,False)
        Q2.UpdateQvalues(board,boardOrder,2,False)
    else:
        Q1.UpdateQvalues(board,boardOrder,1,True)
        Q2.UpdateQvalues(board,boardOrder,2,True)
    if iGame%1000==0: print(iGame)

print('Training Complete')
victories=[]
for iGame in range(TGamesTest):
    board = np.array([[0,0,0],[0,0,0],[0,0,0]])
    boardOrder= np.array([[0,0,0],[0,0,0],[0,0,0]])
    for iRound in range(5):
        board,boardOrder = Q1.UpdateBoards(board,boardOrder,mu)
        if PlayerhasWon(board):hasWon=1; break
        if iRound==4:hasWon=0; break
        board,boardOrder = Q2.UpdateBoards(board,boardOrder,mu)
        if PlayerhasWon(board):hasWon=1; break
    if hasWon:
        player = (np.max(boardOrder)%2)*2-1
        victories.append(player)
    else:
        victories.append(0)
print('Test Complete')
plt.plot(victories)
plt.show() 



f = open('Q1.csv', 'w')
writer = csv.writer(f)
for i in range(6):
    row=Q1.Qtable[i,:]
    c = [np.nan if x==Q1.nan else x for x in row]
    writer.writerow(c)
f.close()

f = open('Q2.csv', 'w')
writer = csv.writer(f)
for i in range(6):
    row=Q2.Qtable[i,:]
    c = [np.nan if x==Q2.nan else x for x in row]
    writer.writerow(c)
f.close()

#play 3 games to check:
for iGame in range(3):
    board = np.array([[0,0,0],[0,0,0],[0,0,0]])
    boardOrder= np.array([[0,0,0],[0,0,0],[0,0,0]])
    for iRound in range(5):
        print(f'board: {board}')
        inputPlayer = int(input())-1
        y=inputPlayer//3
        x=inputPlayer%3
        board[y,x]=1
        boardOrder[y,x]=np.max(boardOrder)+1
        if PlayerhasWon(board):hasWon=1; break
        if iRound==4:hasWon=0; break
        board,boardOrder = Q2.UpdateBoards(board,boardOrder,mu)
        if PlayerhasWon(board):hasWon=1; break
    if hasWon:
        print('someone Won')
    else:
        print('draw')

