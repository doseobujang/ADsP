# 로지스틱 회귀분석 ---------------------------------------------------------------

## 이진분류를 위해 3개의 범주를 보유한 iris의 Species를 두 개의 범주만 갖도록 추출
iris_bin1 <- subset( iris, Species == 'setosa' | Species == 'versicolor' )
str( iris_bin1 )

## Species ~ .은 Species를 종속변수, 나머지 변수를 독립변수로 활용하겠다는 의미
## family = 'binomial'은 glm*을 로지스틱 회귀분석으로 사용하겠다는 의미
                          # general linear model
result <- glm( data = iris_bin1, Species ~ ., family = 'binomial' )
## '알고리즘이 수렴하지 않았습니다.' 경고 문구는 control 값으로 조정 가능
result <- glm( data = iris_bin1, Species ~ ., family = 'binomial', control = list( maxit = 50))
## '적합된 확률 값들이 0 또는 1 입니다.' 경고 문구는 100%로 분류 가능을 의미

pairs( iris_bin1, col = iris_bin1$Species )

result <- glm( data = iris_bin1, Species ~ Petal.Width, family = 'binomial', control = list( maxit = 50))
result <- glm( data = iris_bin1, Species ~ Petal.Length, family = 'binomial', control = list( maxit = 50))

result <- glm( data = iris_bin1, Species ~ Sepal.Length, family = 'binomial', control = list( maxit = 50))
summary( result )

## glm 함수를 활용한 로지스틱 회귀분석 결과는 p-value 값을 바로 알려주지 않음
## 직접 구해서 모형의 기각 여부 판단
1 - pchisq( 138.629, df = 99 )
1 - pchisq( 64.211, df = 98 )


# 의사결정나무 ------------------------------------------------------------------

## 데이터 마이닝을 위한 데이터 분할 시행
## train 데이터는 index 값을 1로 70%, test 데이터는 index 값을 2로 30% 생성
index <- sample( c( 1, 2), nrow(iris), replace = T, prob = c( 0.7, 0.3 ))
train <- iris[ index == 1, ]
test <- iris[ index == 2, ]

install.packages('rpart')
library(rpart)
result <- rpart( data = train, Species ~ . )
plot( result, margin = 0.3 ) # margin으로 그래프 외곽 여백 두께 조정
text(result)

pred <- predict( result, newdata = test, type = 'class' ) # 검정
## test 데이터의 실제값 condition과 예측값 pred로 표 작성
table( condition = test$Species, pred )

result


# 앙상블 분석 ------------------------------------------------------------------

install.packages('adabag')
library(adabag)

index <- sample( c( 1, 2), nrow(iris), replace = T, prob = c( 0.7, 0.3 ))
train <- iris[ index == 1, ]
test <- iris[ index == 2, ]

## 배깅
### 의사결정나무 개수를 정하는 매개변수 mfinal = 100 이 기본값
result <- bagging( data = train, Species ~ . )

### 첫 번째 의사결정나무
plot( result$trees[[1]], margin = 0.3 )
text( result$trees[[1]])

### 백 번째 의사결정나무
plot( result$trees[[100]], margin = 0.3 )
text( result$trees[[100]])

pred <- predict( result, newdata = test )
table( condition = test$Species, pred$class )


## 부스팅
result <- boosting( data = train, Species ~ ., boos = T, mfinal = 10 ) # boos = T 값을 주어야 가중치 값을 조정

plot( result$trees[[1]], margin = 0.3 )
text( result$trees[[1]]) # 첫 번째 의사결정 나무

plot( result$trees[[10]], margin = 0.3 )
text( result$trees[[10]]) # 가중치가 조정되면서 생성된 열 번째 의사결정나무

pred <- predict( result, newdata = test )
pred$confusion


## 랜덤 포레스트
install.packages("randomForest")
library(randomForest)

result <- randomForest( Species ~ ., data = train, ntree = 100 )
pred <- predict( result, newdata = test )
table( condition = test$Species, pred )