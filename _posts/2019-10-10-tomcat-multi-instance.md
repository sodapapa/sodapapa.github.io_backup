---
layout: post
title: Tomcat Multi Instance
---

회사 개발 서버에서 톰캣을 실행 중인 톰캣을 확인 할때

특정 경로가 반복되는 것을 확인 했다.

```
root      1503 31960  0 16:12 pts/3    00:00:00 grep tomcat
root      8582     1  0 Sep10 ?        00:00:00 /bin/sh /usr/local/server/tomcat7/bin/catalina.sh start
root     10322     1  0 Oct08 ?        00:00:00 /bin/sh /usr/local/server/tomcat7/bin/catalina.sh start
root     14380     1  0 Oct07 ?        00:00:00 /bin/sh /usr/local/server/tomcat7/bin/catalina.sh start
```

확인해 보니 하나의 톰캣을 설치해 놓고 톰캣 인스턴스만 프로젝트별 멀티 인스턴스로 구성하는 방법이라고 한다.

프로젝트  별 startup.sh , shutdown.sh 파일이 존재했는데. 항상 마지막에 기존 톰캣의 설치 경로로 이동하여 거기서 톰캣을 기동하는 구조로 되어있었다.

```
export CATALINA_BASE=/usr/local/server/[Project Dir]
# export JAVA_OPTS="-Djava.awt.headless=true -server -Xms256m -Xmx512m -XX:NewSize=128m -XX:MaxNewSize=256m -XX:PermSize=128m -XX:MaxPermSize=256m -XX:+DisableExplicitGC"
export CATALINA_OPTS="-Denv=product -Denv.servername=lysn"
cd /usr/local/server/tomcat7/bin
./startup.sh
```

shutdown 역시 동일하게 선언되어 있었다.
```
export CATALINA_BASE=/usr/local/server/TAP_API
cd /usr/local/server/tomcat7/bin
./shutdown.sh
```


톰캣의 엔진은 lib, bin를 의미하고
나머지 conf, log, temp, work, webapps 등은 톰캣의 인스턴스에 해당한다.

새로운 프로젝트를 구성하려면 기존의 엔진은 그대로 두고 인스턴스만 새로 생성하여 프로젝트를 구성한다.

물론 프로젝트 마다 톰캣을 설치하여 여러개의 톰캣을 설치하여 서버를 구동하여도 결과적으로 동일하다.

선택의 문제일뿐이라고 한다(견해).

현재 사내 개발서버의 구성이 이렇게 되었어서 스터디를 해봤다.

멀티 인스턴스로 구성할 때 신경 써야 하는 것은 conf/server.xml의 5개의 포트가 다른 포트와 겹치지 않도록

올바르게 변경하는 것이었다.
