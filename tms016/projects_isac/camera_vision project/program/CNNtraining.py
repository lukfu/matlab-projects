import numpy as np
import matplotlib.pyplot as plt
from keras.preprocessing.image import ImageDataGenerator, array_to_img,img_to_array,load_img
import keras
from keras import Sequential
from keras.layers import Conv2D,MaxPooling2D,Flatten,Dense,Activation,Dropout
from keras.layers.advanced_activations import LeakyReLU


class DCNN():
    def __init__(self,input_shape,n_classes):
        self.model = Sequential()
        self.model.add(Conv2D(32,input_shape=input_shape,kernel_size=(3,3),strides=(1,1),activation='relu'))
        padding="same"
        self.model.add(Conv2D(64,kernel_size=(3,3),strides=(2,2),activation='relu'))
        padding="same"
        self.model.add(MaxPooling2D(pool_size=(2,2)))
        self.model.add(Dropout(0.15))
        self.model.add(Conv2D(64,kernel_size=(3,3),strides=(2,2),activation='relu'))
        padding="same"
        self.model.add(Conv2D(128,kernel_size=(3,3),strides=(1,1),activation='relu'))
        padding="same"
        self.model.add(MaxPooling2D(pool_size=(2,2)))
        self.model.add(Dropout(0.25))
        self.model.add(Flatten())
        self.model.add(Dense(64,activation='relu'))
        self.model.add(Dense(32,activation='relu'))
        self.model.add(Dense(n_classes,activation='softmax'))
    
        self.model.compile(
            loss = 'categorical_crossentropy',
            optimizer = 'Adam',metrics = ['accuracy']
                    )


train_path = 'data/train/train'
train_datagen = ImageDataGenerator(rescale=1./255,rotation_range = 30,
                                   width_shift_range=0.2,
                                   height_shift_range = 0.2,
                                   shear_range=0.3,
                                   fill_mode='nearest',
                                   validation_split=0.25)

train_set = train_datagen.flow_from_directory(directory=train_path, class_mode='categorical',
                                                    color_mode = 'grayscale',
                                                    target_size=(50,50), batch_size=32, shuffle=True,
                                                    subset ="training")
                                                    
validation_set = train_datagen.flow_from_directory(directory=train_path,
                                                 target_size = (50,50),
                                                 batch_size = 32,
                                                 class_mode = 'categorical',
                                                 color_mode = 'grayscale',subset="validation",shuffle=True)
input_shape = (50,50,1)
n_classes = 18
mymodel = DCNN(input_shape,n_classes).model
#print(mymodel.summary())

h = mymodel.fit(
      train_set,validation_data = validation_set,
                              epochs=60,steps_per_epoch = 42,validation_steps = 42,
                              callbacks = [
                              keras.callbacks.EarlyStopping(monitor='val_loss',patience=3,mode='auto'),
                              keras.callbacks.ModelCheckpoint('explo/model_{val_loss:.3f}.h5',
                              save_best_only = True,save_weights_only=False,
                              monitor='val_loss')
                              ]
)

accu= h.history['accuracy']
val_acc=h.history['val_accuracy']
epochs=range(len(accu)) #No. of epochs

plt.plot(epochs,accu,'r',label='Training Accuracy')
plt.plot(epochs,val_acc,'g',label='Validation Accuracy')
plt.legend()
plt.xlabel('No. of epochs')
plt.ylabel('Accuracy score')
plt.show()

mymodel.save('mymodel.h5')




