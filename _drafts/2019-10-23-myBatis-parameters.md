---
layout: post
title: myBatis parameters #{} vs ${}  번역
---
https://mybatis.org/mybatis-3/sqlmap-xml.html#Parameters


String Substitution
By default, using the #{} syntax will cause MyBatis to generate PreparedStatement properties and set the values safely against the PreparedStatement parameters (e.g. ?). While this is safer, faster and almost always preferred, sometimes you just want to directly inject an unmodified string into the SQL Statement. For example, for ORDER BY, you might use something like this:

ORDER BY ${columnName}
Here MyBatis won't modify or escape the string.

String Substitution can be very useful when the metadata(i.e. table name or column name) in the sql statement is dynamic, for example, if you want to select from a table by any one of its columns, instead of writing code like:

@Select("select * from user where id = #{id}")
User findById(@Param("id") long id);

@Select("select * from user where name = #{name}")
User findByName(@Param("name") String name);

@Select("select * from user where email = #{email}")
User findByEmail(@Param("email") String email);

// and more "findByXxx" method
you can just write:
@Select("select * from user where ${column} = #{value}")
User findByColumn(@Param("column") String column, @Param("value") String value);
in which the ${column} will be substituted directly and the #{value} will be "prepared". Thus you can just do the same work by:
User userOfId1 = userMapper.findByColumn("id", 1L);
User userOfNameKid = userMapper.findByColumn("name", "kid");
User userOfEmail = userMapper.findByColumn("email", "noone@nowhere.com");
This idea can be applied to substitute the table name as well.

NOTE It's not safe to accept input from a user and supply it to a statement unmodified in this way. This leads to potential SQL Injection attacks and therefore you should either disallow user input in these fields, or always perform your own escapes and checks.
