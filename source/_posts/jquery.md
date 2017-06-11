---
title: jQuery笔记
date: 2017-05-28 21:02:38
tags:
thumbnail: https://image.ibb.co/dqQ5dF/images.png
---



# jQuery的安装和使用

```
npm install jquery
```

或者使用CDN，在HTML中直接引用

```html
<!--Google CDN jQuery3-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!--Google CDN jQuery2-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
```

# jQuery选择器

$(DOM Object) 将DOM对象转换为jQuery对象

$("#id")通过id获取jQuery对象

$(".class")通过class获取

$("p")通过标签获取

$("*")全选择器，获取界面所有元素

$('div > p') 选择指定parent里的指定子元素

$('div p')选择指定祖先元素里的后代元素，包含子元素

$(".prev + div")选择所有紧挨prev元素的兄弟元素

$(".prev ~ div")选择所有具有相同父元素的兄弟元素

# jQuery基本筛选选择器

使用:来进行筛选

$(".div:first")匹配第一个元素

:last

:even

:odd

:eq(index)在匹配到的集合中选择index对应的数据

:gt(index)选择所有index大于给定值的元素

:lt(index)选定所有小于index的

:not(selector)选择所有不满足给定选择器的元素

## 内容筛选器

:contains("text")

:parent 选择所有含有子元素的父节点

:empty选择所有不含子节点的节点，包含文本节点

:has(selector)选择元素包含的元素中至少满足给定选择器的元素

:visiable 可见元素

:hidden隐藏元素

>隐藏元素的方法
>
>1. CSS display的值是none。
>2. type="hidden"的表单元素。
>3. 宽度和高度都显式设置为0。
>4. 一个祖先元素是隐藏的，该元素是不会在页面上显示
>5. CSS visibility的值是hidden
>6. CSS opacity的指是0







#

