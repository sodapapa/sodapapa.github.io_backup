---
layout: post
title: 만화로 배우는 리눅스 시스템 관리
---

### 목차
1. [ssh](#ssh)
2. [sudo](#sudo)
3. grep
4. vim
5. yank
6. 가상 터미널
7. 화면 분할
8. 명령어 검색이력
9. 명령어 검색이력 검색
10. scp
11. top
12. top 표시 전환
13. 파이프라인
14. 셸 스크립트
15. 셸 변수
16. 환경 변수
17. cut
18. sort & uniq
19. sort & redirect
20. 명령줄 인수
21. 조건 분기
22. 종려 상태
23. for
24. 셸 함수

---
### ssh
원격 접속 secure shell  
ssh user@192.168.0.1 // 사용자@호스트 IP

윈도우  X  
ssh -Y -C user@192.168.0.1  
nautilus

안전하지 않은 셸  
rsh - Remote SHell : 통신이 암화 되어있지 않음



### sudo
파일의 접근권하는은 파일 소유자만이 바꿀수 있지만 예외적으로  
Root 를 통해 바꿀수 있다.  
일반관리자는 Root의 권한을 부여받은 사용자이다.

권한이 없는 사용자라고 해도 관리자 권한을 사용할수있는데 이때 사용하는 명령어가 바로

sudo  
예를 들어 ``` sodu rm -r /usr/local/server/test.sh ``` 와 같이 사용한다.


### grep
문자열 검색 - Global Regular Express Print  
``grep -f "문자열" /usr/local``  
``$ grep [OPTION] [PATTERN] [FILE]``  

```
()  - 그룹화
|   - 좌우 중 하나 (or)
?   - 직전 표현이 0회 또는 1회 등장
*   - 직전 표현이 0회 이상 연속해서 등장
+   - 직전 표현이 1회 이상 연속해서 등장
.   - 임의의한 문자
^   - 줄 머리
$   - 줄 끝
```

야메노 타로   
야메노 tarou  
yameno 타로  
yameno tarou  
위 조건을 한번에 검색하는 예제

```
grep -E (야메노|yameno) ? (타로|tarou)
grep -E (야메노|yameno) * (타로|tarou)
```
```
grep options
grep [OPTION...] PATTERN [FILE...]
    -E        : PATTERN을 확장 정규 표현식(Extended RegEx)으로 해석.
    -F        : PATTERN을 정규 표현식(RegEx)이 아닌 일반 문자열로 해석.
    -G        : PATTERN을 기본 정규 표현식(Basic RegEx)으로 해석.
    -P        : PATTERN을 Perl 정규 표현식(Perl RegEx)으로 해석.
    -e        : 매칭을 위한 PATTERN 전달.
    -f        : 파일에 기록된 내용을 PATTERN으로 사용.
    -i        : 대/소문자 무시.
    -n        : 검색 결과 출력 라인 앞에 라인 번호 출력.
    -H        : 검색 결과 출력 라인 앞에 파일 이름 표시.
    -r        : 하위 디렉토리 탐색.
    -R        : 심볼릭 링크를 따라가며 모든 하위 디렉토리 탐색.
```
[grep options 참고](http://www.google.co.kr).
