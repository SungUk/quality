간단한 설명 : catboost 폴더는 Python으로 CatboostClassifier 모델을 이용하여 품질 예측을 한 결과를 R의 프로젝트 폴더로 출력해줍니다.<br/>
RShiny 폴더는 R 프로젝트 폴더로 품질예측 결과 파일을 입력받아 웹에서 interactive하게 보여주는 역할을 합니다.<br/>
주의점 : Python 파일을 사용하실 때 <C:/Users/ssw/Documents/test2/>로 표시된 R 프로젝트 폴더를 본인의 R 프로젝트 폴더에 맞게 수정하시기 바랍니다.<br/>
입력 파일 설명 : 기존의 Random Forest 모델과 DNN 모델 결과 파일도 들어가 있어서 이들의 예측 결과도 CatboostClassifier 모델과 비교하게 만들었습니다.<br/>
명령어 : R에서 웹에 퍼블리쉬하는 명령어는 아래와 같습니다.<br/>
==========*^-^*==========<br/>
#install.packages("shiny")<br/>
#install.packages('rsconnect')<br/>
#Shinyapps.io에 회원가입하시고 Account > Token에서 Show 버튼을 누르면 나타나는 문자를 아래에 양식에 맞게 입력합니다.<br/>
rsconnect::setAccountInfo(name='xxxxxxxxxxxxxxxxxx', token='xxxxxxxxxxxxxxxxxxx', secret='xxxxxxxxxxxxxxxxxxxxxxxxx')<br/>
#자신의 컴퓨터에서 먼저 보기<br/>
library(shiny)<br/>
runApp()<br/>
#웹에 퍼블리쉬하기<br/>
library(rsconnect)<br/>
deployApp()<br/>
==========*^-^*==========<br/>
결과 페이지 : 제가 만들 최종 결과물의 주소는 아래와 같습니다.<br/>
https://u7s2pv-sunguk-shin.shinyapps.io/test2/<br/>