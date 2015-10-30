# Tricks

# Plugins
## Stylish
* `@-moz-document domain` 作用于域名及子域名，`百度.com`, `贴吧.百度.com` 什么的，无法对`贴吧.百度.com/p/`生效
* `@-moz-document url-prefix` 作用于网址开头，只在最后通配，不能同时对`http://贴吧.百度.com/p/`和`https://贴吧.百度.com/p/`生效
* `@-moz-document regexp `正则方式
* `@-moz-document url` 作用于唯一网址
