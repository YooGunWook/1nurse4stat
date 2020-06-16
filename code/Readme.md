# Folder description

## crawling : codes for crawling

## model : codes for modeling
   * logistic regression
   * cat boost
   * xg boost
   * random forest

## preprocessing_EDA : codes for preprocessing and EDA
  1. 파생변수 추가
  2. log transformation for skewed data
  3. min - max scaling for numeric data


### 1. 파생변수 추가
---------------------
#### 1-1 

```
  title_song
```

##### Idea : 높은 인기로 인해 음원차트에 2곡 이상의 곡을 진입시킨 가수들이 있다. 타이틀곡이 아닌 곡의 경우에는 가수의 다른 지표가 좋아도 타이틀곡에 비해 순위가 낮을 수 밖에 없다. 따라서 그 주차에 한 가수가 진입시킨 곡들 중에 가장 순위가 높은 곡을 title_song이라고 정하고 title_song인 경우는 1, 아닌 경우는 0을 할당하는 변수를 만들었다.


#### 1-2

  previous_ranking

##### Idea : 당연히 음원차트 순위 예측은 이전 순위에 영향을 받을 것이다. 따라서 기존에 차트에 있는 곡은 이전주차 순위를, 신곡의 경우는 그 가수가 직전에 낸 음반의 title_song의 rank_g중 가장 높은(1에 가까운) 순위를 할당하였다.

