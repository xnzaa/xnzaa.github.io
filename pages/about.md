---
layout: page
title: About
comments: true
menu: 关于
permalink: /about/
---
## About me

* 工作：手机贴膜
* 口号：Linux万岁
* 状态：研究生遇见很多大神，心情很Down，要加油，拒绝坐井观天!
* 爱好：智能数码，游戏，动漫
* 疑问：什么时候做个自己的产品出来
* 短期目标：不愧光阴地完成研究生学业

## Contact me

* GitHub：[{{ site.github_username }}](https://github.com/{{ site.github_username }})
* QQ：[{{ site.QQ }}]
* 博客：[{{ site.title }}]({{ site.url }})
* Email: [{{ site.Email }}](mailto:649981201@qq.com)

## Skill Keywords

#### Software Engineer Keywords
<div class="btn-inline">
    {% for keyword in site.skill_software_keywords %}
    <button class="btn btn-outline" type="button">{{ keyword }}</button>
    {% endfor %}
</div>

#### Mobile Developer Keywords
<div class="btn-inline">
    {% for keyword in site.skill_mobile_app_keywords %}
    <button class="btn btn-outline" type="button">{{ keyword }}</button>
    {% endfor %}
</div>

#### Windows Developer Keywords
<div class="btn-inline">
    {% for keyword in site.skill_windows_keywords %}
    <button class="btn btn-outline" type="button">{{ keyword }}</button>
    {% endfor %}
</div>
