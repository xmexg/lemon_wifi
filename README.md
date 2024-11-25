# lemon_wifi
柠檬wifi的一些小工具

# 目录说明
 | 目录名 | 用途 |
 | :-- | :-- |
 | [lemon_code_thread](./lemon_code_thread/) | 获取柠檬wifi任意手机号的登录验证码 |
 | [bypass_login](./bypass_login/) | 免登录上网 |

 # 使用说明
 见 [#1](https://github.com/xmexg/lemon_wifi/issues/1) 下文摘抄自议题1

 需要一点linux基础  

**本项目介绍了两种上网方式, 分别是:**  
 - [lemon_code_thread](https://github.com/xmexg/lemon_wifi/tree/main/lemon_code_thread)已知付费用户手机号, 通过爆破该手机号的登录验证码上网(稳定,推荐)  
 - [bypass_login](https://github.com/xmexg/lemon_wifi/tree/main/bypass_login)未知任何手机号, 但是附近正有付费用户上网, 通过伪造该用户mac地址上网(不稳定)

假设你目前物理机正在使用linux([deepin](https://www.deepin.org/index/zh)/[ubuntu](https://cn.ubuntu.com/desktop)/[debian](https://www.debian.org/index.zh-cn.html)/[kali](https://www.kali.org/get-kali))操作系统尝试连接柠檬wifi  
windows系统或windows系统里装linux虚拟机或者wsl里装linux可以爆破验证码上网, 但是无法改mac地址上网  

# 最佳的上网方法(已知手机号爆破验证码法)如下:  
先自己注册个柠檬wifi, 抓登录包, 登录包里有所在区域的负责人手机号, 使用[lemon_code_thread](https://github.com/xmexg/lemon_wifi/tree/main/lemon_code_thread)爆破负责人手机号验证码进行上网  
## 抓包篇
kali系统自带burp, 可以跳过第1步和第2步  
1. 下载[burpsuite](https://portswigger.net/burp/releases/professional-community-2024-10-2?requestededition=community&requestedplatform=)  
  打开网页, linux系统选择`Burp Suite Community Edition`(社区版即免费版), `Linux (x64)`(非华为电脑主流选择带`x64`的, 少数华为电脑标注arm处理器的选带`ARM`)  , 同理windows系统选择`Windows (x64)`或`Windows (ARM)`
![image](https://github.com/user-attachments/assets/c5014f2b-a9be-4fe0-a640-890a61fb48f6)

2. 找到burp下载位置, **windows直接双击安装就好**, 下文是linux的安装方法  
   - 方法一: 纯图形界面操作(不一定有效, 有可能会当成普通txt文档打开)
      文件管理器(以thunar为例)里打开文件保存的位置, 右击该sh安装包, 选择`properties(首选项)`, 选择`permissions(权限)`选项卡, 给`Allow this file to run as a program(允许执行)`打勾,  然后双击安装burp即可  
      ![image](https://github.com/user-attachments/assets/5eea5221-8073-4206-87e8-fb876de7c60b)
  
   - 方法二: 命令行操作(始终有效)
      打开命令行, 一般快捷键为`ctrl+shift+t`, 使用cd命令进入burp文件所在目录, 如上图我应该输入`cd /home/vina/burp`, 回车  
      输入`chmod +x ./你下载的burp文件名`回车来给予可执行权限   
      输入`./你下载的文件名`回车
      ![image](https://github.com/user-attachments/assets/3c6544cb-1702-42fe-93f9-f13e96ed3361)
  
3.  找到burp并运行  
  安装好后能在开始菜单找到burp, 点击运行即可, 如果找不到的话, **windows桌面有快捷方式**, linux默认的安装位置是`~/BurpSuiteCommunity`, 命令行输入`~/BurpSuiteCommunity/BurpSuiteCommunity`也能运行  

4. 打开抓包页面及内部浏览器  
  一路点橙色按钮next next start打开burp主界面,选中如图我选择的标签页,点击``打开内部浏览器  
  ![image](https://github.com/user-attachments/assets/27eb478b-cb39-48f2-b9ca-46076a525f59)  
  ![image](https://github.com/user-attachments/assets/67e98b24-e7ee-4e92-b277-427239245960)  
  ![image](https://github.com/user-attachments/assets/1855c2ec-aab0-4953-8b58-041b9bff034d)

5. 开始抓登录包
  在刚刚打开的内部浏览器访问柠檬wifi登录页面, 正常登录, burp会记下数据包, 完成登录后回到burp, 寻找url是`portal/auth.ajax`的数据包, 仔细观察数据包, 里面有该区域的网络负责人手机号, 记下该手机号  

6. 爆破登录验证码
    - windows(由chatgpt转换,未测试):
    windows前往[lemon_code_thread](https://github.com/xmexg/lemon_wifi/tree/main/lemon_code_thread)页面   
    根据`准备`下的代码安装对应的软件包
    下载`lemon_code_thread.bat`文件,用记事本打开并编辑第2行, 把`set phone=   REM 此处输入手机号`添加上负责人的手机号,保存并双击运行   
等待脚本遍历所有验证码后给出正确的验证码, 然后使用手机号+验证码在浏览器登录界面正常登录
    - linux:
    linux前往[lemon_code_thread](https://github.com/xmexg/lemon_wifi/tree/main/lemon_code_thread)页面 
    根据`准备`下的代码安装对应的软件包  
    下载`lemon_code_thread.sh`, 同理编辑第2行的`phone= # 此处输入手机号`添加上负责人的手机号,保存后命令行使用"chmod +x ./lemon_code_thread.sh"和"./lemon_code_thread.sh"运行脚本   
等待脚本遍历所有验证码后给出正确的验证码, 然后使用手机号+验证码在浏览器登录界面正常登录   

# 无手机号上网方法(伪造mac法)如下:
该方法不稳定, 且只允许linux真机使用, 详见 https://github.com/xmexg/lemon_wifi/tree/main/bypass_login  
![github com_xmexg_lemon_wifi_tree_main_bypass_login](https://github.com/user-attachments/assets/5f6a576b-b288-49a2-899c-297a6d137a03)
