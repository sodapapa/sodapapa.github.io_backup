---
layout: post
title: template
---


@delete 에서는 @seletKey를 타지 않는다.  
@update 로 변경 후에 Delete 쿼리를 호출하고 @selectkey 로 like_cnt 가지고 왔다.

selectkey의 활용.
새로 인서트 된 row의 아이디를 가져다가 map이나 vo에 담아준다.

mapper의 메서드 파라미터 형태가 int나 integer 의 경우 서비스단에서 그값을 찍어봐도  
원하는 값이 찍혀있지 않다.


객체는 참조형 변수이고 int는 기본형 변수이기 떄문에 저장되는 위치가 다르다

객체는 스택에 힙의 주소값을 저장하지만 기본형 변수는 스택에 값 자체를 저장하기 때문에

매퍼 매서드를 호출하는 시점에서 스택에 저장된 값이 사라져 버려서 mybatis가 selectkey 한 값을 넣어 줄 수 없는 것이다.
