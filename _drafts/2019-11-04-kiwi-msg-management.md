---
layout: post
title: template
---
```
SELECT * FROM (
(SELECT
  no_msg AS no_msg,
  cd_sys AS cd_sys,
  CD_MSG AS cd_msg,
    fg_lang AS fg_lang ,
  FN_CD_NAME_LANG ('MESSAGE_TYPE', cd_msg, 'ko') AS cd_msg_cdnm,
  nm_msg AS nm_msg,
  desc_msg AS desc_msg,
  id_insert AS id_insert,
  Fn_User_Name (id_insert) AS nm_insert,
  DATE_FORMAT(dt_insert, '%Y-%m-%d') AS dt_insert

FROM
  tm_msg tm1
WHERE 1 = 1
  AND FG_LANG = 'ko'
ORDER BY cd_msg, no_msg )
  UNION ALL
(SELECT
  no_msg AS no_msg,   
  cd_sys AS cd_sys,
  CD_MSG AS cd_msg,
  fg_lang AS fg_lang,
  FN_CD_NAME_LANG ('MESSAGE_TYPE', cd_msg, 'en') AS cd_msg_cdnm,
  nm_msg AS nm_msg,
  desc_msg AS desc_msg,
  id_insert AS id_insert,
  Fn_User_Name (id_insert) AS nm_insert,
  DATE_FORMAT(dt_insert, '%Y-%m-%d') AS dt_insert

FROM
  tm_msg tm1
WHERE 1 = 1
  AND FG_LANG = 'en'

ORDER BY cd_msg, no_msg) )a  ORDER BY no_msg
  ```
