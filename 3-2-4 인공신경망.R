# 인공신경망 -------------------------------------------------------------------

install.packages('neuralnet') 
library(neuralnet)

index <- sample( c( 1, 2 ), nrow( iris ), replace = T, prob = c( 0.7, 0.3 ))
train <- iris[ index == 1, ]
test <- iris[ index == 2, ]

## act.fct 활성함수로 기본값은 logistic(Sigmoid)
result <- neuralnet( data = train, Species ~ ., hidden = c( 4, 4 ), stepmax = 1e7 )
pred <- predict( result, newdata = test )
head( pred, 5 )

## train 데이터로 구축된 모형을 test 데이터로 검정
## 가장 큰 값을 갖는 노드를 명목형으로 변환하기
predicted_class <- c()
for( i in 1 : nrow(test)){
  loc <- which.max(pred[i, ])
  if(loc==1){
    predicted_class <- c( predicted_class, 'setosa')
  }else if(loc==2){
    predicted_class <- c(predicted_class, 'versicolor')
  }else{
    predicted_class <- c(predicted_class, 'virginica')
  }
}

head( predicted_class, 5 ) # 명목형 변수로 바뀐 것을 확인 가능

pred <- predict( result, newdata = test )
table( condition = test$Species, predicted_class )

plot( result ) # 신경망 시각화