---
layout: post
title: mysql limit paging
---
MySQL 에서는 다음과 같이 countPage = 10 일 때 3 페이지의 게시물을 가져올 수 있습니다.


```
select id, name, content, createdate
from board
order by createdate
limit  (3 - 1) * 10, 10
```

MySQL 의 LIMIT 은 두 개의 매개변수를 가지는데,

첫번째 매개변수는 시작 위치, 두번째 매개변수는 가져올 게시물 수 입니다.

그래서 20 이후의 게시물 10 개를 가져오게 됩니다.

주의할 것은 매개변수를 1 개만 가질 수도 있는데, 이 때에는 통상적인 것처럼 첫번째 매개변수만 사용하는 것이 아니라 두번째 매개변수만 사용한다는 것입니다.


그러므로 limit 10 이라고 하면 limit 0, 10 와 동일한 것이 된다는것.

현재 솔루션에서는 limit 의 첫번째  매개변수를 offset 처럼 사용하고 있다.

`select * from tb_temp limit 20,30`

그리드 조회시 모두 이와 같은 쿼리를 사용하고 있는데 api에서 페이징 처리를 하다 잘못 된것을 발견했다.



Select  * from 테이블명 orders LIMIT 숫자(★);

숫자만큼의 행 출력

Ex) 10행 출력

select * from member ORDERS LIMIT 10;



Select * from 테이블명 orders LIMIT 숫자(★) OFFSET 숫자(♥);

LIMIT 숫자 : 출력할 행의 수

OFFSET 숫자 : 몇번째 row부터 출력할 지. (1번째 row면 0)

Ex) 10행씩 출력

1페이지 : select * from member ORDERS LIMIT 10 OFFSET 0;

2페이지 : select * from member ORDERS LIMIT 10 OFFSET 10;



Select * from 테이블명 orders LIMIT 숫자1(♥), 숫자2(★);

숫자1 : ♥번째 row부터 출력

숫자2 : ★개의 행 출력

Ex) 10행씩 출력

1페이지 : select * from member ORDERS LIMIT 0, 10;

2페이지 : select * from member ORDERS LIMIT 10, 10;
