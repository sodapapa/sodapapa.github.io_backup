---
layout: post
title: select key
---
insert 후에 AUTO_INCREMENT 로 생성된 pk 값을 가져오려고하는데
service 단에서 아무리 로그를 찍어봐도 값이 1이 찍혀서 문제가 됨.

https://vesselsdiary.tistory.com/59

이글을 통해서 힌트를 얻고 mapper를 호출할 때 포함한 파라미터 vo에서
getKey()를 하니까 그안에 새로 생성된 pk의 값이 들어있었다..


왜 쿼리를 리턴 받는 값에는 1이 찍히고 파라미터로 던진 vo에는 pk가 담겨 있는 지 모르겠음.



```

@SelectKey(before = false,  keyProperty = "bcId", resultType = int.class, statement = ""
			+ "SELECT LAST_INSERT_ID() as bcId" )


@SelectKey(before = false,  keyProperty = "testId", resultType = int.class, statement = ""
			+ "SELECT LAST_INSERT_ID() as testId" )
	@Insert(""
			+ "  INSERT INTO tn_billboard_comment   "
			+ "              ("
			+ "               BI_ID,   "
			+ "               BC_CONTENTS,   "
			+ "               DELETE_YN,   "		
			+ "               REG_TYPE,   "
			+ "               REG_ID,   "
			+ "               REG_DT,   "
			+ "               MOD_TYPE,   "
			+ "               MOD_ID,   "
			+ "               MOD_DT)   "
			+ "  VALUES (  "
			+ "          #{biId},   "
			+ "          #{bcContents},   "
			+ "          'N' ,   "
			+ "          'U',   "
			+ "          #{regId},   "
			+ "          now(),   "
			+ "          'U',   "
			+ "          #{modId},   "
			+ "          now()  )   "
			+ "")
	int setComment(TnBillboardComment tnbillboardComment);
```


keyProperty 값을 변경하니까 아래처럼 에러가 났다.
```
ERROR|2019-10-23 17:13:44,081|T100000002|com.ljsnc.api.exception.JaxRsExceptionMapper 36|Unmanaged Exception
org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.executor.ExecutorException:
No setter found for the keyProperty 'testId' in com.ljsnc.api.model.TnBillboardComment
`````
myBatis 에서 매개변수에 접근하여 값을 설정해주는것 같다.


그럼 매개변수가 Map 일때는 어떻게 되는거징?

map 으로 던져도 정상적으로 key properties 값이 추가되어 반환된다.

{bcContents=bcContents, regId=44, biId=4, modId=44}
{bcId=21, bcContents=bcContents, regId=44, biId=4, modId=44}

keyProperty 값의 setter 가 없으면 에러가 나는 VO보다는
일단은 Map에 값을 넣어 주는게 좋은 것같다.
