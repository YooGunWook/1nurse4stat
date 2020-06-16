# Shiny Dashboard
 Rank Group은 각각 10등씩 나눈 등수로, 1~9위는 Group0, 10~19위는 Group1, 100위 이하는 Group10을 부여.

## Content
   * Ranking  Fluctuation
 ⋅⋅⋅Table : 예측 등수와 실제 등수 그룹 차이가 -5 이상의 곡들을 출력.
 ⋅⋅⋅Graph : 선택한 곡의 과거 4주간의 등수 변화 추이와 예측 등수 그룹을 출력.
 ⋅⋅⋅⋅⋅⋅Real Rank : 푸른 선으로 표시, 실제 등수 그룹 변화 추이를 나타냄.
 ⋅⋅⋅⋅⋅⋅Rank Estimate : 주황 점선으로 표시, 예측 등수 그룹을 나타냄.

   * Ranking Estimation
 ⋅⋅⋅모델에 사용된 변수를 모두 조정, 입력하여 등수 그룹을 예측.
 ⋅⋅⋅⋅⋅⋅`reticulate`를 이용하여 `Anaconda3`환경 하 `python`으로 작성한 모델을 사용.

   * Data Table
 ⋅⋅⋅사용한 데이터를 제시. 단 일부 변수는 생략.



로컬에서 사용할 경우, server.est의 R#2에서 `Anaconda3`환경 하의 `python`경로 변경 후 사용할 것.
`Anaconda3`환경이 없는 경우 `miniconda`설치여부를 묻는데, 잘 모르면 설치하지 않도록 한다.
`python`이 없는 경우 본 대쉬보드를 실행하지 못할 가능성이 높다.
