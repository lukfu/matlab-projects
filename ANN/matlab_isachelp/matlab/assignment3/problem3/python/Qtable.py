import numpy as np
import random

from numpy.core.numeric import indices
class Qt:
  def __init__(self,player,alpha=0.4,gamma=1):
    self.player = player
    self.Qdict = dict()
    self.Qtable = np.array([[],[],[],[],[],[]])#6xN array
    self.nan = -100
    self.alpha = alpha
    self.gamma = gamma

  def GetStateIndex(self,board):
    boardTuple = tuple(map(tuple, board))
    if boardTuple in self.Qdict:
      return self.Qdict[boardTuple]
    else:
      index = len(self.Qtable[1,:])
      self.Qdict[boardTuple] = index
      qtable = np.random.rand(3,3)*0#test put to zero
      qtable[board!=0]=self.nan
      qtable = np.append(board,qtable,axis = 0)
      self.Qtable = np.append(self.Qtable, qtable,axis = 1)
      return index
  
  def GetCurrentQtable(self,board):
    index = self.GetStateIndex(board)
    return self.Qtable[3:6,index:index+3]

  def UpdateBoards(self,board,boardOrder,mu):
    Q = self.GetCurrentQtable(board)
    if random.random() >= mu:#same as <1-mu
      Qtmp1 = Q!=self.nan
      Qtmp2 = Q==np.max(Q)
      Qtmp = np.bitwise_and(Qtmp1,Qtmp2)
    else:
      Qtmp1 = Q!=self.nan
      Qtmp2 = Q!=np.max(Q)
      Qtmp = np.bitwise_and(Qtmp1,Qtmp2)
      if np.max(Qtmp)==0:#in case for start option!
        Qtmp = Q!=self.nan
    choice = []
    for y in range(3):
      for x in range(3):
        if Qtmp[y,x]:
          choice.append(y*3 + x+1)
    index = random.choice(choice)
    y = (index-1)//3
    x = (index-1)%3
    board[y,x] = self.player
    boardOrder[y,x] = np.max(boardOrder+1)
    return board, boardOrder
    
  def UpdateQvalues(self,board,boardOrder,startFirstOrSecond,gotDraw):
    maxRound = np.max(boardOrder)
    playerWon = maxRound%2==startFirstOrSecond%2
    YourLastTurn = maxRound+playerWon-2
    rVal = (playerWon*2-1)*(1-gotDraw)+0.0*gotDraw
    
    board[boardOrder>=YourLastTurn+1]=0
    LastQvalue = 0
    while YourLastTurn>=0:
      newPart = (boardOrder==(YourLastTurn+1))*(rVal+self.gamma*LastQvalue)
      iUpdate = self.GetStateIndex(board)
      tmpQtable = self.Qtable[3:6,iUpdate:iUpdate+3] 

      indices = tmpQtable==self.nan
      newQboard = tmpQtable + self.alpha*(newPart - tmpQtable)
      newQboard[indices]=self.nan
      self.Qtable[3:6,iUpdate:iUpdate+3] = newQboard 
      LastQvalue = np.max(newQboard)

      YourLastTurn-=2
      indices = boardOrder>=YourLastTurn+1
      board[indices] = 0
      indices = boardOrder>=YourLastTurn+2
      boardOrder[indices] = 0
      rVal=0

   





   
        
    
    
  






