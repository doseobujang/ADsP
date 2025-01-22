# 단순선형회귀분석 ----------------------------------------------------------------

X <- c( 1, 1.4, 1.6, 2, 2.2, 2.4, 3, 3.3, 3.6 )
Y <- c( 15, 13,13, 12, 11, 10.5, 10, 9, 8 )
result <- lm( Y ~ X ) # lm = linear model
summary( result )

anova( result ) # 분산분석표


# 다중선형회귀분석 ----------------------------------------------------------------

yard <- c( 31, 31, 27, 39, 30, 32, 28, 23, 28, 35 )
area <- c( 58, 51, 47, 35, 48, 42, 43, 56, 41, 41 )
park <- c( 1, 1, 5, 5, 2, 4, 5, 1, 1, 3 )
dist <- c( 492, 426, 400, 125, 443, 412, 201, 362, 192, 423 )
price <- c( 12361, 12084, 12220, 15649, 11486, 12276, 15527, 12666, 13180, 10169 )
result <- lm( price ~ yard + area + park + dist )
summary( result )


# 전진선택법 -------------------------------------------------------------------

popul <- c( 4412, 2061, 4407, 1933, 4029, 4180, 3444, 1683, 3020, 4459 )
result <- step( lm( price ~ 1 ), scope = list( lower = ~ 1, upper = ~ yard + area + park + dist + popul ), 
                direction = 'forward' ) # lm( price ~ 1 ) -> 절편만 있는 모형에서 시작
summary( result )


# 후진제거법 -------------------------------------------------------------------

result <- step( lm( price ~ yard + area + park + dist + popul ), 
                scope = list( lower = ~1, upper = ~ yard + area + park + dist + popul ), direction = 'backward' )
                # 모든 변수가 포함된 모형에서 시작
summary( result )


# 단계별 방법 ------------------------------------------------------------------

result <- step( lm( price ~ 1 ), scope = list( lower =~1, upper = ~ yard + area + park + dist + popul ), 
                direction = 'both' )
summary( result )