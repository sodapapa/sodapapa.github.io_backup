---
layout: post
title: template
---


````
@Transactional
public Map<String, Object> mergePolicy(Map<String, Object> param) throws Exception {

  Map<String, Object> resultMap  = new HashMap<String, Object>();
  List<Map<String, Object>> list = mapper.getLatestPolicy(param);

  InputStream in = WebUtil.getRequest().getServletContext().getResourceAsStream("/resources/policy_info_templete.html");
  BufferedReader br = new BufferedReader(new InputStreamReader(in));

  String l = null;
  String mergedPolicy = "";

  while( (l = br.readLine()) != null ) {
    mergedPolicy += l;
  }
  logger.info(mergedPolicy);

  for(Map<String, Object> t : list) {

    switch(TermType.get((String)t.get("TERM_TYPE"))) {

    case PrivacyPolicy :
      mergedPolicy = mergedPolicy.replace("#{policy_privacy}", (String)t.get("TERM_CONTENTS"));
      break;

    case ServicePolicy :
      mergedPolicy = mergedPolicy.replace("#{policy_service}", (String)t.get("TERM_CONTENTS"));
      break;

    case ThirdPartiesAcceptPolicy :
      mergedPolicy = mergedPolicy.replace("#{policy_third_parties}", (String)t.get("TERM_CONTENTS"));
      break;
      }
  }
  String fileName = "policy_info.html";
  File mergedFile = new File(uploadPath + fileName);
  if(mergedFile.isFile()) {
    String fileNameBackup = "policy_info_" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".html";
    if(!mergedFile.renameTo(new File(uploadPath + fileNameBackup))) {
      resultMap.put("result","fail");
      return resultMap;
    }
  }

  BufferedWriter bw = new BufferedWriter(new FileWriter(mergedFile, false));
  bw.write(mergedPolicy);
  bw.close();

  resultMap.put("result","success");
  return resultMap;
}

````



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

이런 코드를 짯다. for 문을 돌면서 body


````
public Map<String, Object> setBilboardWrite(MultipartBody body) {

		try {
			String galleryDataNm = body.getAttachment("galleryData").getDataHandler().getName();
			HashMap<String,String> paramMap = new HashMap<String,String>();

			for(Attachment att : body.getAllAttachments())	{

				String getHandlerNm = att.getDataHandler().getName();

				if (!att.getDataHandler().getName().equals(galleryDataNm)){
					int avail = att.getDataHandler().getInputStream().available();
					byte[] buffer = new byte[avail];

					att.getDataHandler().getInputStream().read(buffer, 0, avail);
					String getHanderValue = new String(buffer);
					paramMap.put(getHandlerNm, getHanderValue);
				}
			}

			logger.debug("paramMap : " + paramMap.toString());

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
			logger.debug("biId ::: " + biId);

			if( paramMap.get("galleryYn").equals("Y") && body.getAttachment("galleryData") != null) {

  				TnBillboardGallery tnBillboardGallery = new TnBillboardGallery();
				try {

					Calendar cal = Calendar.getInstance();
					SimpleDateFormat fdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String strCal = fdf.format(cal.getTime());

					BufferedImage bufImg0 = null;
					InputStream is =body.getAttachment("galleryData").getDataHandler().getInputStream();

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

			//logger.info("body.toString(): {}  " , body.getAttachment("authToken").getDataHandler().get));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return ApiResponse.makeResponse();
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


			if(	pdsYn.equals("Y")) {

				try {
					HashMap<String,Object> fileInfo = FileUploadUtil.fileUpload(glryMultiBody, biId, galleryNm , "G");

					TnBillboardPds tnBillboardPds = new TnBillboardPds();
					tnBillboardPds.setBiId(biId);
					tnBillboardPds.setFilePath((String)fileInfo.get("filePath"));
					tnBillboardPds.setFileName((String)fileInfo.get("fileName"));
					tnBillboardPds.setFileFormat((String)fileInfo.get("fileFormat"));
					tnBillboardPds.setDeleteYn("N");
					tnBillboardPds.setRegType("U");
					tnBillboardPds.setRegId((userId));
					tnBillboardPds.setModType("U");
					tnBillboardPds.setModId((userId));

					tnBillboardPdsMapper.createBillboardPds(tnBillboardPds);

				} catch (Exception e) {
					e.printStackTrace();
				}
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
  `````
