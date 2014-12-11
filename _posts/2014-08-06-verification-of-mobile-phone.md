---
layout: post
title:  "Verification mobile phone No. & password"
date:    2014-08-06 11:28
categories: android
---
At an android project, I need to verify user's input phone number and password through a established rule:

1. The phone number should be a legal phone number.
2. The password should consist 6~12 numbers or letters.

I used **Regular expression matching** to ensure this verification.


{% highlight java %}
//Verification of mobile phone No.
public static boolean isPhone(String str){
        Pattern pattern;
        Matcher matcher;
        boolean flag;
        pattern = Pattern.compile("^[1][3,4,5,8][0-9]{9}$");
        matcher = pattern.matcher(str);
        flag = matcher.matches();
        return flag;
    }

//Verification of 6~12 password
public static boolean isPassword(String str){
        Pattern pattern;
        Matcher matcher;
        boolean flag;
        pattern = Pattern.compile("^[A-Za-z0-9]{6,16}$");
        matcher = pattern.matcher(str);
        flag = matcher.matches();
        return flag;
    }
{% endhighlight %}
