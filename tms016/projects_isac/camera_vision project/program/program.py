from os import stat
from keras.models import load_model
from tensorflow.keras.preprocessing.image import img_to_array
import cv2
import warnings
import numpy as np
import mediapipe as mp
import time
warnings.filterwarnings('ignore')


model = load_model('mymodel.h5')
label = ['0','1','7','8','2','3','4','5','6','9']

## LOAD IN MEDIA PIPE
mphands = mp.solutions.hands
hands = mphands.Hands()
mp_drawing = mp.solutions.drawing_utils
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

## Capturing the video sequence
cap = cv2.VideoCapture(0)

#set parameters
aweight = 0.5
num_frames = 0; max_frames = 30
bg = None

_, frame = cap.read()
h,w,c = frame.shape

state = 1
binary_gestures = 0 

##    ------------------------Functions-------------------------------------

def get_prediction(img):
    #get hand gesture prediction with CNN
    for_pred = cv2.resize(img,(50,50))
    x = img_to_array(for_pred)
    x = x/255.0
    x = x.reshape((1,) + x.shape)
    probs = model.predict(x)
    if binary_gestures==1:
        iGesture = np.argmax(probs[0,0:2])
    else: iGesture = np.argmax(probs)
    pred = str(label[iGesture])
    return pred

def run_avg(img,aweight):
    #get running average of background
    global bg
    if bg is None:
        bg = img.copy().astype('float')
        return
    cv2.accumulateWeighted(img,bg,aweight)

def segment(img,thres=15):
    #background subtraction and thresholding
    global bg
    diff = cv2.absdiff(bg.astype('uint8'),img)
    _, thresholded = cv2.threshold(diff,thres,255,cv2.THRESH_BINARY)
    return thresholded

def segment_color(img):
    #skin color segmentation
    img_HSV = cv2.cvtColor(img, cv2.COLOR_BGR2HSV) 
    HSV_mask = cv2.inRange(img_HSV, (0, 15, 0), (17,170,255)) 
    HSV_mask = cv2.morphologyEx(HSV_mask, cv2.MORPH_OPEN, np.ones((3,3), np.uint8))

    img_YCrCb = cv2.cvtColor(img, cv2.COLOR_BGR2YCrCb)
    YCrCb_mask = cv2.inRange(img_YCrCb, (0, 130, 85), (255,180,135)) 
    YCrCb_mask = cv2.morphologyEx(YCrCb_mask, cv2.MORPH_OPEN, np.ones((3,3), np.uint8))

    global_mask=cv2.bitwise_and(YCrCb_mask,HSV_mask)
    global_mask=cv2.medianBlur(global_mask,29)
    return global_mask

def get_box0(a_frame):
    #static box
    [x_min,x_max,y_min,y_max] = [400,600,100,300]
    cv2.rectangle(a_frame, (x_min, y_min), (x_max, y_max), (0, 255, 0), 2)
    return [x_min,x_max,y_min,y_max]

def get_box1(a_frame,b = 0.1):
    #media pipe method
    result = hands.process(a_frame)
    hand_landmarks = result.multi_hand_landmarks
    if hand_landmarks:
        for handLMs in hand_landmarks:
            x_max =  y_max = 0
            x_min = w
            y_min = h

            #get box coords for 1 hand
            for lm in handLMs.landmark:
                x, y = int(lm.x * w), int(lm.y * h)
                if x > x_max:
                    x_max = x
                if x < x_min:
                    x_min = x
                if y > y_max:
                    y_max = y
                if y < y_min:
                    y_min = y
                
            #scale box
            x_diff = x_max-x_min
            y_diff = y_max-y_min
            x_min -= int(b*x_diff)
            x_max += int(b*x_diff)
            y_min -= int(b*y_diff)
            y_max += int(b*y_diff)

            #make rectangle into box
            x_diff = x_max-x_min
            y_diff = y_max-y_min
            diff = y_diff - x_diff
            if diff > 0:
                x_min -= diff//2
                x_max += diff//2
            elif diff < 0:
                y_min += diff//2
                y_max -= diff//2 

            #plot on frame
            mp_drawing.draw_landmarks(a_frame, handLMs, mphands.HAND_CONNECTIONS)            
            if x_min >= 0 and x_max < w and y_min >= 0 and y_max < h:
                cv2.rectangle(a_frame, (x_min, y_min), (x_max, y_max), (0, 255, 0), 2)
                return x_min,x_max,y_min,y_max
    return -1,-1,-1,-1


