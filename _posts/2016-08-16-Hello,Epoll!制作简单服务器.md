---
layout: post
title:  "Hello,Epoll!制作简单服务器"
date:    2016-08-16 20:50
categories: Network
comments: true
---

# 1 简介

这篇文章就是epoll的实战啦，借助epoll的ET非阻塞IO工作模式，我们实现了简易的并发服务器，主要完成的功能是：接收客户端数据并回发。所以本篇是“Hello,Epoll！”

下面分别是客户端、服务器代码，shell脚本压力测试，实验截图4个方面仔细看看。

# 2 客户端代码

客户端就是非常普通的TCP socket通信，先看看主要功能：

建立连接后，首先接收控制台输入，并将输入结果发送到服务器端，接收服务器端回发，并回显！

```cpp

#include "stdio.h"
#include <iostream>
#include "unistd.h"//sleep
#include "string.h"
#include "sys/socket.h"
#include <sys/types.h> 
#include <netinet/in.h>
#include <netinet/ip.h>
#include <arpa/inet.h>
#include <unistd.h>
#include "stdlib.h"
using namespace std;

void handlec(int confd)
{
    char sendbuff[1024],recbuff[1024];
    int n;
    for(;;)//据大神们说 这比while(true)的汇编代码更少，所以咱也来赶时髦！
    {
        //if (read(STDIN_FILENO, sendline, MAXLINE) == 0)
        //    break;
        cin>>sendbuff;
        if(write(confd,sendbuff,strlen(sendbuff))>0)
        {
            n=read(confd,recbuff,1024);
            write(STDOUT_FILENO, recbuff, n);
        }
        else
        {
            perror("connect lose!");
            break;
        }
    }
}

int main(int argc,char** argv)
{
    char * ser_addr="127.0.0.1";
    int port=6999;
    char buff[1024];
    int confd;
    struct sockaddr_in seraddr;
    
    confd = socket(AF_INET,SOCK_STREAM,0);
    bzero(&seraddr,sizeof seraddr);
    seraddr.sin_family=AF_INET;
    seraddr.sin_port=htons(port);
    inet_pton(AF_INET,ser_addr,&seraddr.sin_addr);
    
    if(connect(confd,(struct sockaddr * )&seraddr,sizeof (seraddr))<0)
    {
        perror("connect failed");
        return -1;
    }
    printf("connect success!\n");
    handlec(confd);
    close(confd);
    printf("exit!");
    return 0;
}

```

# 3 服务器代码

服务器端就是核心了，使用epoll来实现简易的服务器，简单到，主要功能可以用一句话说出来：

接收大量客户端的连接，针对每一个连接，接收数据，并回发！

