---
layout: post
title: cxf multipart file upload
---
cxf multipart file upload 예제.

body.getAttachment("authToken").getDataHandler().getInputStream().toString();
body.getAttachment("biTitle").getDataHandler().getInputStream().toString();

이 값들을 계속해서 메모리 주소값으로 불러오는 문제가 발생했다.

결론은 toString() 메서드의 부정확? 불완전함 때문이었다.
그래서 박차장님의 조언으로

```
int avail = att.getDataHandler().getInputStream().available();
byte[] buffer = new byte[avail];

att.getDataHandler().getInputStream().read(buffer, 0, avail);
String getHanderValue = new String(buffer);
```

이런 코드를 짯다. for 문을 돌면서 body안에 Attachment들을 전 불러 왔다.

리팩토링하기 전의 코드
모든 Attachment를 상수 값으로 불러와서 문제였다.

```
/*
		try {
			String userId ="";
			String billboardId ="";
			String biTitle ="";
			String biContents ="";
			String rBiId ="";
			String pwdValue ="";
			String galleryYn ="";
			String galleryNm ="";
			String galleryData ="";
			String authToken ="";


			if(body.getAttachment("authToken") != null) {
				Attachment att =  body.getAttachment("authToken");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				authToken = new String(buffer);
			}

			if(body.getAttachment("userId") != null) {

//				userId = body.getAttachment("userId").getDataHandler().getInputStream().toString();
				Attachment att =  body.getAttachment("userId");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				userId = new String(buffer);
			}else {

				throw new ManagedException(ManagedExceptionCode.InvalidUser, CommonConstants.DEFAULT_FG_LANG);
			}

			if(body.getAttachment("billboardId") != null) {
//				billboardId	= body.getAttachment("billboardId").getDataHandler().getInputStream().toString();
				Attachment att =  body.getAttachment("billboardId");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				billboardId = new String(buffer);
			}else {

				throw new ManagedException(ManagedExceptionCode.NotExistData, CommonConstants.DEFAULT_FG_LANG);
			}

			if(body.getAttachment("biTitle") != null) {
//				biTitle = body.getAttachment("biTitle").getDataHandler().getInputStream().toString();

				Attachment att =  body.getAttachment("biTitle");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				biTitle = new String(buffer);
			}else {

				biTitle = "제목없음";
			}

			if(body.getAttachment("biContents") != null) {

//				biContents 	= body.getAttachment("biContents").getDataHandler().getInputStream().toString();
				Attachment att =  body.getAttachment("biContents");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				biContents = new String(buffer);
			}else {

				biContents = "내용없음";
			}

			if(body.getAttachment("rBiId") != null) {

//				rBiId	= body.getAttachment("rBiId").getDataHandler().getInputStream().toString();
				Attachment att =  body.getAttachment("rBiId");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				rBiId = new String(buffer);
			}else {

				rBiId = "0";
			}

			if(body.getAttachment("pwdValue") != null) {

//				pwdValue 	= body.getAttachment("pwdValue").getDataHandler().getInputStream().toString();
				Attachment att =  body.getAttachment("pwdValue");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				pwdValue = new String(buffer);
			}else {

				pwdValue = "";
			}

			if(body.getAttachment("galleryYn") != null) {
//				galleryYn 	= body.getAttachment("galleryYn").getDataHandler().getInputStream().toString();

				Attachment att =  body.getAttachment("galleryYn");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				galleryYn = new String(buffer);
			}else {
				galleryYn = "N";
			}

			if(body.getAttachment("galleryNm") != null) {
//				galleryNm 	= body.getAttachment("galleryNm").getDataHandler().getInputStream().toString();
				Attachment att =  body.getAttachment("galleryNm");
				int avail = att.getDataHandler().getInputStream().available();

				byte[] buffer = new byte[avail];

				att.getDataHandler().getInputStream().read(buffer, 0, avail);

				galleryNm = new String(buffer);
			}else {

				galleryNm = "temp.jsp";
			}

			logger.info(" userId : {} , authToken : {} , billboardId : {} , biTitle : {} , biContents : {} , rBiId  : {} , pwdValue: {}  , galleryYn : {} , galleryNm : {}, galleryData : {} " ,
							userId ,authToken, billboardId, biTitle, biContents, rBiId , pwdValue, galleryYn
							, galleryNm, body.getAttachment("galleryData"));

			logger.info("fileName {} : " , body.getAttachment("galleryData").getDataHandler());

			TnBillboardInfo tnBillboardInfo =new TnBillboardInfo();

			tnBillboardInfo.setBillboardId(Integer.parseInt(billboardId));
			tnBillboardInfo.setBiTitle(biTitle);
			tnBillboardInfo.setBiContents(biContents);
			tnBillboardInfo.setrBiId(Integer.parseInt(rBiId));
			tnBillboardInfo.setPwdValue(pwdValue);
			tnBillboardInfo.setModId(userId);
			tnBillboardInfo.setRegId(userId);
			tnBillboardInfo.setDeleteYn("N");

			tnBillboardInfoMapper.createBillboardInfo(tnBillboardInfo);

			int biId = tnBillboardInfo.getBiId();
			logger.debug("biId ::: " + biId);

  			if( galleryYn.equals("Y") && body.getAttachment("galleryData") != null) {

  				TnBillboardGallery tnBillboardGallery = new TnBillboardGallery();
				try {

					Calendar cal = Calendar.getInstance();
					SimpleDateFormat fdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String strCal = fdf.format(cal.getTime());

					BufferedImage bufImg0 = null;
					InputStream is =body.getAttachment("galleryData").getDataHandler().getInputStream();

//					String mimeType = URLConnection.guessContentTypeFromStream(is);

//					System.out.println("mimeType :: " + mimeType);
//					String extsion  = mimeType.split("/")[1];
					bufImg0 = ImageIO.read(is);

					String savePath = CommonConstants.IMG_UPLOAD_PATH + "/gallery/" + biId ;
					String savePathDbParam = CommonConstants.IMG_UPLOAD_PATH_DB_PARAM + "/gallery/" + biId ;
					String fileName = biId + "_" + strCal + ".jpg" ;// +extsion;
					String fullSavePath = savePath + "/"+fileName;

					File file = new File(fullSavePath);
					if(!file.exists()){
			            file.mkdirs();
			        }

					ImageIO.write(bufImg0, "jpg", file);

					tnBillboardGallery.setBiId(biId);
					tnBillboardGallery.setDeleteYn("N");
					tnBillboardGallery.setFileFormat("jpg");
					tnBillboardGallery.setFileName(fileName);
					tnBillboardGallery.setFilePath(savePathDbParam);
					tnBillboardGallery.setRegId(userId);
					tnBillboardGallery.setModId(userId);
					tnBillboardGallery.setRegType("U");
					tnBillboardGallery.setModType("U");

				} catch (Exception e) {
					e.printStackTrace();
					throw new ManagedException(ManagedExceptionCode.ServerError, CommonConstants.DEFAULT_FG_LANG);
				}

				tnBillboardGalleryMapper.createBillboardGallery(tnBillboardGallery);
			}


			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("biId", biId);

			return ApiResponse.makeResponse(resultMap);



		} catch (IOException e) {
			e.printStackTrace();
			throw new  ManagedException(ManagedExceptionCode.ServerError, CommonConstants.DEFAULT_FG_LANG);
		}
*/
	}
```