def get_box2(a_frame):
    #skin color semgentation + convex hull method
    #need to use long sleeve clothes
    try:
        a_frame2 = segment_color(a_frame)
        contours, hierarchy = cv2.findContours(a_frame2, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
        if len(contours)>0:
            cnt = max(contours,key=cv2.contourArea)
            hull1 = cv2.convexHull(cnt)
            points = np.array(hull1)

            #get box
            x_min = np.amin(points[:,0,0])
            y_min = np.amin(points[:,0,1])-5
            x_max = np.amax(points[:,0,0])
            y_max = np.amax(points[:,0,1])-5

            #scale box
            x_diff = (x_max-x_min)
            y_diff = (y_max-y_min)
            diff = np.abs(y_diff-x_diff)
            if x_diff > y_diff:
                y_min-=diff//2
                y_max+=diff//2
            else: 
                x_min-=diff//2
                x_max+=diff//2
            #plot box on frame
            if x_min >= 0 and x_max < w and y_min >= 0 and y_max < h:
                cv2.rectangle(a_frame, (x_min, y_min), (x_max, y_max), (0, 255, 0), 2)#draws box on
                return x_min,x_max,y_min,y_max
    except: pass
    return -1,-1,-1,-1    
    
#----------------Comments  ---------------------

#press 1,2,3 to activate hand detection method 1,2,3 
#press p to reset background subtraction
#press t to switch from all 10 gestures to binary prediction (gesture 0,1)
#press q twice to end program

#---------------------Now MAIN CODE-----------------------------------------
while(cap.isOpened()):
    success, frame = cap.read()
    frame = cv2.flip(frame, 1)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (7, 7), 0)

    if num_frames < max_frames:
        run_avg(gray, aweight)
    else:
        #bg- subtraction
        frame_segment = segment(gray)

        if state==1:
            x1,x2,y1,y2 = get_box1(frame)
        elif state==2:
            #remove face first
            faces = face_cascade.detectMultiScale(gray, 1.3, 5)
            for (x1,y1,w1,h1) in faces:
                ymin = np.max(y1-20,0)
                ymax = np.minimum(y1+h1+50,480)
                frame_segment[ymin:ymax, x1:x1+w1] = 0
                frame[ymin:ymax, x1:x1+w1] = 0
            x1,x2,y1,y2 = get_box2(frame)
        else:
            x1,x2,y1,y2 = get_box0(frame)
        
        #if box found get prediction
        if x1>=0:
            resized = frame_segment[y1:y2,x1:x2]
            frame_predict = np.array(resized>0,dtype=np.uint8)#to do yourself
            pred = get_prediction(resized)
            cv2.putText(frame, "state: "+str(state)+" pred: "+str(pred), (280, 90), cv2.FONT_HERSHEY_DUPLEX, 1, (0, 30, 255), 3)
        else: 
            resized = np.zeros((50,50),dtype=np.uint8)
        
        cv2.imshow("original", frame)
        cv2.imshow("segment", frame_segment)
        cv2.imshow("hand", resized)
        
    #for bg-subtraction
    num_frames += 1

    #key commands
    key = cv2.waitKey(1) & 0xFF
    if  key == ord('q'):
        break
    if key >= ord('0') and key <=ord('9'):
        state = key-ord('0')
    if key == ord('p'):
        print('resetting background')
        num_frames = 0    
    if key == ord('t'):
        binary_gestures = 1 - binary_gestures  
        print(binary_gestures) 
        
cap.release()
cv2.waitKey()
cv2.destroyAllWindows()
