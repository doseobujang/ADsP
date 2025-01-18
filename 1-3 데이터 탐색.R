# 붓꽃(IRIS) 데이터 ------------------------------------------------------------

## IRIS 데이터 가져오기
head( iris, 3 )

## 기초 통계량
summary( iris )

## 데이터 구조 파악
str(iris)


# 결측값 ---------------------------------------------------------------------

copy_iris <- iris # 원본 데이터를 유지
copy_iris[ sample( 1 : 150, 30), 1 ] <- NA # Sepal.Length에 30개의 결측값 생성

install.packages("Amelia")
library( Amelia )
missmap( copy_iris )


# 단순 대치법 ------------------------------------------------------------------

## 테스트를 위한 결측값을 가진 iris 데이터 생성
copy_iris <- iris # 원본 데이터 유지
dim( copy_iris ) # 기존 데이터 수
copy_iris[ sample( 1 : 150, 30), 1 ] <- NA # Sepal.Length에 30개의 결측값 생성

copy_iris <- copy_iris[ complete.cases( copy_iris ), ] # 단순대치법
dim( copy_iris ) # 30개의 결측값을 보유한 행을 제거한 데이터의 수
missmap( copy_iris )


# 평균 대치법 ------------------------------------------------------------------

## 테스트를 위한 결측값을 가진 iris 데이터 생성
copy_iris <- iris # 원본 데이터를 유지
copy_iris[ sample( 1 : 150, 30 ), 1 ] <- NA # Sepal.Length에 30개의 결측값 생성

## 평균 대치
meanValue <- mean( copy_iris$Sepal.Length, na.rm = T ) # 결측값을 제외한 평균 계산
copy_iris$Sepal.Length[ is.na( copy_iris$Sepal.Length ) ] <- meanValue # 평균 대치

## centralImputation을 활용한 중앙값 대치
install.packages("DMwR2")
library( DMwR2 )
copy_iris[ sample( 1 : 150, 30 ), 1] <- NA
copy_iris <- centralImputation( copy_iris )


# 단순 확률 대치법 ---------------------------------------------------------------

## 테스트를 위한 결측값을 가진 iris 데이터 생성
copy_iris <- iris # 원본 데이터를 유지
copy_iris[ sample( 1 : 150, 30 ), 1 ] <- NA # Sepal.Length에 30개의 결측값 생성

copy_iris <- knnImputation( copy_iris, k=10 )


# 다중 대치법 ------------------------------------------------------------------

## 테스트를 위한 결측값을 가진 iris 데이터 생성
copy_iris <- iris # 원본 데이터를 유지
copy_iris[ sample( 1 : 150, 30 ), 1 ] <- NA # Sepal.Length에 30개의 결측값 생성

library( Amelia )
iris_map <- amelia( copy_iris, m = 3, cs = "Species" ) # cs는 cross-sectional로 분석에 포함될 정보를 의미
## 위 amelia에서 m값을 그대로 imputation의 데이터셋에 사용
copy_iris$Sepal.Length <- iris_map$imputations[[3]]$Sepal.Length


# 사분위수 --------------------------------------------------------------------

## 테스트를 위한 임의 데이터 생성
data <- c( 3, 10, 13, 16, 11, 20, 17, 25, 43 )
boxplot( data, horizontal = T )
