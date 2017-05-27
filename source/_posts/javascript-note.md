---
title: JavaScript笔记
date: 2017-05-24 00:11:04
tags:
thumbnail: thumbnail/js.png
---

#  

#  函数

## 函数声明与表达式

匿名函数表达式

```javascript
var func = function (a,b) {
  //
  //
}
```

这种赋值给某个变量的函数不能在定义之前使用，而直接定义声明的函数可以放在任何地方

## 命名函数表达式

名称作用于仅限于命名的时候。外部无法访问到。

（其实没什么鸟用

## 函数构造器

使用new 或省略new

```javascript
var func = new Function('a','b','console.log(a+b');
func(1,2); //3
```

作用域

在构造器里用的变量只能在括号里生效，无法由外部访问

```javascript
//1
Function('var localVal .......')
document.write(localVal) //UNDEFINED
//2
var globalVal....
(function() {
  var localVal....
  Function('document.write(typeof localVal, typeof globalVal')
}); //UNDEFINED STRING
```



值得注意的是，如case2，函数构造器里并不能访问上一层的局部变量，但却可以访问全局变量。

# this

全局的this相当于window

```
this.document === document //true
this === window //true
```

## 作为对象方法的函数的this

指向对象本身，或调用某个函数的对象本身

```javascript
//WARNING
var o = {prop:1};
function independ(){
  return this.prop;
}
o.f = independent //会return1
//此时this会智能地指向o
```

## 对象原型链上的this

调用了原型链上的另一个对象的一个含有this的方法，这个this仍然指向这个对象本身，仍然可以访问自身的属性

## 构造器中的this

如果在构造器里调用了this，js会创建一个空的对象，这个对象的原型会指向构造器的那个函数。如果没写return语句，默认会把this返回。

```javascript
function abc(){
  this.a = 1;
}
var o = abc();
document.write(o.a); //1


function def(){
  this.a = 1;
  return {a:2};
}
var o = def();
document.write(o.a); //2
```

## call/apply 与this

```javascript
o.call($a,b,c,d,e....)//$a代表传入函数作为this的对象，bcde代表函数需要的参数
o.apply($a,[b,c,d,e....])//$a与上面相同，区别是其他的参数在apply里是由数组的形式传进去的
```

## bind方法与this

```javascript
function f(){
  return this.a;
}
var g = f.bind({a:"123"});
//此时传进去的大括号代表的对象将与g绑定
document.write(g()); // 123
```

从此往后无论什么情况下，调用g，return的始终是123

# Arguments

o.name 函数名

o.length 形参个数

arguments.length 实参个数

## bind and currying

```javascript
function abc(a,b,c)(){
  return a+b+c;
}
var func = abc.bind(null,100); //null传入作为this的话会指向全局变量window，100在这里相当于替换了第一个变量a
func(1,2); //103
var func = abc.bind(null,200); //200替换了第二个变量b
func(3); //303
```

