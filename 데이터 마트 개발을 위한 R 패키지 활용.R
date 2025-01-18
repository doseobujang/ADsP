# reshape 패키지 -------------------------------------------------------------

## reshape 공식 문서: https://cran.r-project.org/web/packages/reshape/reshape.pdf

## melt 함수: 특정 변수 기준으로 나머지 변수에 대한 세분화된 데이터 제작

### 두 학생의 학기별 점수 데이터 프레임
student_number <- c( 1, 2, 1, 2 )
semester <- c( 1, 1, 2, 2 )
math_score <- c( 60, 90, 70, 90 )
english_score <- c( 80, 70, 40, 60 )
score <- data.frame( student_number, semester, math_score, english_score )

install.packages("reshape") # 설치 및 호출되지 않을 경우 reshape2
library( reshape )
melt( score, id = c( "student_number", "semester" ) )

## cast 함수: melt에 의해 녹은 데이터를 요약을 위해 새롭게 가공

### melt를 활용하여 얻은 결과를 melted_score로 저장
melted_score <- melt( score, id = c( "student_number", "semester" ) )

### 학생의 과목별 평균점수를 알고 싶은 경우
cast( melted_score, student_number ~ variable, mean )

### 학생의 학기별 평균점수를 알고 싶은 경우
cast ( melted_score, student_number ~ semester, mean )

### 학생의 과목별 최댓값을 알고 싶은 경우
cast( melted_score, student_number ~ variable, max )


# sqldf 패키지 ---------------------------------------------------------------

install.packages("sqldf")
library( sqldf )
sqldf( 'select * from score' )
sqldf( 'select * from score where student_number = 1' )
sqldf( 'select avg(math_score), avg(english_score) from score group by student_number' )


# plyr 패키지 ----------------------------------------------------------------

## plyr 공식 문서: https://cran.r-project.org/web/packages/plyr/plyr.pdf
### 입력 데이터 구조와 출력 데이터 구조에 따라 함수가 다름

## ddply: 데이터프레임 to 데이터프레임
class <- c( 'A', 'A', 'B', 'B' )
math <- c( 50, 70, 60, 90 )
english <- c( 70, 80, 60, 80 )
score <- data.frame( class, math, english )

install.packages("plyr")
library( plyr )
ddply( score, "class", summarise, math_avg = mean(math), eng_avg = mean(english) ) # summarise 데이터 요약
ddply( score, "class", transform, math_avg = mean(math), eng_avg = mean(english) ) # transform 기존 데이터에 추가

year <- c( 2012, 2012, 2012, 2012, 2013, 2013, 2013, 2013 )
month <- c( 1, 1, 2, 2, 1, 1, 2, 2 )
value <- c( 3, 5, 7, 9, 1, 5, 4, 6)
data <- data.frame(year, month, value)

ddply( data, c( "year", "month" ), summarise, value_avg = mean(value) ) # 기준이 되는 변수를 2개 이상 묶어서 사용 가능
ddply( data, c( "year", "month" ), function(x){
  value_avg = mean( x$value )
  value_sd = sd( x$value )
  data.frame( avg_sd = value_avg / value_sd )
}) # 원하는 임의의 함수를 작성해서 사용 가능


# data.table 패키지 ----------------------------------------------------------

year <- rep( c( 2012:2015 ), each = 12000000 )
month <- rep( rep( c( 1:12 ), each = 1000000 ), 4)
value <- runif( 48000000 )
### 같은 데이터로 4800만 개의 행을 갖는 데이터프레임과 데이터 테이블을 생성
DataFrame <- data.frame( year, month, value )

install.packages("data.table")
library(data.table)
DataTable <- as.data.table( DataFrame )

### 데이터프레임의 검색 시간을 측정
system.time( DataFrame[ DataFrame$year == 2012, ])
### 데이터테이블의 검색 시간을 측정
system.time( DataTable[ DataTable$year == 2012, ]) # elapsed: 명령문의 시작부터 종료까지

### 데이터 테이블의 연도 칼럼에 키 값을 설정
### 칼럼이 키 값으로 설정될 경우 자동 오름차순 정렬
setkey( DataTable, year )
### 키 값으로 설정된 칼럼과 J 표현식을 사용한 검색 시간 측정
system.time( DataTable[ J(2012) ] ) # 키 값을 활용한 데이터 테이블의 탐색 속도가 더 빠름