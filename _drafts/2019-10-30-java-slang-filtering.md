---
layout: post
title: 자바 게시판 욕설, 금지어 필터링
---
대양 게시판 작업중에 욕설 및 금지어 필터링을 해야했다.

아래의 소스를 긁어 다가 필터링을 했는데 static Util로 분리하여 작업했다.

그런데 tn_bad_word 에서 리스트를 가지고 올 수가 없었다.

List<String>의 타입으로 리턴을 받고자 했는데 static 메서드에서 일반 메서드를 호출 할 수가 없다는 것이었다.  

우선 급한데로 Util를 호출 할떄 마다 금지어 목록 테이블을 조회하여 조회한 리스트값을 가지고 하나의 스트링으로 변환했다.

금지어 데이터는 실시간으로 반영해야 하는 데이터도 아닌데 어렇게 매번 조회하는 것이 옳지 않은 것 같아 개선이 필요하다.

서버를 기동할 때 cache나 session에 담아두고 그 값을 가져다가 쓰는 것이 옳은 것 같다.
 ```
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 금지어 필터링하기
 *
 * @author   Sehwan Noh <sehnoh at java2go.net>
 * @version  1.0 - 2006. 08. 22
 * @since    JDK 1.4
 */
public class RegExTest06 {

    public static String filterText(String sText) {
        Pattern p = Pattern.compile("fuck|shit|개새끼", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(sText);

        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            //System.out.println(m.group());
            m.appendReplacement(sb, maskWord(m.group()));
        }
        m.appendTail(sb);

        //System.out.println(sb.toString());
        return sb.toString();
    }

    public static String maskWord(String word) {
        StringBuffer buff = new StringBuffer();
        char[] ch = word.toCharArray();
        for (int i = 0; i < ch.length; i++) {
            if (i < 1) {
                buff.append(ch[i]);
            } else {
                buff.append("*");
            }
        }
        return buff.toString();
    }

    public static void main(String[] args) {
        String sText = "Shit! Read the fucking manual. 개새끼야.";        
        System.out.println(filterText(sText));
    }
}
```
소스 출처: https://finewoo.tistory.com/archive/201009 [개발자 노트]

##### 여담  
일일 커밋에 관하여  
많은 사람들이 왜 일일 커밋에 집착하는 지 알것 같다.  
오늘은 유난히 무엇을 커밋하고 작성해야 할지 모르겠다.  
보여주기식 잔디밭에 집착하여 억지로라고 커밋을 하려고 하다보니.  
오늘 하루 무슨 코딩을 했는 지 어떤 로직을 생각했는 지 어떤 쿼리를 짰는지  
돌아보게 되는 것 같다.

아직은 정리된 것 없이 채워넣기 위하여 쓰는 포스팅 들이지만  
흘러가는 시간속에서 무언가 나에게 남길 수 있는 좋은 방법이 되었으면 좋겠다.


-----
내일 할일.  
금지어 리스트를 가지고 다니면서 조회하지 않을 수 있는 방법을 생각해보자.

포스트맨을 이용하여 API를 호출하는 데 한글이 깨져서 들어간다.
