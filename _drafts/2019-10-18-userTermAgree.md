---
layout: post
title: dycis-회원약관동의 좀더 쉽게 리팩토링 해볼것...
---
```
public Map<String, Object> termAgree(String authToken, Integer userId, String termType) {

		List<String> Test = Arrays.asList(termType.split("\\^"));
		System.out.println("test " + Test.toString());

		String arrTermType[] = termType.split("\\^");

		List<TnTermInfo> items = new ArrayList<TnTermInfo>();

		for (int i = 0; i < arrTermType.length; i++) {

			TnTermInfo tmpTnTermInfo = new TnTermInfo();
			tmpTnTermInfo.setTermType(arrTermType[i]);
			items.add(tmpTnTermInfo);
		}

		List<TnTermInfo> tnTermInfo = tnTermInfoMapper.findTermInfoListUrByTermType(items);

		List<TnUserTermAgree> tnUserTermAgreeList = new ArrayList<TnUserTermAgree>();

		boolean insertFlag = false;

		for( int i = 0; i < tnTermInfo.size();  i++ ) {
			int termId = tnTermInfo.get(i).getTermId();

			String agreeYn = tnUserTermAgreeMapper.checkUserAgreeTerm(termId,userId);

			if ("N".equals(agreeYn) || agreeYn == null) {

				TnUserTermAgree tmp = new TnUserTermAgree();

				tmp.setUserId(userId);
				tmp.setTermId(termId);
				tmp.setAgreeYn("Y");
				tnUserTermAgreeList.add(tmp);
				insertFlag =true;
			}
		}

		if(insertFlag)
			tnUserTermAgreeMapper.createUserTermAgreeYnMulti(tnUserTermAgreeList);

		return ApiResponse.makeResponse();
	}
```
