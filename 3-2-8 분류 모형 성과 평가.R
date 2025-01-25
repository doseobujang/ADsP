# ROC 커브 ------------------------------------------------------------------

## 이진 분류(0 or 1)를 목적으로 setosa와 versicolor만 추출
iris_bin1 <- subset( iris, Species == 'setosa' | Species == 'versicolor')

## setosa를 1로, setosa가 아닌 경우(versicolor)를 0으로 변경
iris_bin1$Species <- ifelse( iris_bin1$Species == 'setosa', 1, 0 )

iris_bin1 <- iris_bin1[ , c( 1, 2, 5 ) ]

## 데이터 분할
index <- sample( 2, nrow( iris_bin1 ), replace = T, prob = c( 0.7, 0.3 ))
train <- iris_bin1[ index == 1, ]
test <- iris_bin1[ index == 2, ]

## 의사결정나무를 활용하여 ROC커브 작성
## ROC커브를 그리기 위해서 하나의 집단에 속할 확률값들이 필요
## setosa(1번) 그룹에 속할 확률 값들을 계산
library(rpart)
result <- rpart( Species ~ ., data = train )
pred <- predict( result, newdata = test )
head(pred) # 각 테스트 케이스마다 1번에 속할 확률값을 반환

test$pred <- pred # test 데이터에 1번 집단에 속할 확률 추가
head(test, 3)

install.packages('Epi') # ROC커브를 그리기 위한 Epi 패키지 호출
library(Epi)
ROC( form = Species ~ pred, data = test, plot = 'ROC' )


# 향상도 곡선 ------------------------------------------------------------------

## 앞 ROC 커브를 그리기 위해 사용한 테스트셋 호출
install.packages('ROCR')
library(ROCR) # 향상도 곡선을 그리기 위한 ROCR 패키지 호출

## 실제 집단과 집단에 포함될 예측 확률로 향상도 곡선을 그리기 위한 준비
lift_value <- prediction( test$pred, test$Species )

plot( performance( lift_value, 'lift','rpp')) # 향상도 곡선

abline( v = 0.4, lty = 2, col = 'blue' )
abline( v = 0.58, lty = 2, col = 'blue' )