# 다차원 척도법 -----------------------------------------------------------------

cal <- c( 52, 160, 89, 57, 34, 32, 30, 69 )
car <- c( 112.4, 8.5, 22.8, 14.5, 8.2, 7.7, 7.6, 18.1 )
fat <- c( 0.2, 14.7, 1.3, 0.7, 0.2, 0.3, 0.2, 0.2 )
pro <- c( 0.3, 2.0, 1.1, 0.3, 0.8, 0.7, 0.6, 0.7 )
fib <- c( 2.4, 6.7, 2.6, 2.4, 0.9, 2.0, 0.4, 0.9 )
sug <- c( 10.4, 0.7, 12.2, 9.9, 7.9, 4.7, 6.2, 15.5 )
fruits <- data.frame( cal, car, fat, pro, fib, sug ) # 데이터 프레임 생성
rownames(fruits) <- c( "apple", "avocado", "banana", "bluberry", "melon", "watermelon", "strawberry", "grape" )
                    # 각 데이터(행)에 이름을 부여
fruits_dist <- dist( fruits ) # 데이터별 거리 측정
fruits_loc <- cmdscale( fruits_dist )
x_loc <- fruits_loc[ , 1 ]
y_loc <- fruits_loc[ , 2 ]
plot( x_loc, y_loc, type = 'n' ) # type = 'l'은 연결선, 'p'는 점, 'n'은 찍지 않음
text( x_loc, y_loc, rownames( fruits ))
abline( v = 0, h = 0 )


# 주성분 분석 ------------------------------------------------------------------

result <- prcomp( fruits, center = T, scale. = T ) # center와 scale 값을 T로 표준화하여 변수 간 단위 제거
result
summary( result )

screeplot( result, type = 'lines' )
biplot( result )