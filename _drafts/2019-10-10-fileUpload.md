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
