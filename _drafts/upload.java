@RequestMapping("/update.json")
  public Map<String,Object> update(HttpServletRequest request, HttpServletResponse reponse,
      @RequestParam("upload-file") MultipartFile[] files)  throws Exception {
  Map<String, Object> paramMap = RequestUtil.fillVals(request);

  String fileUpSn = StringUtil.nvl( paramMap.get("fileUpSn"));


  if(files.length > 0) {
    Map<String, Object> imgUploadResult  =   this.uploadMultipleFiles(files ,fileUpSn);

    paramMap.put("fileUpSn", StringUtil.nvl( imgUploadResult.get("fileUpSn")));

  }

  Map<String, Object> result = ProductService.setCardUpdate(paramMap);

  return result;


  }

private Map<String, Object> uploadMultipleFiles(MultipartFile[] files, String fileUpSn) throws Exception {

  HttpHeaders headers = new HttpHeaders();

  headers.setContentType(MediaType.MULTIPART_FORM_DATA);

    MultiValueMap<String, Object> body  = new LinkedMultiValueMap<>();

    List<String> tempFileNames = new ArrayList<>();

    List<Integer> fileSnList =  new ArrayList<>();

    String tempFileName;

    FileOutputStream fo;

  for (int i = 0; i < files.length; i++) {
    MultipartFile multipartFile2  = files[i];

    tempFileName = "/tmp/" + multipartFile2.getOriginalFilename();
          tempFileNames.add(tempFileName);

          fo = new FileOutputStream(tempFileName);
          fo.write(multipartFile2.getBytes());
          fo.close();

          body.add("files", new FileSystemResource(tempFileName));
  }

    HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

    String serverUrl = "http://220.76.91.51:10041/uploadMultipleFiles";

    RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(serverUrl, requestEntity, String.class);

    JSONParser jsonParser = new JSONParser();
    JSONArray JSONArray = (JSONArray) jsonParser.parse(response.getBody().toString());

        System.out.println("++++++++++++++++++++++++++++++++++++++");
        System.out.println("Response code: " + response.getStatusCode());
        System.out.println("++++++++++++++++++++++++++++++++++++++");
        System.out.println("Response body: " + response.getBody().toString());
        System.out.println("++++++++++++++++++++++++++++++++++++++");
        System.out.println("json: " + JSONArray);


    for (String fileName : tempFileNames) {
          File f = new File(fileName);
          f.delete();
      }
    int cnt = 0;

    for (Object object : JSONArray) {
      JSONObject jsonObject = (JSONObject) object;
      String tmpFileSn = String.valueOf(jsonObject.get("fileSn"));

      System.out.println("fileSn :: " +tmpFileSn);
      fileSnList.add( (int) (long)  jsonObject.get("fileSn"));
    }


    HashMap<String, Object> imgUploadResult  =  new HashMap<>();
    imgUploadResult.put("fileSnList", "test" );

    if("".equals(fileUpSn)) {
      fileUpSn = fileSnList.get(0).toString();
    }

    // 생성된 DB row들 상위 파일 SN으로 그룹화
    Map<String, Object> result = ProductService.setCardImgGroup(fileUpSn,fileSnList);

    result.put("fileUpSn", fileUpSn);

    return result;

}


//https://www.baeldung.com/spring-rest-template-multipart-upload
