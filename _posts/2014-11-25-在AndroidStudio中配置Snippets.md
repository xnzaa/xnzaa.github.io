---
layout: post
title:  在AndroidStudio中配置Snippets
date:   2014-11-25 10:32:15
categories: android
---

## 前言

(其实这个标题写错了,**Snippet**在Android Studio里面叫**Live Templates**,为了让大家明白是个什么东西,我就还是用**Snippet**这个名字=,=)

用Android Studio(下面简称"AS")开发了这么久了,添加了各式各样提高开发效率的插件,不过就是没找到功能跟Snippet类似的插件,这点让我十分郁闷.

今天在逛AS的Settings时无意间发现一个叫**Live Templates**的东西.仔细一看,原来AS默认就自带了类似与Snippet的功能,不需要安装其他的插件>.<

接下来就讲讲怎么使用和配置AS里的**Live Templates**.

## 配置界面

![](http://m3.img.srcdd.com/farm4/d/2014/1125/10/62DE2ECF1A9D05654AB959157B6B28F6_B500_900_500_470.png)

如上便是配置界面,这里由于用`Tab`会与Emacs的冲突,所以我将默认展开按键改为了`Space`.

AS里面的**Live Templates**提供了很强大的管理功能,不仅仅对每种类型的模板分类管理,还能通过`Applicable in`处来设置各个模板的作用域.

AS同时提供变量类型的自定义.在`Edit variables`按钮界面里面,还能设置每个变量名所对应的类型.例如:这里的`$VAR$`默认的Expression是`variableOfType("java.lang.Object")`等.

![](http://m1.img.srcdd.com/farm5/d/2014/1125/10/8E31A9FE33C5CFBA10F7964D6AC3AE45_B500_900_500_266.png)

## 使用

**Live Templates**的使用很简单,具体有两种使用方法.

1. 使用`Ctrl + j`插入模板. (`Ctrl + j`是默认快捷键,你也可以进Keymap改成自己想要的)
2. 直接键入对应的Abbreviation,然后按设置好的**Expand with**键.
