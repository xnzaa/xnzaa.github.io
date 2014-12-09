---
layout: post
title:  "Float's Trap"
date:   2013-10-27 11:58
categories: algorithm
---
#### What is the result of following C program?

{% highlight c%}
/*
From:《算法竞赛入门经典》 清华大学出版社 刘汝佳编著。
*/

#include<stdio.h>

int main()
{
    double i;
    for(i = 0; i != 10.0; i += 0.1)
        printf("%.1lf\n",i);
    return 0;
}
{% endhighlight %}

#### Will it stop when i is added to 10?

### The answer is NO!

#### A float can't describe a number accurately. So you can't use "==" and "!=" between a float and an accurate number.

#### As for the code above, you can change "i != 10.0" to "i < 10.0" for stopping your for loop.
