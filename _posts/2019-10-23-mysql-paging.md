---
layout: post
title: mysql Limit ,Offset
---

## Limit
MySql의 Limit는 두 개의 매개 변수를 가진다.
첫번째는 조회를 시작할 리스트의 위치,  두번째는 조회할 리스트의 수 이다.
따라서 위의 코드는 20개 이후의 10개를 select하는 쿼이다.

```
select id, name, content, createdate
from board
order by createdate
limit  (3 - 1) * 10, 10
```   

주의할 것은 매개변수를 하나만 가지는 경우다
이때는 limit 10 이라고 하면 limit 0, 10 와 동일한 것이 된다는것.

현재 솔루션에서는 limit 의 첫번째  매개변수를 offset 처럼 사용하고 있다.

``select * from tb_temp limit 20,30``


JQgrid 조회시 모두 이와 같은 쿼리를 사용하고 있는데, api에서 페이징 처리를 하다 잘못 된것을 발견했다.

``select * from tb_temp limit #{(pageNo - 1) * pageSize }, #{pageSize}``

이렇게 수정해야 정상적으로 조회가 된다.

*****

## Offest & Limit
offset은 limit와 함께 사용해야한다.

select * from tb_temp offset 5 와 같은 쿼리를 실행할 수는 없다.
        
Select  * from 테이블명 orders LIMIT 숫자(★);

숫자만큼의 행 출력

Ex) 10행 출력
select * from member ORDERS LIMIT 10;
Select * from 테이블명 orders LIMIT 숫자(★) OFFSET 숫자(♥);

LIMIT 숫자 : 출력할 행의 수
OFFSET 숫자 : 몇번째 row부터 출력할 지. (1번째 row면 0) 이갯수 만큼까고 리스트가 시작한다고 봄.


Ex) 10행씩 출력
1페이지 : select * from member ORDERS LIMIT 10 OFFSET 0;
2페이지 : select * from member ORDERS LIMIT 10 OFFSET 10;

Select * from 테이블명 orders LIMIT 숫자1(♥), 숫자2(★);

숫자1 : ♥번째 row부터 출력 (시작위치)
숫자2 : ★개의 행 출력 (몇개 뽑을지)

Ex) 10행씩 출력
1페이지 : select * from member ORDERS LIMIT 0, 10;
2페이지 : select * from member ORDERS LIMIT 10, 10;
