# 目录说明
获取柠檬wifi任意手机号的登录验证码

# 原理
柠檬wifi登录验证码为固定于位纯数字,且不限尝试次数  
从0000到9999逐个尝试,猜出验证码  

### 注意 使用前应先连接到柠檬wifi，且关闭数据流量

# 准备
确保系统已安装curl，jq  
 - ubuntu  
   `sudo apt install curl jq`
 - 安卓Termux  
   `pkg install curl jq`

# 文件列表
 | 文件名 | 用途 |
 | :---: | :---: |  
 | [lemon_code_thread.sh](./lemon_code_thread.sh) | 获取任意验证码 |  
