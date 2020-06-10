# Python 환경 불러오기
install.packages('reticulate')
library('reticulate')
use_condaenv('catboost')
# repl_python()

# 사용 패키지 블러오기
pd = import('pandas')
np = import('numpy')
joblib = import('joblib')
catboost = import('catboost')
sklearn = import('sklearn')

# 모델 불러오기
model = joblib$load('C:/Users/user/Desktop/cpu_version.pkl')

# model에 맞게 데이터프레임 만들어줘야함. 이건 실험과정이라 그냥 우리 데이터셋에서 불러옴.
a = np$array(object = list(c('2', '4',	'댄스','summer',	'female'	,'K_POP',	'Group'	,0.523668639,	0.221153846,	0.8,	1,	0.090654206,	0.394525289,	0.056,	0,	0,	0,	0
)))
a
model$predict(a)