```cpp
#include "stdio.h"
#include "string.h"
#include <sys/types.h> 
#include <netinet/in.h>
#include <netinet/ip.h>
#include <arpa/inet.h>
#include <unistd.h>
#include "stdlib.h"
#include "sys/socket.h"

//epoll
#include <sys/epoll.h> /* epoll function */
#include <fcntl.h>     /* nonblocking */
#include <sys/resource.h> /*setrlimit 进程打开最大文件数目*/
#include <errno.h>

usin namespace std;

#define MAXLINE 1024
#define MAXEPOLL 1024
#define MAXEPOLLEVENT 1024

int setnoblocking(int fd)
{
    if(fcntl(fd,F_SETFL,fcntl(fd,F_GETFL,0)|O_NONBLOCK) == -1)
    {
        return -1;
    }
    return 0;
}

int writef(int fd,char * sbuff)
{
    char sendbuff[1024];
    sprintf(sendbuff, "HTTP/1.1:\tWelcome!\nYour Message: %s\n",sbuff);
    int nwrite, data_size = strlen(sendbuff);
    int n = data_size;
    while (n > 0)
    {
        nwrite = write(fd, sendbuff + data_size - n, n);
        if (nwrite < n)
        {
            if (nwrite == -1 && errno != EAGAIN)
            {
                perror("write error");
                return -1;
            }
            return 0;
        }
        n -= nwrite;
    }
}

int readf(int confd)
{
    char recbuff[10];
    int n=0;
    while(true)
    {
        if((n=read(confd,recbuff,10))<0)
        {
            if(errno==EAGAIN)
                return 0;
            else
                return -1;
        }
        else if(n>0)
        {
            recbuff[n]=0;
            printf("receive message:%s\n",recbuff);
            if(writef(confd,recbuff)<0)
                return -1;
            if(n<10) return 0;
        }
        else if(n==0)
        {
            //perror("connect close!");
            return -1;
        }
    }
    
}

int main()
{
    int listenfd,confd,childpid;
    int port = 6999;
    char buff[1024];
    struct sockaddr_in seraddr,clientaddr;
    
    int epollfd,eventfds,n,nread,acceptcount=0;
    struct epoll_event ev;
    struct epoll_event events[MAXEPOLL];
    struct rlimit rt;
    rt.rlim_max=rt.rlim_cur=MAXEPOLL;
    if(setrlimit(RLIMIT_NOFILE,&rt)==-1)
    {
        perror("set rlimit error");
        return -1;
    }
    
    socklen_t socklen=sizeof(seraddr);
    seraddr.sin_family=AF_INET;
    seraddr.sin_addr.s_addr=htonl(INADDR_ANY);
    seraddr.sin_port=htons(port);
    
    if((listenfd=socket(AF_INET,SOCK_STREAM,0))<0)
    {
        perror("socket failed");
        return -1;
    }
    
    if(setnoblocking(listenfd)<0)
    {
        perror("set no blocking error");
    }
    
    int opt=1;
    setsockopt(listenfd,SOL_SOCKET,SO_REUSEADDR,&opt,sizeof(opt));
    
    if(bind(listenfd,(struct sockaddr *)&seraddr,sizeof(seraddr))<0)
    {
        perror("bind failed");
        return -2;
    }
    if(listen(listenfd,500)<0)//等待连接队列长度500
    {
        perror("listen failed");
        return -3;
    }
    printf("listen  ing  port is %d\n",port);
    
    epollfd=epoll_create(MAXEPOLL);
    ev.events=EPOLLIN|EPOLLET;
    ev.data.fd=listenfd;
    if(epoll_ctl(epollfd,EPOLL_CTL_ADD,listenfd,&ev)<0)
    {
        perror("epoll add failed");
        return -4;
    }

    printf("epoll startup,port %d, max connection is %d, listenqueue is %d\n", port, MAXEPOLL, 500);
    
    for(;;)//据大神们说 这比while(true)的汇编代码更少，所以咱也来赶时髦！
    {
        if((eventfds = epoll_wait(epollfd,events,MAXEPOLLEVENT,0))<0)
        {
            perror("epoll_wait error");
            continue;
        }
        for(int i=0;i<eventfds;i++)
        {
            if(events[i].data.fd==listenfd)
            {
                while((confd=accept(listenfd,(struct sockaddr *) &seraddr,&socklen))>0)
                {
                    sprintf(buff,"accept form %s:%d",inet_ntoa(clientaddr.sin_addr), clientaddr.sin_port);
                    printf("%s  ",buff);
                    acceptcount++;
                    printf("新建连接，当前连接用户数为：%d\n",acceptcount);
                    setnoblocking(confd);
                    ev.events=EPOLLIN|EPOLLET|EPOLLOUT;
                    ev.data.fd=confd;
                    epoll_ctl(epollfd,EPOLL_CTL_ADD,confd,&ev);
                }
            }
            else if(events[i].events & EPOLLIN)
            {
                if(readf(events[i].data.fd)<0)
                {
                    epoll_ctl(epollfd,EPOLL_CTL_DEL,events[n].data.fd,&ev);
                    close(events[n].data.fd);
                    acceptcount--;
                    printf("用户离线，当前连接用户数为：%d\n",acceptcount);
                }
            }
            /*else if(events[i].events & EPOLLOUT)
            {
                if(writef(events[i].data.fd)<0)
                {
                    epoll_ctl(epollfd,EPOLL_CTL_DEL,events[n].data.fd,&ev);
                    close(events[n].data.fd);
                    acceptcount--;
                    printf("用户离线，当前连接用户数为：%d\n",acceptcount);
                }
            }*/
        }
    }
    return 0;
}

```

这里并没有注册EPOLLOUT 事件，有3点说明如下：

 * 感觉发送缓冲够大了，不需要判断是否满；（主要还是懒）
 * 不太明白EPOLLOUT 会不会影响EPOLLIN，没敢注册；
 * EPOLLOUT一般是在缓冲区写满时，自己手动注册，如果状态变了，就触发事件。

# 4 测试及运行

## 4.1 测试方法

```bash
启动压力测试：
for i in {1..500};
{
    ./client &
}

结束压力测试：
for i in {1..500};
{
    kill -9 %$i
}

```

## 4.2 运行结果

下图中，一共8个客户端连接如服务器，第8个客户端发送一条数据后，主动关闭连接！

![服务器运行结果](https://github.com/xnzaa/xnzaa.github.io/raw/master/_images/Net/2016-08-16-HelloEpoll%E5%88%B6%E4%BD%9C%E7%AE%80%E5%8D%95%E6%9C%8D%E5%8A%A1%E5%99%A8/server.png)

![客户端运行结果](https://raw.githubusercontent.com/xnzaa/xnzaa.github.io/master/_images/Net/2016-08-16-HelloEpoll%E5%88%B6%E4%BD%9C%E7%AE%80%E5%8D%95%E6%9C%8D%E5%8A%A1%E5%99%A8/client.png)


# 5 结束

以前写网络服务器程序，都是每一个连接，新建一个进程，epoll通过设计特殊的数据结构，实现了单进程多个连接的并发。

以前觉得多线程设计很高端，现在更觉得，如果单线程可以解决的问题，尽量不要用多线程 ！这应该是我学到的最有用的地方吧！

# 6 参考

[ET和LT读写模式](http://www.ccvita.com/515.html)
[ET循环读写实现](http://www.cnblogs.com/zackyang/archive/2010/01/16/1648954.html)