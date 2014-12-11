---
layout: post
title:  "How to Deal with the \"TAB\" in Emacs"
date:    2013-11-05 21:51
categories: editor
---
As we all know, Emacs is a powerful editor.

(actually, it is far more than just a editor. = =)

But the TAB in Emacs is confusing.

In normal document edit mode, TAB equals 8 spaces. Just like this:


![](http://m1.img.srcdd.com/farm5/d/2013/1105/21/AF981B4856D76BDD95366F6A12D4DC7A_B500_900_500_129.png)


If there is some words in the upper line, TAB will let you stop at the same column of the second word of upper line. Just like this:

![](http://m3.img.srcdd.com/farm5/d/2013/1105/21/2BFE8CB654EEBAAA5FE063747156E860_B500_900_500_124.png)

And if you continue tapping TAB, it will take you to the column of the next word of upper line.(you will stop at the same column of "i" in the example above.)



BUT!

In C mode, TAB is terrible. It only equals 2 spaces. Where is our friendly 4-space-TAB?

And the code in emacs' C mode will be:

![](http://m2.img.srcdd.com/farm4/d/2013/1105/21/9B17D1AEFF393333699BDAE4E33B82A9_B500_900_500_243.png)



Maybe it looked not so bad, but most of the coders can not get use to it.

We want our 4-space-TAB back.

Fortunately, it's easy to change the TAB settingã

If you want to change the TAB in C mode:

>* C-x C-f to .emacs
>* input (setq c-basic-offset 4)
>* C-x C-s to save it
>* reopen your emacs. and you will find 4-space-TAB in C mode

![](http://m1.img.srcdd.com/farm4/d/2013/1105/21/0F5EDC1E081EA3163D90A7BD3BAD0EC2_B500_900_500_290.png)

By the way, you can use any number to change 4 for you own needs.

And now, I believe that you can also handling TAB in other mode.
