---
layout: post
title:  "Linux下Socket编程备忘"
date:    2015-01-31 16:20
categories: network
---

Foreword：人老了，什么都会忘记，这里记一些我的独门秘籍，外人千万不要偷看！！！

### What is Socket
  Socket直译‘插座’，技术翻译‘套接字’，是操作系统提供的一个TCP/IP协议网络编程接口，它运行在TCP/IP协议的应用层
与传输层之间（个人认为,仅供参考），向下访问TCP/UDP提供的API，向上为应用层提供网络数据流。
  
  具体定义还望百度，这里提供两例Linux下的TCP/UDP的demo，有需要的同学可以在这里下载。已测试，通信正常，
编译遇到问题的可以联系我。(∩_∩)

### TCP Demo
  TCP是连接的，传输可靠。适合小流量，高安全的数据传输。编程相对复杂一些。
  下面是2个TCP协议的Demo:
  
  Demo1可以处理多个连接，接收完数据后显示接收到的数据，断开连接，处理其他连接。

  [Demo1 https://github.com/xnzaa/socket_linux/tree/master/TCP/Demo1](https://github.com/xnzaa/socket_linux/tree/master/TCP/Demo1)

  Demo2循环处理一个连接，不断的接收数据，然后将接收到的数据回发。

  [Demo2 https://github.com/xnzaa/socket_linux/tree/master/TCP/Demo2](https://github.com/xnzaa/socket_linux/tree/master/TCP/Demo2)

### UDP Demo
  UDP是无连接的，传输不可靠。适合大流量的数据传输。编程相对简单一些。

  UDP 不需要建立连接，Demo中发数据抛出去就不管了，接数据就一直监听某个端口
  [Demo https://github.com/xnzaa/socket_linux/tree/master/UDP](https://github.com/xnzaa/socket_linux/tree/master/UDP)

### Remark
  由于服务器端需要一个死循环不停的监听是否有数据传来，在实际编程使用过程中常常结合多线程编程来解决
死循环的问题。