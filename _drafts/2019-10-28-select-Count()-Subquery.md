---
layout: post
title: count SubQeuery
---
mybatis 의 리턴 타입으로 선언한 VO에서 특정 컬럼의 값이 0이고  
Vo 에서 그 값이 매핑될때 자료형이 int 인 경우에   
쿼리 조회 결과 0이 화면으로 json으로 리턴되지 않는 경우가 발생하였다.

```
select *,  
    (select Count(*)  
    from tn_board_like tbl  
    where tbl.board_id = tb.board_id )  as like_cnt
from tn_board tb
````

대략적으로 이런 코드였는데

왜 service 단으로 넘어왔을떄는 getLikeCnt 를 하면 0이 찍히는 데
json형식으로  화면에 보냈을 때 값이 보이지 않는 지 의문임.

소스 코드를 정리해서 okky 에 질문글을 올려봐야겠다.
