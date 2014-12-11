---
layout: post
title:  "A \"printf\" in \"printf\""
date:   2013-10-27 21:30
categories: algorithm
---
#### In the event of a "printf" in a "printf", what will the terminal print out?

{% highlight c %}
/*
Author: luckyshq
Date:2013-10-27
*/

#include<stdio.h>

int main()
{
    printf("%d", printf("%d", 1234));
    return 0;
}
{% endhighlight %}

#### From:[http://www.cplusplus.com/reference/cstdio/printf/](http://www.cplusplus.com/reference/cstdio/printf/)


#### We can see:

function

---

# **printf**

int printf ( const char * format, ... );


Print formatted data to stdout

Writes the C string pointed byformat to the standard output (stdout). Ifformat includesformat specifiers (subsequences beginning with %), the additional arguments followingformat are formatted and inserted in the resulting string replacing their respective specifiers.

---

## **Return Value**

On success, the total number of characters written is returned.

If a writing error occurs, the error indicator (ferror) is set and a negative number is returned.


If a multibyte character encoding error occurs while writing wide characters, errno is set to EILSEQ and a negative number is returned.

---

### So, the first printf will print the total number of characters(of 1234) ----- 4
