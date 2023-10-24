#pip install pandas
#pip install scikit-learn
#pip install catboost

import pandas as pd
from catboost import CatBoostClassifier
from sklearn.metrics import accuracy_score

train_df = pd.read_csv('./train.csv')
test_df = pd.read_csv('./test.csv')
test_y = pd.read_csv('./possibleanswer.csv')
test_pid=test_df['PRODUCT_ID']
test_pcode=test_df['PRODUCT_CODE']
test_line=test_df['LINE']
train_x = train_df.drop(columns=['PRODUCT_ID', 'TIMESTAMP', 'Y_Class', 'Y_Quality'])
train_y = train_df['Y_Class']

test_x = test_df.drop(columns=['PRODUCT_ID', 'TIMESTAMP'])
test_y = test_y['Y_Class']
train_x = train_x.fillna(0)
test_x = test_x.fillna(0)
test_x251=test_x['X_251']
test_x371=test_x['X_371']
test_x632=test_x['X_632']
test_x660=test_x['X_660']
test_x956=test_x['X_956']
test_x1000=test_x['X_1000']

# CatBoostClassifier 모델 생성
model = CatBoostClassifier(iterations=1000, depth=6, learning_rate=0.1, loss_function='MultiClass',cat_features=['LINE', 'PRODUCT_CODE'])

# 모델 훈련
model.fit(train_x, train_y, verbose=100)

y_pred=model.predict(train_x)
accuracy = accuracy_score(train_y, y_pred)
print(f"Accuracy: {accuracy:.2f}")

#prediction
y_pred=model.predict(test_x)

# 정확도 평가
accuracy = accuracy_score(test_y, y_pred)
print(f"Accuracy: {accuracy:.2f}")

pred_file=open('C:/Users/ssw/Documents/test2/predict.csv','w')
count=0
print('ProductID,LineID,QualityClass,ProductCode,X_251,X_371,X_632,X_660,X_956,X_1000',file=pred_file)
for row in y_pred:
    for item in row:
        print(str(test_pid[count])+","+str(test_line[count])+","+str(item)+","+str(test_pcode[count])+","+str(test_x251[count])+","+str(test_x371[count])+","+str(test_x632[count])+","+str(test_x660[count])+","+str(test_x956[count])+","+str(test_x1000[count]),file=pred_file)
        count+=1
pred_file.close()

rf_df = pd.read_csv('./randomForest.csv')
rf_class=rf_df['Y_Class']
dnn_df = pd.read_csv('./DNN.csv')
dnn_class=dnn_df['DNN']

print(dnn_class[0])
print(dnn_class[13])

comp_file=open('C:/Users/ssw/Documents/test2/compare.csv','w')
print('RandomForest,DNN,CatboostClassifier,CatboostRegressor',file=comp_file)
count=0
for row in y_pred:
    for item in row:
        print(str(rf_class[count])+","+str(dnn_class[count])+","+str(item)+","+str(test_y[count]),file=comp_file)
        count+=1
comp_file.close()