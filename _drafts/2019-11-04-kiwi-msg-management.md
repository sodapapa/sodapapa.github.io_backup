---
layout: post
title: template
---
KIWI Frame Work msg Code 개선

### 상황 및 개발 방향
시스템 운영 초기 한글 메세지 500개, 영문 500개를 등록했다.  
추후 한글에 200개의 코드가 추가 되었다고 할때 영문에도 동일하게 msg를 추가하고자 하는데  
어떤 코드에 어떤 값이 추가 되었는지 엑셀 문서만을 다운로드 해서는 알수가 없다.
따라서 기준 언어를 뿌려주고 선택한 외국어를 보여주려고 한다.


### 내용
1. 특정 언어의 새로운 메세지 코드를 추가할 떄. 다른 3개의 키는 동일하고 FG_LANG 만 변경하여 Row를 Insert한다.
2. 특정 언어의 msg Code를 다운로드할 때, 기준이 되는 언어와 비교하여 없는 Row는 기준언어로 표시한다.


```
msg 테이블 구조.
CREATE TABLE `tm_msg` (
  `CD_SYS` varchar(4) NOT NULL,
  `MSG_CD` varchar(4) NOT NULL,
  `MSG_NO` varchar(6) NOT NULL,
  `FG_LANG` varchar(2) NOT NULL,
  `MSG_NM` varchar(255) NOT NULL,
  `MSG_DESC` varchar(255) DEFAULT NULL,
  `REG_ID` varchar(10) DEFAULT NULL,
  `REG_DATE` date DEFAULT NULL,
  `MOD_ID` varchar(10) DEFAULT NULL,
  `MOD_DATE` date DEFAULT NULL,
  PRIMARY KEY (`CD_SYS`,`MSG_CD`,`MSG_NO`,`FG_LANG`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
```


내용 2번을 해결하기 위하여 작성중인 코드,  
겹치는 코드를 어떻게 제거 해야할지 모르겠다.
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
    ORDER BY cd_msg, no_msg ) tm1 -- 기준언어
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
    AND
  ORDER BY cd_msg, no_msg) tm2 -> 선택언어
)a  ORDER BY no_msg
```
