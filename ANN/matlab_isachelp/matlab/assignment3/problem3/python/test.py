import csv
from numpy.core.records import array
from Qtable import Qt 
import numpy as np
import time
from matplotlib import pyplot as plt
import matplotlib

Q1 = Qt(1)
mu=0.5
board2 = np.array([[0,0,0],[0,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,0,0],[2,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,0],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,5],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateQvalues(board1,board2,1,0)
print(Q1.Qtable[0:3,:])
Q1.Qtable[3:6,:] = np.around(Q1.Qtable[3:6,:],2)

print(f'{len(list(Q1.Qtable[3,:]))}')

mu=0.5
board2 = np.array([[0,0,0],[0,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,0,0],[2,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,0],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,5],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateQvalues(board1,board2,1,0)
print(Q1.Qtable[0:3,:])
Q1.Qtable[3:6,:] = np.around(Q1.Qtable[3:6,:],2)
print(f'{len(list(Q1.Qtable[3,:]))}')

print(f'{len(list(Q1.Qtable[3,:]))}')

mu=0.5
board2 = np.array([[0,0,0],[0,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,0,0],[2,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,0],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,5],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateQvalues(board1,board2,1,0)
print(Q1.Qtable[0:3,:])
Q1.Qtable[3:6,:] = np.around(Q1.Qtable[3:6,:],2)
print(f'{len(list(Q1.Qtable[3,:]))}')


print(f'{len(list(Q1.Qtable[3,:]))}')

mu=0.5
board2 = np.array([[0,0,0],[0,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,0,0],[2,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,0],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,5],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateQvalues(board1,board2,1,0)
print(Q1.Qtable[0:3,:])
Q1.Qtable[3:6,:] = np.around(Q1.Qtable[3:6,:],2)
print(f'{len(list(Q1.Qtable[3,:]))}')



print(f'{len(list(Q1.Qtable[3,:]))}')

mu=0.5
board2 = np.array([[0,0,0],[0,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,0,0],[2,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,0],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,5],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateQvalues(board1,board2,1,0)
print(Q1.Qtable[0:3,:])
Q1.Qtable[3:6,:] = np.around(Q1.Qtable[3:6,:],2)
print(f'{len(list(Q1.Qtable[3,:]))}')


print(f'{len(list(Q1.Qtable[3,:]))}')

mu=0.5
board2 = np.array([[0,0,0],[0,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,0,0],[2,0,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,0],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateBoards(board1,board2,mu)
board2 = np.array([[1,3,5],[2,4,0],[0,0,0]])
board1 = (board2%2)*2-1
board1[board2==0]=0
Q1.UpdateQvalues(board1,board2,1,0)
print(Q1.Qtable[0:3,:])
Q1.Qtable[3:6,:] = np.around(Q1.Qtable[3:6,:],2)
print(f'{len(list(Q1.Qtable[3,:]))}')
