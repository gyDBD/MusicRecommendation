
from sklearn import svm
import numpy as np
import scipy.io as io



def preprocess(path):
    data = io.loadmat(path + "/input_train.mat")
    X_train = np.asarray(data['input'], dtype=np.double)

    data = io.loadmat(path + "/output_train.mat")
    y_train = np.asarray(data['target'], dtype=np.double)

    data = io.loadmat(path + "/input_test.mat")
    X_test = np.asarray(data['input'], dtype=np.double)

    data = io.loadmat(path + "/output_test.mat")
    y_test = np.asarray(data['target'], dtype=np.double)

    return X_train, y_train, X_test, y_test


# In[7]:


path = "./data"
X_train, y_train, X_test, y_test = preprocess(path)

clf = svm.SVC(gamma=0.01, C=100)

clf.fit(X_train,y_train)
result = clf.predict(X_test)
print(result)
