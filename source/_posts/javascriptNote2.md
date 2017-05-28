---
title: Javascript笔记2
date: 2017-05-28 12:07:32
tags:
thumbnail: https://image.ibb.co/jSrEoF/1024.png
---

  



# 函数和作用域

## 闭包

在一个函数里return了一个新的函数，当将return的函数赋值给一个变量时，这个外部的函数里的值未被释放，仍可以被访问。

### //TODO 循环闭包的错误

### 封装

```javascript
(function(){
  var ...
  var ...
  export.get... = function(){
    return ..;
  }
  export.get.....
  window.export = export;
}());

export.get....();
//将数据封装起来，外部仅可使用设定好的get方法来获取数据
```

- 闭包是指一个函数或函数的引用与一个引用环境绑定在一起，这个引用环境是一个存储还函数每个非局部变量的表
- 闭包，不同于一般的函数。它允许一个函数在立即词法作用域外调用时，仍可访问非本地变量



使用起来灵活方便，但是会造成空间浪费甚至内存泄漏

## 作用域

### 全局作用域

在js中，没有块级作用域。在

```javascript
for (var item in {a:1}) {
  	.....
}

console.log(item);
```

中，log仍然有输出。在for循环里定义的变量等同于全局变量

### 函数作用域

在函数外部是无法访问函数内的局部变量的

### 作用域链

从内向外都可以访问的到。

如果用构造器调用的函数，是访问不到构造器所在的函数区域的局部变量的。

### 利用函数作用域封装

防止引发冲突。

## ES3执行上下文

### 执行上下文

类似栈的结构。每次访问使用一个函数都会创建一个新的执行上下文的一个环境

### 变量对象

用于存储执行上下文中的 变量、函数声明、函数参数

### 全局执行上下文

在全局作用域下，背后有一个变量对象，会把对应全局的对象存储到Veriable Object里。

浏览器里全局对象window就指向了变量对象

通过这个全局变量对象拿到某个变量的属性等等

解释了为什么在第一行就可以调用math等对象

### 函数中的激活对象

调用时会有一个特殊的arguments的对象

对于函数来讲VO和AO是同一个对象

### 各个阶段

#### 变量初始化阶段

按照函数参数（如无，则为undefined）函数声明（冲突则覆盖）变量声明（初始化变量值为undefined，冲突则忽略）

如果有一个变量和函数都叫d，那么最后会留下函数d而不是变量d

如果有两个变量都叫e，那只留下第一个

```javascript
function foo(x,y,z){
  functionx(){
    
  };
  alert(x);
}
foo(100); //会输出一个function x(){}对象
```

函数表达式不会影响VO。解释了在外部为什么无法拿到命名函数表达式为何在外部无法调用

#### 代码执行阶段

将每个变量赋值

所以当初始化阶段结束后，如变量x和函数x重名，第一次执行调用x会返回函数x，当对函数进行赋值后调用则会返回函数值。如果仅声明但是因为if等语句没有执行赋值的变量，最终调用时会返回undefined

# OOP 面向对象编程

一种程序设计泛型。对象指的是类的实例，将对象作为基本的程序单元，将程序和数据封装其中，以提高软件的重用性，灵活性和扩展性。

一些特性：继承封装多态抽象

## 基于原型链的继承

当使用函数声明时会有一个prototype对象

```javascript
{
	constructor: Foo,
	__proto__: Object.prototype,
	x:1
}
```

 ## 改变prototype

动态的添加或删除一个属性

已经创建的实例，指向的prototype是固定的

当更改prototype为另一个对象后，已经实例化的对象的prototype不会改变

```javascript
haha = new a();
a.prototype.x=1;
a.prototype = {y:2};
haha.x; //1
haha.y; //undefined
```

此时再new一个实例，那prototype指向的对象就改变为新的

！注意 只修改prototype的属性是会是实时影响的

## 实现继承

不能

```javascript
Student.prototype = Person.prototype;
//当创建子类的独特属性时，这样赋值会把person的prototype也改掉
```

应该

```javascript
Student.prototype = Object.create(Person.protype);
//创建一个空函数，把空函数的prototype属性指向Person.protype
//然后应该重设构造器
Student.prototype.constructor = Student;
```

## 模拟重载

java中可以靠判断参数的类型和个数来判断使用同名的哪一个函数。

但由于JavaScript是一个弱类型语言，没有直接的机制进行判断

但可以通过判断arguments属性的长度和每个数值的类型来实现不同的功能

## 链式调用

通过某个方法return this来返回当前对象，可以重复调用同一个方法

```javascript
function Manager(){}
Manager.prototype.add = function(str){
  alert(added!)
  return this;
}
var manag = new Manager();
manager.add('a').add('b').add('c');
```

# 正则表达式

在常见的字符串检索或者替换的时候，我们需要提供一直模式检索或替换的规则。正则表达式使用单个字符串来描述匹配一系列符合某个句法规则的字符串

```javascript
/\d\d\d/.test("123"); //true
/\d\d\d/.test("abc"); //false \d stands for number
new RegExp("Jason").test("Hi, Jason"); //默认case-sensitive
```

| .          | 任意字符 除换行符\n \r \u | /…/.test("1a@")  |
| ---------- | ----------------- | ---------------- |
| \d         | 0-9               |                  |
| \D         | 非\d               |                  |
| \w         | 0-9或大小写字母或下划线     |                  |
| \W         | 非\w               | /\W/.test("@")   |
| \s         | 空格符TAB换页符换行符      | /\sa/.test(" a") |
| \S         | 非\s               |                  |
| \t\r\n\v\f | tab回车换行垂直制表符换页符   |                  |

范围符号

| [...]  | 字符范围   | [a-z], [0-9], [A-Z0-9a-z] |
| ------ | ------ | ------------------------- |
| [^...] | 字符范围以外 |                           |
| ^      | 行首     | ^Hi（Hi在行首                 |
| $      | 行尾     | test$                     |
| \b     | 零宽单词边界 | \bno                      |
| \B     | 非\b    |                           |



特殊符号转译 \^ —> 查找^这个符号