리팩토링한 소스 getAllAttachments 메서드를 이용하여 클라이언트에서 올라온 multipart안에 값들을 리스트로 받았다.
거기에 있는 String 값들꺼 내기위하여 DataHandler안의 Name 값을 불러왔다.

여기서 주의해야 했던 점이 file로 업로드한 키가 실제파일명이었다는 것이다.

업로드 할때 마다 달라지는 파일명을 대체하기 위하여 for 문앞에서

상수로 파일이 담긴 Attachment에 접근해야했다.

그래서 이 파일명을 제외한 attachment들의 키와 값들을 Map<String,String>에 담고

이 map을 이용하여 VO에 값을 채워 넣었다.

추가적으로 수정해야할 것은 아직 null 값을 체크하지 않아서 null 이나 빈값이 들어 올 경우 쿼리에서 에러가 발생할 것이라는 것이다.

````
public Map<String, Object> setBilboardWrite(MultipartBody body) {

		try {
      HashMap<String,String> paramMap = new HashMap<String,String>();
      String galleryDataNm = "";

      if(body.getAttachment("galleryData") != null ){

        Attachment attGalleryData = body.getAttachment("galleryData");
        galleryDataNm = attGalleryData.getDataHandler().getName();
      }

			for(Attachment att : body.getAllAttachments())	{

				String getHandlerNm = att.getDataHandler().getName();

				if (!att.getDataHandler().getName().equals(galleryDataNm))){
					int avail = att.getDataHandler().getInputStream().available();
					byte[] buffer = new byte[avail];

					att.getDataHandler().getInputStream().read(buffer, 0, avail);
					String getHanderValue = new String(buffer);
					paramMap.put(getHandlerNm, getHanderValue);
				}
			}

			TnBillboardInfo tnBillboardInfo =new TnBillboardInfo();
			tnBillboardInfo.setBillboardId(Integer.parseInt(paramMap.get("billboardId")));
			tnBillboardInfo.setBiTitle(paramMap.get("biTitle"));
			tnBillboardInfo.setBiContents(paramMap.get("biContents"));
			tnBillboardInfo.setrBiId(Integer.parseInt(paramMap.get("rBiId")));
			tnBillboardInfo.setPwdValue(paramMap.get("pwdValue"));
			tnBillboardInfo.setModId(paramMap.get("userId"));
			tnBillboardInfo.setRegId(paramMap.get("userId"));
			tnBillboardInfo.setDeleteYn("N");

			tnBillboardInfoMapper.createBillboardInfo(tnBillboardInfo);

			int biId = tnBillboardInfo.getBiId();

			if( paramMap.get("galleryYn").equals("Y") && attGalleryData != null) {

  				TnBillboardGallery tnBillboardGallery = new TnBillboardGallery();
				try {

					Calendar cal = Calendar.getInstance();
					SimpleDateFormat fdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String strCal = fdf.format(cal.getTime());

					BufferedImage bufImg0 = null;
					InputStream is = attGalleryData.getDataHandler().getInputStream();

					bufImg0 = ImageIO.read(is);

					String savePath = CommonConstants.IMG_UPLOAD_PATH + "/gallery/" + biId ;
					String savePathDbParam = CommonConstants.IMG_UPLOAD_PATH_DB_PARAM + "/gallery/" + biId ;
					String fileName = biId + "_" + strCal + ".jpg" ; // +extsion;
					String fullSavePath = savePath + "/"+fileName;

					File file = new File(fullSavePath);
					if(!file.exists()){
			         file.mkdirs();
			    }

					ImageIO.write(bufImg0, "jpg", file);

					tnBillboardGallery.setBiId(biId);
					tnBillboardGallery.setDeleteYn("N");
					tnBillboardGallery.setFileFormat("jpg");
					tnBillboardGallery.setFileName(fileName);
					tnBillboardGallery.setFilePath(savePathDbParam);
					tnBillboardGallery.setRegId(paramMap.get("userId"));
					tnBillboardGallery.setModId(paramMap.get("userId"));
					tnBillboardGallery.setRegType("U");
					tnBillboardGallery.setModType("U");

				} catch (Exception e) {
					e.printStackTrace();
					throw new ManagedException(ManagedExceptionCode.ServerError, CommonConstants.DEFAULT_FG_LANG);
				}

				tnBillboardGalleryMapper.createBillboardGallery(tnBillboardGallery);
			}
			HashMap<String, Object> resultMap = new HashMap<String, Object>();

			resultMap.put("biId", biId);
			return ApiResponse.makeResponse(resultMap);

		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return ApiResponse.makeResponse();
  `````

추가로 현재는 chBoard.java 파일에서 MultipartBody를 파라미터 하나로 통째로 받아와
서비스 단에서 Attachment 별로 쪼개서 사용하고 있는데

 MOD Project를 확인해본 결과 아예 컨트롤러 단에서 @multipart를 이용하여 파일과 스트링 형식의 파라미터를 구분하여 받고 있다.

 현재의 소스도 이와 같은 형태로 수정하는 게 좋을 것 같다.
