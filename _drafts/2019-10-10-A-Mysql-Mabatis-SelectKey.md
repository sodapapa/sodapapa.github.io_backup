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

기본형 변수 (Primitive Type Variables)
-  값(value) 타입으로 간주되는 기본형 변수는 기본형 값을 갖는 메모리 위치이다.
- 스택(stack)에 할당된다.

② 참조형 변수 (Reference Type Variables)
- 객체와 관련된 데이터가 저장된 메모리 주소이다. (C와 C++에서의 포인터와 비교)
- 힙(heap)에 할당된다.
- 배열도 참조형 변수이다.
- 프로그래머가 메모리 주소를 직접 참조하는 것은 불가능하다.




vo에서 setter를 지우면 값을 반환하지 못함.

Mybatis 공식 홈페이지에서는 keyProperty를 여러개 받을 수 있다했는데 못받음.

[mybatis](https://mybatis.org/mybatis-3/ko/sqlmap-xml.html)

|속성	|설명   
|:--------|--------|
keyProperty |	selectKey구문의 결과가 셋팅될 대상 프로퍼티.
keyColumn	|리턴되는 결과셋의 칼럼명은 프로퍼티에 일치한다. 여러개의 칼럼을 사용한다면 칼럼명의 목록은 콤마를 사용해서 구분한다.
resultType |	결과의 타입. 마이바티스는 이 기능을 제거할 수 있지만 추가하는게 문제가 되지는 않을것이다. 마이바티스는 String을 포함하여 키로 사용될 수 있는 간단한 타입을 허용한다.
order |	BEFORE 또는 AFTER를 셋팅할 수 있다. BEFORE로 설정하면 키를 먼저 조회하고 그 값을 keyProperty 에 셋팅한 뒤 insert 구문을 실행한다. AFTER로 설정하면 insert 구문을 실행한 뒤 selectKey 구문을 실행한다. 오라클과 같은 데이터베이스에서는 insert구문 내부에서 일관된 호출형태로 처리한다.
statementType |	위 내용과 같다. 마이바티스는 Statement, PreparedStatement 그리고 CallableStatement을 매핑하기 위해 STATEMENT, PREPARED 그리고 CALLABLE 구문타입을 지원한다.



#### service 단
````
public Map<String, Object> billboardLike(Integer userId, Integer biId) {
  HashMap<String, Object> resultMap = new HashMap<String, Object>();
  HashMap<String, Object> paramMap = new HashMap<String, Object>();
  TnBillboardLike tnBillboardLike = new TnBillboardLike();

  tnBillboardLike.setBiId(biId);
  tnBillboardLike.setUserId(userId);

  int likeCnt =  tnBillboardLikeMapper.billboardLikeCnt(tnBillboardLike);
  Integer likeCnt3 = null;

  if(likeCnt <= 0 ) { // 좋아요 처리
    tnBillboardLikeMapper.insertBillboardLike(tnBillboardLike);
    resultMap.put("likeYn", "Y");

  }else { // 좋아요 해제 처리

    tnBillboardLikeMapper.deleteBillboardLike(tnBillboardLike);
    resultMap.put("likeYn", "N");
  }

  int likeCnt2 = tnBillboardLike.getLikeCnt();
  int uselessCnt = tnBillboardLike.getUselessCnt();
  logger.debug("likeCnt : {} , uselessCnt : {} " , likeCnt2,uselessCnt);

  paramMap.put("likeCnt", likeCnt2);
  paramMap.put("biId", biId);
  tnBillboardInfoMapper.setLikeCnt(paramMap);

  return ApiResponse.makeResponse(resultMap);
}
````



### mapper
```
public interface TnBillboardLikeMapper {

	@Select(""
			+ "     "
			+ "   SELECT COUNT(1) FROM tn_billboard_like WHERE bi_id = #{biId} AND user_id = #{userId} "
			+ "     "
			+ "")
	int billboardLikeCnt(TnBillboardLike tnBillboardLike);

	@SelectKey(before = false,  keyProperty = "likeCnt", resultType = int.class, statement = ""
			+ "SELECT COUNT(*) as likeCnt3 From tn_billboard_like where BI_ID = #{biId}" )
	@Insert(""
			+ "  INSERT INTO tn_billboard_like "
			+ "              (BI_ID, "
			+ "               USER_ID, "
			+ "               REG_DT) "
			+ "  VALUES (#{biId}, "
			+ "          		#{userId}, "
			+ "          		now() ) "
			+ "   "
			+ "")
	void insertBillboardLike(TnBillboardLike tnBillboardLike);

	@SelectKey(before = false,  keyProperty = "likeCnt", resultType = int.class, statement = ""
			+ "SELECT COUNT(*) as likeCnt From tn_billboard_like where BI_ID = #{biId}" )
	@Update(""
			+ "  DELETE  "
			+ "  FROM tn_billboard_like  "
			+ "  WHERE BI_ID = #{biId}  "
			+ "      AND USER_ID = #{userId}  "
			+ "    "
			+ "")
	void deleteBillboardLike(TnBillboardLike tnBillboardLike);

}

```


#### VO
```
@JsonInclude(Include.NON_DEFAULT)
public class TnBillboardLike implements Serializable{

	private static final long serialVersionUID = 1L;


	private int biId;
	private int userId;
	private String regDt;
	private int likeCnt;

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		 this.likeCnt = likeCnt;
	}

	public int getBiId() {
		return biId;
	}

	public void setBiId(int biId) {
		this.biId = biId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
```
