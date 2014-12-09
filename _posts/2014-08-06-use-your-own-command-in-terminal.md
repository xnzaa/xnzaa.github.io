---
layout: post
title:  "Use your own command in terminal"
date:    2014-08-06 11:50
categories: system
---
Maybe you want to start a software by only a few words just like **"tb"** to start **thunderbird**.
Maybe you want to **"cd ../../.."** easier.
Maybe you want to short "clear" to **"cr"**.

After reading this share, you can edit whatever command you want in Ubuntu.

1. find **~/.bashrc**
2. **sudo** edit it, add **source ~/.myFunc** in the last line.(you can change ~/.myFunc to whatever name & path you want)
3. create file **~/.myFunc**.
4. edit file **~/.myFunc** :

{% highlight bash %}
function 3..() { cd ../../..; }

function cr() { clear; }

function tb() { /usr/bin/thunderbird; }

function c() { cd $1; }
{% endhighlight %}


you can only type **"3.."** to **"cd .."** three times, use **cr** to clear your teminal, use **tb** to launch thunderbird, use **c** to replace **cd**

My personal command config files are [there](https://github.com/luckyshq/self-shell-funcs).
