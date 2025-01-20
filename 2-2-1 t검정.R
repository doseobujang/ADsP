# 일(단일) 표본 단측 t-검정 ------------------------------------------------------------

## 일 표본 단측 t-검정을 위한 지우개 10개의 표본추출
weights <- runif( 10, min= 49, max = 52 )
t.test( weights, mu = 50, alternative = 'greater' ) # 대립가설, 반대 방향은 'less'


# 일 표본 양측 t-검정 ------------------------------------------------------------

## 일 표본 양측 t-검정을 위한 40kg ~ 100kg 사이 남성 100명의 표본을 추출
weights <- runif( 100, min = 40, max = 100 )
t.test( weights, mu = 70, alternative = 'two.sided' )


# 이(독립) 단측 표본 t-검정 -----------------------------------------------------------

## 이 표본 단측 t-검정을 위해 각 집단별로 100개씩 표본추출
salaryA <- runif( 100, min = 250, max = 380 )
salaryB <- runif( 100, min = 200, max = 400 )
t.test( salaryA, salaryB, alternative = 'less' ) # salaryA - salaryB < 0


# 이 표본 양측 t-검정 --------------------------------------------------------------

## 이 표본 양측 t-검정을 위해 각 집단별로 100개씩 표본추출
speedK <- runif( 100, min = 30, max = 40 )
speedL <- runif( 100, min = 25, max = 35 )
t.test( speedK, speedL, alternative = 'two.sided' )


# 대응 표본 t-검정 --------------------------------------------------------------

## 대응 표본 t-검정을 위한 표본추출
before <- runif( 10, min = 60, max = 80 )
after <- before + rnorm( 10, mean = -3, sd=2 )
t.test( before, after, alternative = 'greater', paired = TRUE )
