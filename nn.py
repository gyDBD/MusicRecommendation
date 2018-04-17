# coding: utf-8

# In[1]:


import numpy as np
import scipy.io as io
import os
import keras as keras
from keras.datasets import mnist
from keras.models import Model
from keras.models import Sequential, load_model
from keras.layers import Dense
from keras.utils import np_utils
from keras.utils import to_categorical
from keras.callbacks import ModelCheckpoint
from keras.callbacks import TensorBoard
import pandas
from keras.wrappers.scikit_learn import KerasRegressor
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
from keras import optimizers


# In[6]:


def preprocess(path):
    data = io.loadmat(path + "/input_train2.mat")
    X_train = np.asarray(data['input'], dtype=np.double)

    data = io.loadmat(path + "/output_train2.mat")
    y_train = np.asarray(data['target'], dtype=np.double)

    data = io.loadmat(path + "/input_test2.mat")
    X_test = np.asarray(data['input'], dtype=np.double)

    data = io.loadmat(path + "/output_test2.mat")
    y_test = np.asarray(data['target'], dtype=np.double)

    return X_train, y_train, X_test, y_test


# In[7]:


path = "./data"
X_train, y_train, X_test, y_test = preprocess(path)


# In[8]:


#def zero_one(data, threshold):
#    keep_mask = data==threshold
#    out = np.where(data<threshold,0,1)
#    return out


# In[9]:


#y_train = zero_one(y_train, 4)
#y_test = zero_one(y_test, 4)


# In[10]:


def standardize(data):
    avg = np.average(data)
    std = np.std(data)
    return (data - avg) / std


# In[11]:


X_train = standardize(X_train)
X_test = standardize(X_test)

# In[8]:


# num_samples = 1100000
# X_train = X_train[:num_samples]
# y_train = y_train[:num_samples]


# In[12]:



model = Sequential()
model.add(Dense(32, input_dim=X_train.shape[1], kernel_initializer='normal',
                activation='relu'))
model.add(Dense(16, kernel_initializer='normal', activation='relu'))
model.add(Dense(1, kernel_initializer='normal', activation='sigmoid'))
adam = optimizers.adam(lr=0.00001)
model.compile(loss='mape', optimizer=adam, metrics=['accuracy'])
model.summary()

# In[19]:


checkpoint = ModelCheckpoint("./model13", monitor='val_acc',
                             verbose=1, save_best_only=True, mode='min')
callbacks_list = [checkpoint]

from keras.models import load_model

# model = load_model('model.h5')

# adam = optimizers.adam(lr=0.00001)
# model.compile(loss='binary_crossentropy', optimizer=adam, metrics=['accuracy'])
model.fit(X_train, y_train, epochs=40, batch_size=32, validation_split=0.1,
          verbose=1, callbacks=callbacks_list, shuffle=True)

