## 사응일간 : 오태환 강동원 백원희 유건욱 이청파

주제 : 음원차트 순위 예측
목표 : 음원 순위에 영향을 주는 종합적인 변수들을 수집하고 이를 이용해 음원차트 순위를 예측, 추가적으로 outlier를 찾으면 음원 사재기 판별까지 기대
세부 과정



## 가온차트 주간 : http://gaonchart.co.kr/main/section/chart/online.gaon
User-agent: SemrushBot
Disallow: /

## 멜론 : https://www.melon.com/robots.txt
User-agent: Googlebot
Allow: /resource
Allow: /album
Allow: /artist
Allow: /video

User-agent: daumoa
Allow: /resource
Allow: /song
Allow: /album
Allow: /artist
Allow: /video
Allow: /genere
Allow: /new
Allow: /tv
Allow: /dj
Allow: /musicstory
Allow: /artistplus
Allow: /flac
Allow: /edu
Allow: /search/trend/
Allow: /search/cate/

User-agent: daumoa-image
Allow: /resource
Allow: /song
Allow: /album
Allow: /artist
Allow: /video
Allow: /genere
Allow: /new
Allow: /tv
Allow: /dj
Allow: /musicstory
Allow: /artistplus
Allow: /flac
Allow: /edu
Allow: /search/trend/
Allow: /search/cate/

User-agent: Twitterbot
Allow: /restful

User-agent: Applebot
Allow: /song

User-agent: Yeti
Allow: /resource
Allow: /chart/
Allow: /dj/today/
Allow: /event/
Allow: /flac/index.htm
Allow: /melonaward/
Allow: /musicstory/today/
Allow: /tv/
Allow: /commerce/pamphlet/
Allow: /$

User-agent: *
Disallow: /



## 노래방 순위 : https://www.tjmedia.co.kr/tjsong/song_monthPopular.asp
User-agent: NaverBot
Crawl-delay: 180
User-agent: Yeti
Crawl-delay: 180



## 네이버 검색량 :https://datalab.naver.com/
User-Agent: *
Allow: /$
Allow: /index.naver
Disallow: /


## 유튜브 : https://www.youtube.com/robots.txt
User-agent: Mediapartners-Google*
Disallow:

User-agent: *
Disallow: /channel/*/community
Disallow: /comment
Disallow: /get_video
Disallow: /get_video_info
Disallow: /live_chat
Disallow: /login
Disallow: /results
Disallow: /signup
Disallow: /t/terms
Disallow: /timedtext_video
Disallow: /user/*/community
Disallow: /verify_age
Disallow: /watch_ajax
Disallow: /watch_fragments_ajax
Disallow: /watch_popup
Disallow: /watch_queue_ajax

Sitemap: https://www.youtube.com/sitemaps/sitemap.xml



## 구글 트랜드 : https://trends.google.co.kr/trends/?geo=KR

인스타나 관객수  반송 횟수 화제성들은 동일한 기준 찾기 어려워 보임......
 - ost의 경우만 시청률바탕으로 화제성을 보던가 해야할듯...



가수의 특징 : 그룹인지, 혼성, 여성, 남성, 연령, top 100
유명세 : 유투브-조회수, 좋아요, 인스타, 네이버 검색량, 작곡가의 히트곡
회사 : 당시주식총액, 소속 가수, 회사 설립 지속 연도, 배급사, 홍보정도
곡 : 장르, 빠르기, 키, 길이, 주제
기타 : 계절, OST-시청률, 화제성,별점,콘서트관객수, 노래방 순위, 방송 횟수, 발매일
