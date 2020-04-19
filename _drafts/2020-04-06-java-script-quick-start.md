---
layout: post
title: javascript
---

javascript > docuement object > window object

초창기 javascript는 사용자 입력폼의 값 검증을 위한 것이었다.
브라우저에서 서버자원을 요청하기전에 유효성 검사를 요청
클라이언트의 자원의 활용하여 입력값을 검증하기 때문에 서버의 자원 낭비를 막을 수가 있다.

자바스크립트의 변수의 관하여

무적의 'var' 인가?
한정사가 표현해주는 정보를 어떻게 확인해야할까?
크기에 관하여 변수의 크기가 먼저 할당되고 거기에 딱 맞는 값이 들어가는 것이 아니라
선언된 순간에는 크기를 할당 받지 않고 있다가 값이 초기화 되어 들어갈 때에 변수의 크기 또한 할당되게 된다. 이를 오토 박싱이라고 한다.
여기서 변수명은 그 값을 가르키는 포인터의 역할이 아니라 그것을 가르키는 참조가 된다.
결국 자바스크립트의 모든 변수는 참조 변수이다. -> 기본 형식이라는 것은 존재하지 않는다.

undefined의 의미 이름은 있으나 아직까지 객체를 할당 받지 않은 상태
undefined 자체가 하나의 특수한 값이 된다.

```
var x;
alert(x == undefined);
```

이러한 형식으로 값을 비교해야한다. 문자열로 비교하면 안된다.
여태까지 null로 비교했었는데? 그것은 안되낭? 무슨 문제가 있을까.


javascript Array 객체는 push와 pop를 이용하여 stack처럼 사용할 수도 있으며
인덱스를 이용하여 List처럼 사용할 수 도 있다.

Array 객체의 초기화
자바스크립트 배열의 가장 큰 특징은 배열 안에 항목들이 단일한 값을 같지 않을 수도 있다는 것이다.
```
var nums = new Array();
var nums = new Array(5);
var nums = new Array(5, 12, 21);
var nums = new Array(5, 12, 21, "hello");

console.log(typeof nums[3]) => string
var nums = new Array(5, 12, 21, "hello", new Array(5, 12, 21));

console.log(nums[4][2]) => 이 값은 21
```

splice() 메서드

```
nums.splice(2)
2번 인덱스 이후의 값을 모두 지운다.

nums.splice(2,1)
2번 인덱스 부터 1개 만큼 지운다.

nums.splice(2,1,3)
2번 인덱스부터 1개만큼 지우고 3을 채워 넣는다.

nums.splice(2,0,3)
2번 인덱스부터 0개만큼 지우고 3을 채워 넣는다.

```
