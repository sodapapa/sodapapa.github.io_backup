---
layout: post
title: count SubQeuery
---
mybatis 의 리턴 타입으로 선언한 VO에서 특정 컬럼의 값이 0이고  
Vo 에서 그 값이 매핑될때 자료형이 int 인 경우에   
쿼리 조회 결과 0이 화면으로 json으로 리턴되지 않는 경우가 발생하였다.

```
select *,  (select Count(*) from tn_board_like tbl where tbl.board_id = tb.board_id ) from tn_board tb
