# 시계열 자료의 정상성 조건 ----------------------------------------------------------

## 일정한 평균
### 2018년 1월부터 2019년 12월까지 매월 초의 환율 데이터
rate <- c( 1072, 1081, 1090, 1065, 1087, 1085, 1130, 1130, 1122, 1122, 1144, 1121, 
           1131, 1129, 1137, 1146, 1176, 1194, 1174, 1200, 1224, 1213, 1172, 1197)
plot( rate, type = 'l' )

rate_diff <- diff( rate, lag = 1 ) # 차분 1회
plot( rate_diff, type = 'l' )

## 일정한 분산
plot( UKgas )
UKgas_log <- log( UKgas )
plot( UKgas_log )

## 시차에만 의존하는 공분산
data <- rnorm( 100 ) # 임의의 시계열 데이터 생성
diff <- 3 # 시차를 3으로 설정
x <- 1 : ( 100 - diff )
y <- x + diff
plot( data[x], data[y] ) # 시차를 3으로 갖는 시계열 자료의 산점도
cov( data[x], data[y] ) # 특정 시점이 아닌 시차에 영향을 받는 공분산 값


# 자기회귀 모형 -----------------------------------------------------------------

rate_ts <- ts( rate ) # 수치형 변수를 시계열 자료로 변환
                      # 평균이 일정하지 않아 정상성을 만족하지 못함
rate_ts_diff2 <- diff( rate_ts, differences = 2 )
pacf( rate_ts_diff2 )


# 이동평균 모형 -----------------------------------------------------------------

acf( rate_ts ) # 정상성 가정이 필요하지 않으므로 차분 없이 진행


# 자기회귀누적이동평균 모형 -----------------------------------------------------------

install.packages( 'xts' )
install.packages( 'forecast', dependencies = T )
library( forecast )

auto.arima( rate_ts ) # 최적의 모형 선정

rate_ts_diff1 <- diff( rate_ts, differences = 1 )
acf( rate_ts_diff1 )
pacf( rate_ts_diff1 )


# 시계열 분석 예시 ---------------------------------------------------------------

library(datasets)
library(forecast)
auto.arima( Nile )
result <- arima( Nile, order = c( 1, 1, 1) ) # auto.arima로 적절하다 판단된 모형으로 Nile 데이터 모형 구축
pred <- forecast( result, h = 5 ) # 구축된 모형으로 미래 5년 예측
pred
plot( pred )