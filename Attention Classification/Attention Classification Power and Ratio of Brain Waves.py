#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
from sklearn import svm
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB
from sklearn.naive_bayes import MultinomialNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.cluster import KMeans
import seaborn as sns


# In[2]:


#Importing File into Pandas Dataframe

df=pd.read_csv("Subject1_Brain_Frequencies_Attention_Wavelet.csv")

#df=pd.read_csv("Subject3_Brain_Frequencies_Attention_Wavelet.csv") for Subject 1
#df=pd.read_csv("Subject2_Brain_Frequencies_Attention_Wavelet.csv") for Subject 2
#df=pd.read_csv("Subject3_Brain_Frequencies_Attention_Wavelet.csv") for Subject 3

df=df.dropna() #Dropping NaN Values


# In[3]:


#Attention values will be divided into 3 stages. 
#1st Stage: Low Attention (0 to 33.33....) denoted by 1
#2nd Stage: Mid Attention (33.33 to 66.66...) denoted by 2
#3rd Stage: High Attention (66.66 to 100) denoted by 3

Max=df['Attention'].max()
Min=df['Attention'].min()
Z=(Max-Min)/3

df.loc[df['Attention'] < Z,'Attention_lvl'] = 0
df.loc[(df['Attention'] > Z) & (df['Attention'] < Z*2), 'Attention_lvl'] = 1
df.loc[df['Attention'] >Z*2,'Attention_lvl'] = 2


# In[4]:


#Power of Brain Waves and Boxplots

df['Delta']=df.Delta**2
df['Theta']=df.Theta**2
df['Alpha']=df.Alpha**2
df['Beta']=df.Beta**2
df['Gamma']=df.Gamma**2

boxplot = df.boxplot(column=['Delta', 'Theta', 'Alpha','Beta','Gamma'])


# In[ ]:





# In[5]:


df


# In[6]:


#Selecting Input and Output for Train_Test

X=df.drop(['Attention','Attention_lvl'],axis='columns')
y=df.Attention_lvl


# In[7]:


#Importing Machine Learning Models

from sklearn.svm import SVC
model2 = SVC()

from sklearn.linear_model import LogisticRegression
model3=LogisticRegression()

from sklearn.ensemble import RandomForestClassifier
model4 = RandomForestClassifier(n_estimators=50)


# In[8]:


#Splitting the Dataset into 70% TRAIN AND 30% TEST

from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3)


# In[9]:


#SVM Classifier
model2.fit(X_train,y_train)
model2.score(X_test,y_test)


# In[10]:


#Logistic Regression
model3.fit(X_train,y_train)
model3.score(X_test,y_test)


# In[11]:


#Random Forest Classifier
model4.fit(X_train,y_train)
model4.score(X_test,y_test)


# In[12]:


#Calculating Brain Wave Power Ratios

df['TBR']=df.Theta/df.Beta
df['TAR']=df.Theta/df.Alpha
df['DAR']=df.Delta/df.Alpha
df['ABR']=df.Alpha/df.Beta
df['DTABR']=(df.Delta+df.Theta)/(df.Alpha+df.Beta)


# In[13]:


data= [df.TBR,df.TAR,df.DAR,df.ABR,df.DTABR]
headers = ["TBR", "TAR","DAR","ABR"]
ndf = pd.concat(data, axis=1, keys=headers)
ndf


# In[14]:


X2=ndf


# In[15]:


from sklearn.model_selection import train_test_split
X2_train,X2_test,y2_train,y2_test=train_test_split(X2,y,test_size=0.3)


# In[16]:


#SVM Classifier
model2.fit(X_train,y_train)
model2.score(X_test,y_test)


# In[17]:


#Logistic Regression
model3.fit(X_train,y_train)
model3.score(X_test,y_test)


# In[18]:


#Random Forest Classifier
model4.fit(X_train,y_train)
model4.score(X_test,y_test)


# In[ ]:





# In[ ]:




