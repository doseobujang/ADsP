# R 다운로드 ------------------------------------------------------------------

# http://www.r-poject.org


# RStudio 다운로드 ------------------------------------------------------------

# https://posit.co
# https://rstudio.com


# 단축키 -------------------------------------------------------------------

## 주석처리 Ctrl + Shift + C
## 선택 행 or 단락 실행 Ctrl + Enter
## 전체 코드 실행 Ctrl + Shift + Enter

# R 데이터 타입 ----------------------------------------------------------------

## 문자형 타입 character
class('abc')
class("abc")
class('1')
class("TRUE")

## 숫자형 타입 numeric(숫자형), double(실수), integer(정수), complex(복소수)
class(Inf)
class(1)
class(-3)

## 논리형 타입 logical
class(TRUE) 
class(FALSE)

## NaN(Not a Number), Not Available: NA(공간 차지), NULL(공간 미차지)
sqrt(-3) # NaN은 결과와 경고를 반환
class(NA)
class(NULL)


# 연산자 ---------------------------------------------------------------------

## 대입 연산자
string1 <- 'abc'
"data" -> string2
number1 <<- 15
Inf ->> number2
logical = NA

## 비교 연산자
string1 == 'abc'
string1 != 'abcd'
string2 > 'DATA'
number1 <= 15
is.numeric(number1)
is.logical(TRUE)
is.na(logical)
is.null(NULL)


## 산술 연산자
4 / 2 # 나눗셈
5 %/% 2 # 몫
5 %% 2 # 나머지

## 기타 연산자
!TRUE
TRUE&TRUE
TRUE&FALSE
!(TRUE&FALSE)
TRUE|FALSE


# R 데이터 구조 ----------------------------------------------------------------

### 시작 인덱스 값 1

## 벡터: 1차원 데이터 구조 concatenate
### 하나의 배열에 포함된 데이터는 모두 같은 타입
v4 <- c(3, TRUE, FALSE)
v4
v5 <-c('a', 1, TRUE)
v5

## 행렬: 2차원 데이터 구조
m1 <- matrix( c( 1:6 ), nrow=2 )
m1
m2 <- matrix( c( 1:6 ), ncol=2 )
m2

m3 <- matrix( c(1:6), nrow=2, byrow=T)
m3

v1 <- c(1:6)
v1
dim(v1) <- c(2,3) # c(행, 열)
v1

## 배열: 3차원 이상의 구조
a1 <- array( c(1:12), dim = c(2, 3, 2)) # c(행, 열, 차원)
a1

a2 <- c(1:12)
a2
dim(a2) <- c(2, 3, 2)
a2

## 리스트: 타입, 구조 상관없이 원하는 것을 저장할 수 있는 자료구조
L <- list()
L[[1]] <- 5
L[[2]] <- c(1:6)
L[[3]] <- matrix(c(1:6), nrow=2)
L[[4]] <- array(c(1:12), dim=c(2, 3, 2))
L

## 데이터프레임: 2차원 구조, 행렬 모양이나 여러 개의 백터로 구성되어 각 열은 서로 다른 타입의 데이터 가질 수 있음
v1 <- c(1, 2, 3)
v2 <- c('a', 'b', 'c')
df1 <- data.frame(v1, v2)
df1


# R 내장 함수 -----------------------------------------------------------------

## 기본 함수
help(paste)
?paste # 함수 도움말, 우측 하단 help 탭

paste('This is', 'a pen') # 문자열 이어 붙이기

seq(1, 10, by=2) # 시작값, 끝값, 간격으로 수열 생성

rep(1, 5) # 주어진 데이터 일정 횟수만큼 반복

a <- 1
rm(a) # 대입 연산자에 의해 생성된 변수 삭제
a

ls() # 현재까지 생성된 변수 리스트 출력

print(10) # 값을 콘솔창에 출력


## 통계 함수
v1 <- c(1:9)

sum(v1) # 합계
mean(v1) # 평균
median(v1) #중앙값
var(v1) # 표본 분산
sd(v1) # 표본 표준편차
max(v1) # 최댓값
min(v1) # 최솟값
range(v1) # 최댓값과 최솟값
summary(v1) # 요약값

### 첨도와 왜도 값 계산 함수는 별도의 패키지 필요
install.packages("fBasics")
library(fBasics)
skewness(v1) # 왜도
kurtosis(v1) # 첨도



# R 데이터 핸들링 ---------------------------------------------------------------

## 데이터 이름 변경: 2차원 이상
m1 <- matrix( c( 1 : 6 ), nrow = 2 )
colnames(m1) <- c( 'c1', 'c2', 'c3' ) # 열 이름 변경
rownames(m1) <- c( 'r1', 'r2' ) # 행 이름 변경
m1

colnames(m1) # 열 이름 출력
rownames(m1) # 행 이름 출력

df1 <- data.frame( x = c( 1, 2, 3), y = c( 4, 5 ,6))
colnames(df1) <- c( 'c1', 'c2' )
rownames(df1) <- c( 'r1', 'r2', 'r3' )
df1

## 데이터 추출
v1 <- c( 3, 6, 9, 12 )
v1[2]

m1 <- matrix( c( 1:6 ), nrow=3 )
m1[ 2, 2 ]

colnames( m1 ) <- c( 'c1', 'c2' )
m1[ , 'c1' ]

rownames( m1 ) <- c( 'r1', 'r2', 'r3' )
m1[ 'r3', 'c2' ]

### 데이터 프레임 한정 $
v1 <- c( 1 : 6 )
v2 <- c( 7 : 12 )
df1 <- data.frame( v1, v2 )
df1$v1
df1$v2[3]

## 데이터 결합
v1 <- c( 1, 2, 3 )
v2 <- c( 4, 5, 6 )
rbind( v1, v2 ) # 행으로 결합
cbind( v1, v2 ) # 열로 결합

### 재사용 규칙: 행렬끼리, 데이터프레임끼리는 행, 열 수가 같은 경우 결합 가능.
###              백터는 부족한 데이터 앞에서부터 재활용하고 오류와 함께 결과 반환
v1 <- c( 1, 2, 3 )
v2 <- c( 4, 5, 6, 7, 8 )
rbind( v1, v2 )


# 제어문 ---------------------------------------------------------------------

## 반복문
for ( i in 1:3 ){
  print( i )
}

data <- c( "a", "b", "c" )
for( i in data ){
  print(i)
}

i <- 0
while( i < 5 ){
  print(i)
  i <- i + 1
}

## 조건문
number <- 5
if (number < 5){
  print( 'number는 5보다 작다.' )
} else if ( number > 5 ){
  print( 'number는 5보다 크다.' )
} else{
  print( 'number는 5와 같다.' )
}

number <- -3
if (number < 5){
  print( 'number는 5보다 작다.' )
} else if ( number > 5 ){
  print( 'number는 5보다 크다.' )
} else{
  print( 'number는 5와 같다.' )
}

## 사용자 정의 함수
comparedTo5 <- function( number ){
  if (number < 5){
    print( 'number는 5보다 작다.' )
  } else if ( number > 5 ){
    print( 'number는 5보다 크다.' )
  } else{
    print( 'number는 5와 같다.' )
  }
}
comparedTo5( 10 )


# 통계분석에 자주 사용되는  R 함수 -----------------------------------------------------

## 숫자 연산
### sqrt 제곱근
### abs 절댓값
### exp 자연상수 e의 제곱수
### log 밑이 자연상수인 로그 값
### log10 밑이 10인 로그 값
# pi 원주율
# round 반올림
# ceiling 올림
# floor 내림

## 문자 연산
data <- 'This is a pen'
tolower( data ) # 소문자
toupper( data ) # 대문자
nchar( data ) # 문자열 길이
substr( data, 9, 13 ) # 일부분 추출
strsplit( data, 'is' ) # 구분자로 쪼갬
grepl( 'pen', data ) # 주어진 문자가 있는지 확인
gsub( 'pen', 'banana', data ) # 일부분 대체

## 벡터 연산
### length 벡터 길이
### paste 구분자 기준 결합
### cov 공분산
### cor 상관계수
### table 데이터 개수
### order 벡터 순서

## 행렬 연산
### t 전치행렬
### diag 대각행렬
### %*% 두 행렬 곱

## 데이터 탐색
x <- c( 1 : 12 ) # 벡터 생성
head( x, 5 ) # 앞 일부분
tail( x, 5 ) # 뒤 일부분
quantile( x ) # 수치 벡터의 4분위수

## 데이터 전처리
df1 <- data.frame( x = c( 1, 1, 1, 2, 2), y = c( 2, 3, 4, 3, 3 ) )
df2 <- data.frame( x = c( 1, 2, 3, 4 ), z = c( 5, 6, 7 ,8 ) ) # 임의의 데이터프레임 생성
subset( df1, x == 1 ) # 조건식에 맞는 데이터 추출
merge( df1, df2, by = c( 'x' ) ) # 두 데이터를 특정 공통된 열을 기준으로 병합
apply( df1, 1, sum ) # 데이터 행별로 함수 적용
apply( df1, 2, sum ) # 데이터 열별로 함수 적용

## 정규분포(기본값은 표준 정규 분포로 mean = 0, sd = 1)
### dnorm 정규분포의 주어진 값에서 함수 값 구함
### rnorm 정규분포에서 주어진 개수만큼 표본 추출
### pnorm 값보다 작을 확률 값을 구함
### qnorm 넓이 값을 갖는 x값을 구함

## 표본추출
### runif 균일 분포에서 주어진 개수만큼 표본 추출
### sample 주어진 데이터에서 주어진 개수만큼 표본 추출

## 날짜
Sys.Date() # 연, 월, 일 출력
Sys.time() # 연, 월, 일, 시간 출력
as.Date( "2020-01-01" ) # 주어진 데이터를 날짜 형식으로 변환
format( Sys.Date(), '%Y/%m/%d/%A//%y' )

unclass( Sys.time() ) # 시간 데이터를 unclass 하면 타임스탬프를 얻음.
                      # 타임스탬프; 1970년 1월 1일 UTC로부터 특정 날짜까지 몇 초가 흘렀는지 나타내는 값
as.POSIXct( 1737096456, origin = '1970-01-01' )

## 산점도

#### 데이터 생성
x <- c( 1 : 10 )
y <- rnorm( 10 )

#### 파라미터 type에서 p는 점, l은 직선, b는 점과 직선, n은 아무것도 표시하지 않음
#### xlim로 x축 범위, ylim y축 범위
#### xlab, ylab으로 각 축의 이름 지정
#### main으로 산점도 이름 지정
plot( x, y, type = 'l', xlim = c( -2, 12 ), ylim = c( -3, 3 ), xlab = 'X axis', ylab = 'Y axis', main = 'Test plot' )

#### abline의 v는 수직선, h는 수평선을 그리는 매개변수
#### col 매개변수로 색상 선택
abline( v = c( 1, 10 ), col = 'blue' )

## 파일 읽기 쓰기
### read.csv CSV 파일 불러옴
### write.csv 주어진 데이터를 CSV 파일로 저장
### saveRDS 분석 모델 및 R 파일 저장
### readRDS 분석 모델 및 R 파일 불러옴

## 기타
### install.pacakage 패키지 설치
### library 설치된 패키지 호출
### getwd 작업 디렉토리 확인
### setwd 작업 디렉토리 설정