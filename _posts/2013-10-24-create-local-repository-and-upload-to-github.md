---
layout: post
title:  "Create Repository & Upload to GitHub"
date:   2013-10-24 10:55
categories: network
---
#### It is necessary for every code writer to manage their code, or the code will be a mass.

#### And today, I'd like to introduce the famous code management tools --- **Git**, and a website created by Linus --- **Github**, which can help you easily put your code in order.

#### At the very beginning, you should have a account of GitHub. Just following the guide of http://github.com   and you can get that. Then a git bash has to be installed at your local system.

#### Now we start creating Local Repository and uploading it to your GitHub.

### First of all, we need a Repository to store our code. Click the New Repository on your right:


![](http://m3.img.srcdd.com/farm4/d/2013/1024/10/F6E32A2CACB222DF837459A9BABAC6EE_B500_900_360_57.PNG)


### After that, edit your Repository's properties:

>* your Repository Name
>* your Repository's Description
>* Public/Private(You need to pay for your Repository per month if you choose Private)

and so on.

![](http://m2.img.srcdd.com/farm4/d/2013/1024/10/65484EE111E0DEDBE4B5AF67104ECE2E_B500_900_500_300.PNG)

### Click Create repository, and GitHub will teach you how to create your local Repository and upload it:

![](http://m1.img.srcdd.com/farm5/d/2013/1024/10/EE9D5E9BA5F75F945E2909F218489D6E_B500_900_500_331.PNG)

```
open your konsole -> "cd" to the place where you need to be created as a local Repository -> "git init" -> "git add" your files -> "git commit" ->"git remote add origin http://github.com/xxxxxx/xxxxxx.git" add your GitHub Repository's URL -> "git push -u origin master".
```


### Now your code Repository has been uploaded to your GItHub.
