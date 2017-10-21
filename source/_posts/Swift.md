---
title: Swift笔记
date: 2017-10-20 21:09:12
tags: Swift
---

#Swift基本类型

##变量和常量

let 常量

var 变量

可以同时声明多个变量

` var x=1, y =2 , z = 3`

**Swift是一个强类型语言**

type inference: 赋值时Swift会自动根据初始值指定类型

**按住Option键/Alt键，将光标放在变量上即可显示变量类型**



`let website: String = "www.jasonjx.com"`可以显式的声明常量或者变量

`var a,b,c : Double`多个变量同时声明类型

# 常用类型

- Int 
- Float, Double
- Boolean
- String
- Tuple

##整型

整型的长度是32/64位，取决于系统是32还是64位的

UInt类型是无符号的数，可以表示的正数是Int的两倍，最小是0



Int8： 8位的整数（最大256） Int16， Int32， Int64



可以把二进制 16进制赋值给Int



甚至可以`let bigNum = 100_100_100`实际上就是100100100，可以加下划线增加可读性

## 浮点数

Float是32位 Double是64位

type inference默认Double类型



不同类型之间不能直接运算，没有隐式类型转换

手动类型转换 `Double(a)`



**CGFloat ** Configure Graphic类型的Float

`UIColor(red: red ........)` 这里的red类型必须为CGFloat类型



## 布尔类型

`Bool`布尔类型

```swift
if imTrue { //if后面的条件可以不用加括号
    print("I'm True")
} //即使只有一句话也必须加大括号
```



## Tuple

元组类型

```swift
var point ( 5, 2 )
var httpResponse( 404, "Not Found")
```



可以有任意多个值



显式指定元组`var a : (int, String) = (1,"A")`



`var (staus, msg) = httpResponse`

`msg`  // <— "Not Found"

定义的元组里的变量其实可以当做全局变量访问





可以对各个分量命名

```swift
let point3 = (x:3, y:2)
point3.x
let point4: (x:Int, y: Int) = (4,5)
point4.x
```



解包的时候可以只解一部分

```swift
let loginResult = (true, "hahaha")
let (isLoginSuccess, _) = loginResult
//此时后面的字符串就没有被解包存储
```

适合轻量级的数据

## 变量名 Print 注释

Swift规定类型名称首字母大写

变量 函数名 首字母应该小写

还可以用中文 emoji当变量名



### Print

```swift
print(x, y, z)	//x y z
print(x, y, z, separator:"-", terminator:" :)") //x-y-z :)
```

terminator 默认是回车



```swift
var x = 1
print("\(x) Haha")  //1 Haha
```

