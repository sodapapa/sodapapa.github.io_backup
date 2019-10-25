---
layout: post
title: java send mail
---
1. pom.xml에 dependency 추가
```
<dependency>
  <groupId>javax.mail</groupId>
  <artifactId>mail</artifactId>
  <version>1.4.7</version>
</dependency>
```
maven project가 아니라면 javax.mail 라이브러리를 직접 다운받아 lib 폴더에 넣어주세요.

2. Java 소스 작성

Controller에서 /mailSender라고 작성하고 Url로 호출하는 식으로 테스트하겠습니다. mail 소스를 작성합니다.

워낙 메일 보내기 예제들은 이미 많이 나와있기 때문에 간단한 주석으로 설명을 대신하고 넘어가겠습니다.

또한, 소스를 보면 알겠지만 패스워드를 입력해야 하기 때문에
보통 사내에서 사용할때는 관리자가 메일 발신 전용으로 계정을 생성하여 사용하기도 합니다.
```
/** 자바 메일 발송
 * @throws MessagingException
 * @throws AddressException **/
 package com.ljsnc.api.util;

 import java.util.Date;
 import java.util.Properties;
 import java.util.StringTokenizer;

 import javax.mail.Authenticator;
 import javax.mail.Message;
 import javax.mail.PasswordAuthentication;
 import javax.mail.Session;
 import javax.mail.Transport;
 import javax.mail.internet.AddressException;
 import javax.mail.internet.InternetAddress;
 import javax.mail.internet.MimeMessage;

 import org.slf4j.Logger;
 import org.slf4j.LoggerFactory;


 public class MailUtil {

 	private static final Logger logger = LoggerFactory.getLogger(MailUtil.class);

 	public static String sendEmail(String toMail,String subject, String content)
 			throws Exception {

 			final String send_mail = "ljsnc.hdh";
 			final String send_pw = "*********";

 			String result = "";
 			try{
 				Properties props = new Properties();
 		        props.setProperty("mail.transport.protocol", "smtp");
 		        props.setProperty("mail.host", "smtp.gmail.com");
 		        props.put("mail.smtp.auth", "true");
 		        props.put("mail.smtp.port", "465");
 		        props.put("mail.smtp.ssl.enable","true");
 		        props.put("mail.smtp.debug", "true");
 		        props.put("mail.smtp.auth", "true");
 		        props.put("mail.smtp.socketFactory.port", "465");
 		        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
 		        props.put("mail.smtp.socketFactory.fallback", "false");

 		        Authenticator auth = new Authenticator(){

            // 로그인 계정 정보
   					protected PasswordAuthentication getPasswordAuthentication() {
   						return new PasswordAuthentication(send_mail, send_pw);
 		            }
 		        };

 		        Session session = Session.getDefaultInstance(props,auth);

 		        MimeMessage message = new MimeMessage(session);
 		        message.setSender(new InternetAddress(send_mail));

 		        message.setRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
 		        message.setSubject(subject,"UTF-8"); //charset을 설정해주지 않으면 깨져서 표시됨
 		        message.setText(content,"UTF-8");
 		        message.setHeader("X-Mailer", "PSERANG");
 		        message.setHeader("Content-type", "text/html; charset=UTF-8");
 		        message.setSentDate(new Date());

 		        Transport.send(message);
 		        result = "S";
 			}catch(Exception e){
 				logger.debug(e.getMessage());
 				result = "F";
 			}

 			logger.debug(result);
 			logger.debug(result);
 			logger.debug(result);
 			logger.debug(result);
 			return result;
 		}

 /*		public static InternetAddress[] makerecipients(String addrs) throws AddressException{
 			 StringTokenizer toker;
 			 String delim = "";   //구분자
 			 InternetAddress[] addr = null;

 			 if(addrs != null){   //참조 주소가 있을때
 				 if(addrs.indexOf(",") != - 1){   // 참조메일을 , 로 구분했으면...
 					 delim = ",";
 				 }else if(addrs.indexOf(";") != -1){  // 참조메일을 ; 로 구분했으면...
 					 delim = ";";
 				 }

 				 toker = new StringTokenizer(addrs ,delim);    // ,나 ;로  이메일주소 구분하여 토크나이져로 분리
 				 int count  = toker.countTokens();      // 참조 이메일 카운트
 				 addr = new InternetAddress[count];
 				 int i = 0;

 				 while(toker.hasMoreTokens()){
 				 	addr[i++] = new InternetAddress(toker.nextToken().trim());
 				 } //while
 			 }
 			 return addr;
 		}*/
 }
```
