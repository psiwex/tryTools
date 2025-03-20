#running intra-subject tests with 4 class archetype

import numpy as np
import scipy as sp
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
from scipy import signal, arange, fft, fromstring, roll
from scipy.signal import butter, lfilter, ricker
import os
import glob
import re
from sklearn.neighbors import KNeighborsClassifier
from sklearn.feature_selection import RFE
from sklearn import svm
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score, cross_val_predict, KFold, cross_validate, train_test_split
from sklearn import metrics, linear_model, preprocessing
from sklearn.cluster import DBSCAN
from sklearn.metrics import recall_score, precision_score, f1_score, accuracy_score, make_scorer, classification_report
from sklearn.svm import SVC
from sklearn.multiclass import OneVsOneClassifier
from scipy.stats import stats
from utilityFunctions import pairLoader, eegFeatureReducer, balancedMatrix, featureSelect, speedClass, dirClass, dualClass, fsClass, classOutputs
from sklearn.neighbors import KNeighborsClassifier
from sklearn.feature_selection import RFE
from sklearn import svm
from sklearn.ensemble import AdaBoostClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.neural_network import MLPClassifier
from scipy import stats
from statsmodels.discrete.discrete_model import MNLogit
from stepmix.stepmix import StepMix

# for N-fold cross validation
# set parameters
N=2
featureNumber=int(3)
#best: N=2, features=3
#2nd best: N=5, features=3
from numpy import genfromtxt

#X = genfromtxt('tryZTData.csv', delimiter=',')
#X=stats.zscore(X0)
#X = genfromtxt('tryPhysZData.csv', delimiter=',')
#X = genfromtxt('tryXfiz.csv', delimiter=',')
#X = genfromtxt('tryXzfiz.csv', delimiter=',')
#X = genfromtxt('tryXsoc.csv', delimiter=',')
#X = genfromtxt('tryXzsoc.csv', delimiter=',')

X = genfromtxt('psData01.csv', delimiter=',')
y6 = genfromtxt('psLabels01.csv', delimiter=',')

X=stats.zscore(X)



#print(np.shape(X))
#print(np.shape(y1))
#print(np.shape(y2))
#print(np.shape(y3))

X[np.isnan(X)] = 0
X[np.isinf(X)] = 0


y6[np.isnan(y6)] = 0
y6[np.isinf(y6)] = 0

runCats=np.squeeze(np.unique(y6))


aFeatures6a,totalLength,X1,X2=featureSelect(X, y6, featureNumber, 0)
aFeatures6b,totalLength,X1,X2=featureSelect(X, y6, featureNumber, 1)



aFeatures=np.unique(np.hstack([aFeatures6a.flatten(), aFeatures6b.flatten()])).flatten()



cFeatures=np.unique(np.hstack([aFeatures.flatten()])).flatten()
# best: 17, 18, 20, 21, 22
print(cFeatures)
#X=np.squeeze(X[:,cFeatures])

#=fsClass()





y=y6

ca1finalAcc,ca1finalF1,cb1fsAcc,cb1fsF1,ca2finalAcc,ca2finalF1,cb2fsAcc,cb2fsF1,ca3finalAcc,ca3finalF1,cb3fsAcc,cb3fsF1,ca4finalAcc,ca4finalF1,cb4fsAcc,cb4fsF1,ca5finalAcc,ca5finalF1,cb5fsAcc,cb5fsF1,ca6finalAcc,ca6finalF1,cb6fsAcc,cb6fsF1=classOutputs(N,X,y6,featureNumber)

print('Megasystem: Trajectory')
print('')
print('LDA Acc')
print(ca1finalAcc)
print('LDA F1')
print(ca1finalF1)
print('')


print('NBayes Acc')
print(ca2finalAcc)
print('NBayes F1')
print(ca2finalF1)
print('')



print('SVM Acc')
print(ca3finalAcc)
print('SVM F1')
print(ca3finalF1)
print('')


print('KNN Acc')
print(ca4finalAcc)
print('KNN F1')
print(ca4finalF1)
print('')

print('LogReg Acc')
print(ca5finalAcc)
print('LogReg F1')
print(ca5finalF1)
print('')


print('LogReg Acc fs')
print(cb5fsAcc)
print('LogReg F1')
print(cb5fsF1)
print('')


