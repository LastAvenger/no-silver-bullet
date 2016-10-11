## Firefox 插件
* ~~pantadactyl~~ 15-11-30 巨卡，改用 VimFx
* ~~标签页管理器~~ 已于 2015-11 停止支持
* Tab MixPlus
* Fire Guesture
* Sytlish
* Push to Kindle
* LassPass
* ChatZilla
* ADBlocker
* FoxyProxy
* Mulitfox
* VimFx

# Tricks
## Stylish

* `@-moz-document domain` 作用于域名及子域名，`百度.com`, `贴吧.百度.com`
  什么的，无法对 `贴吧.百度.com/p/` 生效
* `@-moz-document url-prefix` 作用于网址开头，只在最后通配，不能同时对
  `http://贴吧.百度.com/p/` 和 `https://贴吧.百度.com/p/` 生效
* `@-moz-document regexp `正则方式
* `@-moz-document url` 作用于唯一网址
