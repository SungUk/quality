library(shiny)
library(DT)
library(plotly)

ui <- fluidPage(

  # App title ----
  titlePanel(HTML('<div style="text-align:center;">품질 예측 결과</div>')),
  HTML('<br>'),
  HTML('<div style="text-align:center;"><h3>알고리즘 비교</h3></div>'),
  HTML('<div style="text-align:center;"><h4>정답은 Private 1위 코드를 돌려서 나온 CatboostRegressor 결과라고 가정하였습니다.</h4></div>'),
  fluidRow(
    column(4,plotlyOutput("random_forest"),textOutput("rf_text")),
    column(4,plotlyOutput("DNN"),textOutput("dnn_text")),
    column(4,plotlyOutput("CatboostClassifier"),textOutput("cbc_text"))
  ),
  HTML('<div style="text-align:center;"><h4>이 자료의 경우 불량품(0 또는 2) 자료가 양품(1) 자료보다 훨씬 적다는 특성이 있기에 틀린 결과에 가중치를 주는 CatboostClassifier가 우수한 성능을 보였습니다.</h4></div>'),
  HTML('<br>'),
  HTML('<div style="text-align:center;"><h3>CatboostClassifiter 예측 결과 정리</h3></div>'),
  HTML('<div style="text-align:center;"><h4>전체 Class 분류 결과</h4></div>'),
  fluidRow(
    column(6,DTOutput("quality_table")),
    column(6,plotlyOutput("quality_pie"))
  ),
  HTML('<div style="text-align:center;"><h4>라인별 Class 분류 결과</h4></div>'),
  fluidRow(
    column(6,selectInput("line","Line:",choices=c("T050304","T050307","T100304","T100306","T010306","T010305"),selected="T050304"),
    DTOutput("line_table")
    ),
    column(6,plotlyOutput("line_quality_pie"))
  ),
  HTML('<div style="text-align:center;"><h4>제품별 측정값의 산포도로 본 Class와 라인</h4></div>'),
  fluidRow(
    column(6,selectInput("product_code","ProductCode:",choices=c("A_31","O_31","T_31"),selected="A_31"),
    selectInput("xaxis","x-axis:",choices=c("X_251","X_371","X_632","X_660","X_956","X_1000"),selected="X_956"),
    selectInput("yaxis","y-axis:",choices=c("X_251","X_371","X_632","X_660","X_956","X_1000"),selected="X_1000"),
    HTML('<div style="text-align:justify;"><h4>위쪽에서 원하는 Product code와 x축과 y축에 해당하는 측정값을 선택할 수 있습니다.&nbsp;'),
    HTML('오른쪽에 원하는 그래프가 scatter plot의 형태로 나타납니다.&nbsp;'),
    HTML('품질 class에 따라 색이 바뀌며 양품에 해당하는 1이 연두색으로 나타납니다.&nbsp;'),
    HTML('자료에 해당하는 LineID에 따라 모양이 바뀝니다.&nbsp;'),
    HTML('오른쪽 그림 위에 마우스 포인터를 놓으면 다운로드, 확대, 축소, 이동 버튼이 나타납니다.</h4></div>'),
    ),
    column(6,plotlyOutput("scatter_density",width="700px",height="500px"))
  )
)