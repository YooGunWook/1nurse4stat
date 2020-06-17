# Shiny Dashboard

## Content
   * Ranking  Fluctuation
      * Table Tab : artist, name, week, diff_rank를 포함한 datatable
      * Graph Tab : 특정 곡의 과거 5주간 차트 실제 및 예측 변화 추이를 출력.
         *  Real Rank : 푸른 선으로 표시, 실제 순위 변화 추이를 출력.
         *  Rank Estimate : 주황 점선으로 표시, 예측 순위 변화 추이를 출력.
         *  Value Box : 하단의 5개 valuebox는 각각 과거 5주간의 예측 순위와 실제 순위 차이를 출력 및 평가. 차이가 20 미만의 경우 초록, 20이상 70미만의 경우 주황, 70이상의 경우 빨강.

> singer, title을 순서대로 입력 후 week를 입력, 변화 추이 graph 출력
> 가수명 혹은 곡명이 불명확한 경우, Table 탭에서 검색 후 입력
> 해당 주차에 곡이 미발표되는 등의 사유로 순위가 없는 경우, plot에도 표시가 안 되며, valuebox도 출력이 안됨.


   * Data Table
 사용한 datatable 제시. 가독성을 위해 일부 변수 생략. 
| 변수명 | 변수의 의미 | 
| :----: | :---------- | :--- |
|artist|가수명|
|name|곡명|
|title_song|각 주차별 해당 가수 곡 중 최고 순위 여부|
|week|해당 차트 주|
|top_freq|100위 안에 가수가 얼마나 많이 차트에 곡을 올렸는지 4분위수|
|rank|주간 곡 순위|
|rank_g_pred|주간 곡 예측 순위|
|diff_rank|주간 곡 실제 순위와 예측 순위의 차이|