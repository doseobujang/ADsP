# 일원분산분석 ------------------------------------------------------------------

## 분산분석을 위한 데이터 생성
phoneSpeed <- runif( 45, min = 75, max = 100 )
telecom <- rep( c( 'A', 'B', 'C' ), 15 )
phoneData <- data.frame( phoneSpeed, telecom )

result <- aov( data = phoneData, phoneSpeed ~ telecom )
summary( result )
