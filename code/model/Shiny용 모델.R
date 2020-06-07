# Python 환경 불러오기
library('reticulate')
use_condaenv('anaconda3')
repl_python()

# 사용 패키지 블러오기
import numpy as np
import pandas as np
import joblib
import catboost

# 모델 불러오기
model = joblib.load('모델 경로 입력')

# model에 맞게 데이터프레임 만들어줘야함. 이건 실험과정이라 그냥 우리 데이터셋에서 불러옴.
from sklearn.model_selection import train_test_split
df = pd.read_csv('파일 경로')
X_train, y_train, X_test, y_test = train_test_split(df.drop(columns = df['rank_g']),df['rank_g'], test_size = 0.3)
model.predict(X_test)
