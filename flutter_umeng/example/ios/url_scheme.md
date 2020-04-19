## 配置URL Scheme
URL Scheme是通过系统找到并跳转对应app的一类设置，通过向项目中的info.plist文件中加入URL types可使用第三方平台所注册的appkey信息向系统注册你的app，当跳转到第三方应用授权或分享后，可直接跳转回你的app。

添加URL Types可工程设置面板设置d

配置第三方平台URL Scheme未列出则不需设置

平台    格式    举例    备注
微信    微信appKey    wxdc1e388c3822c80b    
QQ/Qzone    需要添加两项URL Scheme：
1、"tencent"+腾讯QQ互联应用appID
2、“QQ”+腾讯QQ互联应用appID转换成十六进制（不足8位前面补0）    如appID：100424468 1、tencent100424468
2、QQ05fc5b14    QQ05fc5b14为100424468转十六进制而来，因不足8位向前补0，然后加"QQ"前缀
新浪微博    “wb”+新浪appKey    wb3921700954    
支付宝    “ap”+appID    ap2015111700822536    URL Type中的identifier填"alipayShare"
钉钉    钉钉appkey    dingoalmlnohc0wggfedpk    identifier的参数都使用dingtalk
易信    易信appkey    yx35664bdff4db42c2b7be1e29390c1a06    
点点虫    点点虫appID    8112117817424282305    URL Type中的identifier填"Laiwang"
领英    “li”+appID    li4768945    
Facebook    “fb”+FacebookID    fb506027402887373    
Twitter    “twitterkit-”+TwitterAppkey    twitterkit-fB5tvRpna1CKK97xZUslbxiet    
VKontakte    “vk”+ VKontakteID    vk5786123    
