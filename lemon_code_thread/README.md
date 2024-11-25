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
 - windows  
   **首先打开powershell**  
   `winget install --id cURL.cURL`  
   `winget install --id jqlang.jq`  
   ![image](https://github.com/user-attachments/assets/33bcb6f5-c57a-4fca-a1e4-e064353b3bd6)


# 文件列表
 | 文件名 | 用途 |
 | :---: | :---: |  
 | [lemon_code_thread.sh](./lemon_code_thread.sh) | linux版获取任意验证码 |  
 | [lemon_code_thread.bat](./lemon_code_thread.bat) | windows版获取任意验证码(未测试) |  
