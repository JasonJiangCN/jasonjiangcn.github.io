---
title: Python爬虫笔记
date: 2017-05-27 20:19:32
tags:
---

# 简单爬虫架构

爬虫调度端 —> url管理器 —>网页下载器 —> 网页解析器 —> 有价值的数据

只要有相关的url 中间的爬虫架构会一直运行下去



## 运行流程

![](https://image.ibb.co/hRpHav/IMG_0005.png)

# URL 管理器

防止重复抓取和循环抓取

## 实现方式

第一种：将待爬取的放在内存里

e.g.. 在py中放在两个set里

第二种：放在关系数据库里

urls(url,is_crawled)

第三种：缓存数据库

两个set 已爬取和待爬去

# 网页下载器

将url对应的网页下载下来

以html的格式存到本地

## python的下载器

1. urllib2 py官方的
2. requests 第三方 更强大

## urllib2 的使用

```python
import urllib2
#直接请求
response = urllib2.urlopen("http://www.baidu.com")
#获取状态码 如果为200则成功
print response.getCode()
#读取内容
cont = response.read()
```

## urllib2 运行by data & http header

```python
import urllib2
#创建request对象
request = urllib2.Request(url)
#添加数据
request.add_data('a','1')
#添加http的header
request.add_header('User-Agent','Mozilla/5.0')
#发送请求
response = urllib2.urlopen(request)
```

## 添加特殊情景的处理器

1. HTTPCookieProcessor
2. ProxyHandler
3. HTTPSHandler
4. HTTPRedirectHandler

```python
import urllib2,cookielib
#创建cookie容器
cj = cookielib.CookieJar()
# 创建一个opener
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))
#给urllib2安装opener
urllib2.install_opener(opener)
#使用带有cookie的urllib2访问网页
response = urllib2.urlopen("http://www.baidu.com")
```

# 网页解析器

用来提取有价值数据的工具

Python中

1. 正则表达式 （字符串形式的模糊匹配
2. html.parser 官网
3. Beautiful soup 兼容2和4
4. lxml

2，3，4是结构化解析（DOM树

```bas
pip install beautifulsoup4
#Install beautifulsoup4
```

## Beatuiful Soup

```html
<a href = '123.html' class='article_link'>Python</a>
```

```python
from bs4 import BeautifulSoup
soup = BeautifulSoup(
					html_doc, #HTML文档字符串
					'html.parser' #HTML解析器
					from_encoding='utf-8' #HTML文档的编码
)
```

### 搜索节点

```python
# soup.find_all(name,arrts,string)
#查找所有标签为a的节点
soup.find_all('a')
#查找所有标签为a，连接符合/view/123.htm形式的节点
soup.find_all('a',href='/view/123.htm')
soup.find_all('a',href=re.compile(r'/view/\d+\.htm)) #使用正则表达式来匹配
#查找所有标签为div，class为abc，文字为python的节点
soup.find_all('div',class_='abc',string="python")
```

# 开发实例爬虫

确定目标 —> 分析目标 —> [url格式，数据格式，网页编码] —> 编写代码 —> 执行爬虫

## Main

```python
#crawler_main.py
#从这个package中import
from nameOfCurrentPackage import url_manager,html_downloader,html_parser,html_outputer
class CrawlerMain(object):
	def __init__(self):
        self.urls = url_manager.UrlManager()
        self.downloader = html_downloader.HtmlDownloader()
        self.parser = html_parser.HtmlParser()
        self.outputer - html_outputer.HtmlOutputer()
        
    def craw(self, root_url):
        count = 1
        self.urls.add_new_url(root_url)
        while self.urls.has_new_url():
            try:
            	new_url = self.urls.get_new_url()
            	print 'craw %d : %s' %(count,new_url)
            	html_cont = self.downloader.download(new_url)
            	new_urls, new_data = self.parser.parse(newurl,html_cont)
           		self.urls.add_new_urls(new_urls)  #补充新的url
            	self.outputer.collect_data(new_data)
            	count = count + 1
            except:
                print 'craw failed'
        self.outputer.output_html()
if __name__ == '__main__':
    root_url = "http://...."
    obj_crawler = CrawlerMain()
    obj_crawler.craw(root_url)
```

## UrlManager

```python
class UrlManager(self):
    def __init__(self):
        self.new_urls = set()
        self.old_urls = set()
    def add_new_url(self):
        if url is None:
            return
        if url not in self.newurls and url not in self.old_urls:
        	self.new_urls.add(url)
    def add_new_urls(self):
        if urls is None or len(urls) == 0:
        	return
        for url in urls:
            self.add_new_url(url)
    def has_new_url(self):
        return len(self.new_urls) != 0
    def get_new_url(self):
        new_url = self.new_urls.pop()
        self.old_urls.add(new_url)
        return new_url
```

## HtmlDownloader

```python
class HtmlDownloader(object):
    def download(self, url):
        if url is none:
            return None
        response = urllib2.urlopen(url)
        if response.getCode() != 200:
            return None
        return response.read()
```

## HtmlParser

```python
class HtmlParser(object):
    def _get_new_urls(self,page_url,soup):
        new_urls = set()
        links = soup.find_all('a', href=re.compile(r"///////"))
        for link in links:
            new_url = link["href"]
            # 拼接url
            new_full_url = urlparse.urljoin(page_url, new_url)
            new_urls.add(new_full_url)
        return new_urls
    def _get_new_data(self, page_url, soup):
        res_data = {}
        res_data['url'] = page_url
        title_node = soup.find('标签', class_='').find("h1")
        res_data['title'] = title_node.get_text()
        summary_node = soup.find(..........)
        res_data['summary'] = summary_node.get_text()
        return res_data
    def parse(self, page_url, html_cont):
    if page_url is None or html_cont is None:
        return 
    soup = BeautifulSoup(html_cont, 'html.parser', from_encoding='utf-8')
    new_urls = self._get_new_urls(page_url,soup)
    new_data = self._get_new_data(page_url,soup)
    return new_urls, new_data
```

## HtmlOutputer

```python
class HtmlOutputer(object):
    def __init__(self):
        self.data = []
    def collect_data(self,data):
        if data is None:
            return
        self.data.append(data)
    def output_html(self):
        fout = open('output.html','w') #w为“写模式”
        fout.write("<html>")
        fout.write("<body>")
        fout.write("<table>")
        
        for data in self.data:
            fout.write("<tr>")
            fout.write("<td>%s</td>" % data['url'])
            fout.write("<td>%s</td>" % data['title'].encode('utf-8'))
            fout.write("<td>%s</td>" % data['summary'].encode('utf-8'))
            fout.write("</tr>")
        fout.write("</html>")
        fout.write("</body>")
        fout.write("</table>")
```

