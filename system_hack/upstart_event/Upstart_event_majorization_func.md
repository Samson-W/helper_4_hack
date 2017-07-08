# Upstart使用小结
## 需求
在某高大上的基于Mint 15的系统关机时，关机时间过长，为了用户的快速关机睡觉，要进行优化；

## 如何着手此问题
0)、需要了解系统关机的过程；
　　Mint Linux的开关机过程都是和一个叫upstart的东东紧密相关的；此东东是什么玩意儿？且看++分解；
1)、往来有google，吃喝用baidu；
　　在google尝试用中英文进行多种组合关键字的搜索，baidu中英文都不会有比较有意义的结果；

### （0）前奏：
0)、upstart是什么玩意？
　　upstart是一个基于事件的在启动引导过程中处理启动任务和服务，在关机过程中关闭任务和服务，在系统运行期间维护任务和服务的程序。是替代/sbin/init的守护进程的大部分工作的一个程序。通过注册事件后，再在适当的时候激活此事件，对应的事件就触发了对应的任务或服务。
　　在*nix的系统初始化过程中有进程ID为1的init进程。此进程是在系统启动引导时(此处忽略在它之前的inittrb/initramfs)装载的第一道工序。Upstart是一个替代init的初始化系统。Upstart提供和init相同的实现功能，但在很多方面超越传统的init。Upstart相当于一个外包人员，传统init摇身一变为甲方大佬，很多事情都交给upstart事件驱动的程序去处理，而传统init只对upstart进行调度。
1)、upstart的优越性
　　传统的init的引导启动执行都是顺序执行的，没有异步没有并行性，会影响开机或关机的速度，而upstart是事件驱动的，是异步处理的，所以在引导启动的时间上更加迅速；还有一点主要体现在事件驱动对热插拔设备的动态支持性更好；
　　
2)、upstart能够支持的平台
　　Known Users
　　Ubuntu6.10 and later
　　Fedora9 and later
　　Debian(as an option)
　　Nokia's Maemo platform
　　Palm's WebOS
　　Google's Chromium OS
　　Google's Chrome OS
3)、在什么情况下需要去修改、添加upstart的任务或服务的配置脚本？
　　当需要对任务或服务的启动或关闭顺序进行调整的时候；或有特定的需要的时候，例如此需求中的在关机之前先关闭网络连接的特定需要的时候，就需要修改或添加配置脚本；
4)、具体的一个例子脚本的分析；
以sshd服务为例，详细请戳以下链接：
http://blog.csdn.net/yygydjkthh/article/details/24796755


### （一）解决问题的步骤方法
0）、找到影响关机时间过长的因素；
　　关于Mint 15系统关机时间比较慢的问题，通过google各种关键字后，发现有人针对此问题进行了反馈，当关闭网络连接的情况下，进行关机操作则会在关机时速度变快许多，进行测试之，果然在关机时间上缩短了50%+的时间。那么就要想办法在执行关机或重启命令的时候先将网络连接进行关闭，这就需要先进行upstart事件驱动中的关机流程的分析，找到关机或重启时的事件触发点；
1）、分析upstart事件触发的多个配置文件之间的依赖及先后关系；
　　在Mint 15中，mdm.conf配置文件是界面管理服务，当在系统X图形界面启动时，此服务开启，当在图形界面执行关机或重启时，会触发此服务的stop事件，那么针对需求就必须在此服务stop事件后关闭掉网络连接，才激活下一点直接关机的事件，在配置文件中表示在stop前的关键字为：post-stop script  …… end script，省略号为要添加的shell脚本程序。说明及后续两点请点击：http://blog.csdn.net/yygydjkthh/article/details/25237973 
2）、修改、添加影响upstart事件触发的配置文件，详见；
3）、针对多种关机、重启方法（主要包括界面、终端命令行）进行回归测试并完善；

### （二）、此需求处理中比较重要的点
0）、找突破点；
2）、找事件点，若没有找对事件点，则有可能会影响其它功能；


### （‘/0’）、参考资料：
http://upstart.ubuntu.com/cookbook/#footer
http://upstart.ubuntu.com/

### （附+）：
关于查看系统启动的顺序，不想一句一句地查看脚本的筒子们，可以使用bootchart工具生成一个图表进行查看，可看到具体的开机流程，参照此流程可进一步进行启动的理解或优化。请戳  http://www.bootchart.org/



