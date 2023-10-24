### 품질 예측하고 결과를 웹에 interactive하게 publish하기  

품질 예측은 품질에 영향을 주는 요소와 불량품 수량을 파악할 수 있게 해서 품질 향상과 불량품 처리에 도움을 줍니다.  
여기서는 다양한 머신러닝과 딥러닝 알고리즘으로 양품과 불량품을 예상하고,  
정답(정답은 아니지만 대회 1등 결과)와 비교하여 각 알고리즘의 특징을 파악할 수 있게 하였습니다.  
공장이나 현장에서 일하시는 분들이 컴퓨터 없이도 스마트폰으로 원하는 결과만 신속하게 보실 수 있게 interactive한 웹으로 예측 결과를 볼 수 있게 만들었습니다.  

  
### 사용된 프로그램과 웹사이트  
  
설치해야 하는 프로그램 : 파이썬, R & RStudio  
회원가입이 필요한 웹사이트 : Shinyapps.io(https://www.shinyapps.io/)  

  
### 원본 데이터 출처  
  
[스마트 공장 제품 품질 상태 분류](https://dacon.io/competitions/official/236055/data)  
![image](https://github.com/SungUk/quality/assets/5809062/7fdc761b-5e34-44f7-bccb-2ab1ed3c2be1)


### 설치 및 실행  
  
catboost 폴더는 Python으로 CatboostClassifier 모델을 이용하여 품질 예측을 한 결과를 R의 프로젝트 폴더로 출력해줍니다.  
기존의 Random Forest 모델과 DNN 모델 결과 파일도 들어가 있어서 이들의 예측 결과도 CatboostClassifier 모델과 비교하게 만들었습니다.  
먼저 main.py 코드에서 R 프로젝트 폴더를 알맞게 변경합니다.  
  
예) <C:/Users/ssw/Documents/test2/>를 <C:/Users/hong/Documents/RShiny/>로 변경.
  
변경이 끝나면 main.py 파일을 실행하시면 됩니다.  

RShiny 폴더는 R 프로젝트 폴더로 품질예측 결과 파일을 입력받아 웹에서 interactive하게 보여주는 역할을 합니다.  
작업하실 R 프로젝트 폴더에 파일들을 복사해서 붙여넣기 해주시거나,  
아니면 해당 폴더를 R 프로젝트 폴더로 지정하세요.  
실행하실 때는 RStudio에서 아래의 명령어를 실행하시면 됩니다.  
```
> #install.packages("shiny")
> #install.packages('rsconnect')
> #Shinyapps.io에 회원가입하시고 Account > Token에서 Show 버튼을 누르면 나타나는 문자를 아래에 양식에 맞게 입력합니다.
> rsconnect::setAccountInfo(name='xxxxxxxxxxxxxxxxxx', token='xxxxxxxxxxxxxxxxxxx', secret='xxxxxxxxxxxxxxxxxxxxxxxxx')
> #자신의 컴퓨터에서 먼저 보기
> library(shiny)
> runApp()
> #웹에 퍼블리쉬하기
> library(rsconnect)
> deployApp()
```


### 데이터 전처리와 EDA  
  
대회용으로 잘 정리된 정형데이터이므로 특별한 데이터 전처리는 필요 없었습니다.  



### 원본 데이터 출처  
  
[스마트 공장 제품 품질 상태 분류](https://dacon.io/competitions/official/236055/data)  





  
### 최종 결과물 예시  
  
결과 페이지 : 제가 만들 최종 결과물의 주소는 아래와 같습니다.  
https://u7s2pv-sunguk-shin.shinyapps.io/test2/  
  
  



  
