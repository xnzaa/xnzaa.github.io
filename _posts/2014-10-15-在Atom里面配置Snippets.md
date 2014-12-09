---
layout: post
title:  "在Atom里面配置Snippets"
date:    2014-10-15 20:22
categories: editor
---

想当初邮件申请试用的时候**Atom**没有理我，感觉好失落，同时也就把它抛到脑后了。
现在**Atom**公测版也推出了一段时间了，最近心血来潮就想到把它下下来玩一下。

第一印象是这玩意跟**Sublime**差不多的风格，跟**Sublime**不同的是**Atom**这玩意是用**Node.js**做的一个本地应用，
像**Android Studio**一样支持即时渲染，**Web**前端的猿们又能**get**一大利器了,而且由于Web特性,一切设置的修改都是**不需要重启编辑器**的。

比较蛋疼的一点是不能支持自动换行TAT，**markdown**还好，其他的要输入一大段字符的话，
它就直接全部挤在一行里了。不过相信由于**Atom**的开源特性，早就有解决这个问题的插件，只不过是我还没有去找而已。(这个问题在官方最新的版本里面已经得到了解决.果然效率)

---

我切切切切～

好，不多说废话，开始进入主题。

### **Github**最初在宣传**Atom**的时候称这是一款集成了**Sublime**和**Emacs**优秀特性的编辑器。

### 那自然少不了优秀的[**Snippets**](https://github.com/atom/snippets).

不知道Snippets是什么的可以点[这里](http://en.wikipedia.org/wiki/Snippet_(programming))喔。

* 在**Atom**中菜单栏的**Edit** -> **Preferences** -> 搜索框输入**Snippets** 就能找到　**Snippets**包了。

![](http://m3.img.srcdd.com/farm5/d/2014/1015/16/7A3B963AAF23A8A83DF6D4B7C71F8EB9_B500_900_500_309.png)

你会发现为什么里面的**Snippets**为什么这么少，而且没有根据语言来分类？

经过长时间的翻文档工作(真是找了好久TAT，主要是思维被YSnippets给圈起来了)，后来发现
其实**Atom**这里是将**Snippets**全部整合到它的各个语言包里面去了。

例如**language-c**里面就有专门一个文件夹放相应的**Snippets**。

![](http://m3.img.srcdd.com/farm4/d/2014/1015/16/D12899D80F405E970221733E18CCD351_B500_900_195_243.png)

* 注：Linux下Atom的默认安装目录是 /usr/share/atom 而　language包文件都放在　/usr/share/atom/resources/app/node_modules 下。　
* 所以修改Snippets文件需要root权限，不过Atom有个bug，我用sudo 打开Atom好像没有获取到root权限，还是不能改写Snippets。后来还是用emacs改的。＝，＝
(已查清原因：一个Atom大窗口只对应一种权限，如果用sudo打开的话会默认在之前的Atom里面创建小窗口，而这个小窗口是没有获得root权限的，bug已在github里上报)

如果你想针对语言配置**Snippets**的话就可以直接在每个**language**的包里修改**Snippets**文件。

### **Atom**的**Snippets**支持**cson**和**json**两种格式，这里分别给出一个例子：

#### .cson
{% highlight coffeescript %}
'.source.js':
  'if, else if, else':
    'prefix': 'ieie'
    'body': """
      if (${1:true}) {
        $2
      } else if (${3:false}) {
        $4
      } else {
        $5
      }
    """
{% endhighlight %}

`这里补充一点,之前我好长时间用CSON都没有配成功,后来发现是'.source.js'那一块的问题.
之前以为那里是引用了什么js文件,后来才发现那个是对应Snippets的作用域.
所以要在.java文件里生效就得改为'.source.java',以此类推.`
`注:.source.后面跟的是跟atom语言包相关的名称,例如markdown文件是.source.gfm. (妈蛋,这地方坑了我好久,又没有一个统一的文档.=,=坑爹)`

#### .json
{% highlight json %}
    "jekyll yaml": {
      "prefix": "ya",
      "body": "---\nlayout: post\ntitle:  $1\ndate:   $2 $3\ncategories: $4\n---\n$5"
    },
{% endhighlight %}

#### 里面最开始的是**Snippets**的名字，**prefix**是触发器，**body**就是模板展开之后的内容了。

#### 这样配好自己要的**Snippets**后就能开开心心的继续**Atom**探索之旅了>,<
