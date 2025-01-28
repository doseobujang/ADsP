# 연관분석 --------------------------------------------------------------------

items <- c( 'chicken', 'coke', 'cider' )
count <- sample( 3, 100, replace = T )
transactionId <- c() # 거래 번호
transactionItem <- c() # 아이템 번호( '치킨', '콜라', '사이다' )
for( i in 1:100 ){
  current_transaction <- sample( items, count[ i ] )
  for( j in 1 : length( current_transaction ) ){
    transactionId <- c( transactionId, i )
    transactionItem <- c( transactionItem, current_transaction[ j ] )
  }
} # 연관분석을 위한 거래 데이터 생성

transaction <- data.frame( transactionId, transactionItem )
head( transaction, 4 )

install.packages('arules')
library(arules) # 연관분석을 위한 apriori 패키지 호출

transactionById <- split( transaction$transactionItem, transaction$transactionId ) # 데이터 전처리
transactionById_processed <- as( transactionById, 'transactions' ) # as와 파라미터 값으로 'transactions'를 사용하여
                                                                   # 거래 데이터로 변환
result <- apriori( transactionById_processed, parameter = list( supp = 0.2, conf = 0.7 ) ) # 연관분석 실시
                                              # parameter를 활용하여 최소 지지도(supp), 최소 신뢰도(conf) 설정 가능
                                                                           # 기본값 0.1          기본값 0.8
result # 몇 개의 규칙이 발견되었는지 확인
inspect( result )