# 계층적 군집분석 ----------------------------------------------------------------

x = c( 2, 1, 6, 3, 3 )
y = c( 4, 2, 4, 3, 1 )
data = data.frame( x, y )# 데이터 생성

rownames( data ) <- c( 'A', 'B', 'C', 'D', 'E' )

dist_data <- dist( data, method = 'euclidean' ) # 거리 행렬 데이터 생성
                                  # 기본값, manhattan, minkowski 등 있음

print( dist_data )

hclust_data <- hclust( dist_data, method = 'single' ) # 군집분석 수행
                                            # 최단열결법, 기본값 complete, 그 외에 average 등

plot( hclust_data ) # 결과 시각화

abline(h=2.1) # Height 값을 2.1로 설정하면


# k-means 군집 --------------------------------------------------------------

cal <- c( 52, 160, 89, 57, 34, 32, 30, 69 )
car <- c( 112.4, 8.5, 22.8, 14.5, 8.2, 7.7, 7.6, 18.1 )
fat <- c( 0.2, 14.7, 1.3, 0.7, 0.2, 0.3, 0.2, 0.2 )
pro <- c( 0.3, 2.0, 1.1, 0.3, 0.8, 0.7, 0.6, 0.7 )
fib <- c( 2.4, 6.7, 2.6, 2.4, 0.9, 2.0, 0.4, 0.9 )
sug <- c( 10.4, 0.7, 12.2, 9.9, 7.9, 4.7, 6.2, 15.5 )
fruits <- data.frame( cal, car, fat, pro, fib, sug )
rownames(fruits) <- c( "apple", "avocado", "banana", "bluberry", "melon", "watermelon", "strawberry", "grape" )

## 군집의 중심과 개체 사이의 거리를 구하는데 단위의 문제가 발생할 것으로 예상된다면
## 표준화를 통해 단위 문제 해결
fruits <- as.data.frame( scale( fruits, center = T, scale = T ))

result <- kmeans( fruits, centers = 3 ) # 초깃값(K, 군집의 수)를 3으로 설정하고 군집수행
result$centers # 각 군집의 중심

fruits$cluster <- result$cluster # 원본 데이터에 군집을 추가
head(fruits)

install.packages("flexclust") 
library(flexclust)
data(Nclus) # 군집분석을 위한 내장 데이터인 Nclus 활용

result <- kmeans( Nclus, 3 )
plot( Nclus, col = result$cluster, xlim = c( -7, 10 ), ylim = c( -4, 10 ), xlab = ' ', ylab = ' ' ) # 시각화

par( new = T )
plot( result$centers, pch = 3, cex = 3, xlim = c( -7, 10 ), ylim = c( -4, 10 ), xlab = ' ', ylab = ' ' ) # 군집 중심 표시 


# DBSCAN ------------------------------------------------------------------

install.packages("fpc")
library(fpc)

data <- data.frame(
  x = c( sample( 1:10, 15, replace = T), sample( 20:30, 10, replace = T) ),
  y = c( sample( 1:10, 15, replace = T), sample( 20:30, 10, replace = T) )
) # DBSCAN을 수행할 데이터 생성

plot(data) # 데이터 프레임 시각화

dbscan_result <- dbscan( data, eps = 5, MinPts = 3 ) # 5라는 거리 안에 3개의 점이 있다면 하나의 그룹으로 군집화
plot( data, col = dbscan_result$cluster )


# 혼합 분포 군집 ----------------------------------------------------------------

## 미국의 온천 분출 시간 자료가 담긴 내장 데이터 faithful의 waiting 열을 활요
install.packages("mixtools")
library( mixtools )
waiting <- faithful$waiting
hist( waiting )

result <- normalmixEM( waiting ) # normalmixEM을 활용하여 혼합 분포 군집 수행
summary(result)

plot( result, density = T )


# 자기조직화지도 -----------------------------------------------------------------

cal <- c( 52, 160, 89, 57, 34, 32, 30, 69 )
car <- c( 112.4, 8.5, 22.8, 14.5, 8.2, 7.7, 7.6, 18.1 )
fat <- c( 0.2, 14.7, 1.3, 0.7, 0.2, 0.3, 0.2, 0.2 )
pro <- c( 0.3, 2.0, 1.1, 0.3, 0.8, 0.7, 0.6, 0.7 )
fib <- c( 2.4, 6.7, 2.6, 2.4, 0.9, 2.0, 0.4, 0.9 )
sug <- c( 10.4, 0.7, 12.2, 9.9, 7.9, 4.7, 6.2, 15.5 )
fruits <- data.frame( cal, car, fat, pro, fib, sug )
names <- c( "apple", "avocado", "banana", "bluberry", "melon", "watermelon", "strawberry", "grape" )
rownames(fruits) <- names

install.packages('kohonen')
library(kohonen) # kohonen 패키지 호출

fruits_scaled <- scale( fruits, center = T, scale = T ) # fruits 데이터 표준화
result <- som( fruits_scaled, grid = somgrid(3, 1)) # 자기조직화지도 수행, 경쟁층 노드 수는 1 X 3으로 3개

par( mfrow = c( 1, 2 ) )
plot( result )
plot( result, type = 'mapping', labels = names )