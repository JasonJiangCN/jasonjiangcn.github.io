---
title: Vue
date: 2017-07-11 10:29:01
tags:
---

# 引入Vue

```javascript
<script src="https://unpkg.com/vue"></script>
```

# 起步

## 声明式渲染

```javascript
<div id="app">
  {{ message }}
</div>


var app = new Vue({
  el: '#app',
  data: {
    message: 'Hello Vue!'
  }
})
```

运行结果

> Hello Vue!

并且所有数据和DOM已经绑定，所有元素都是**响应式**的。对元素数据的修改可以实时的对网页显示的数据进行更新。

### 指令

指令前带有前坠 `v-` 表示是Vue提供的。

> v-bind 绑定， 将元素节点的某个属性和Vue实例的某个属性保持一致

## 条件与循环

> v-if 指令。如果后面跟的Data为True则显示后面的内容。



> v-for可以绑定数组的数据来渲染

```javascript
//v-for

//html
<div id="app-4">
  <ol>
    <li v-for="todo in todos">
      {{ todo.text }}
    </li>
  </ol>
</div>
  
//js
var app4 = new Vue({
  el: '#app-4',
  data: {
    todos: [
      { text: '学习 JavaScript' },
      { text: '学习 Vue' },
      { text: '整个牛项目' }
    ]
  }
})
```

## 用户输入

> v-on可以绑定一个事件监听器。



button上的`v-on:click` 属性可以调用Vue中methods里定义的方法。

```javascript
<div id="app-5">
  <p>{{ message }}</p>
  <button v-on:click="reverseMessage">逆转消息</button>
</div>
  
var app5 = new Vue({
  el: '#app-5',
  data: {
    message: 'Hello Vue.js!'
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
})
```



> v-model 可以实现输入数据和表单数据的双向绑定



```javascript
<div id="app-6">
  <p>{{ message }}</p>
  <input v-model="message">
</div>
var app6 = new Vue({
  el: '#app-6',
  data: {
    message: 'Hello Vue!'
  }
})
//在输入框里输入的所有内容都会实时同步到message里，进而同步到p标签的内容里
```

## 组件化

利用小型组件构建大型应用。

```javascript
//注册一个组件
Vue.component("new-item",{
  //props现在作为这个组建的"prop"，类似一个自定义属性
  //这个属性的名字叫newItem、
  props: ['newItem'],
  
  template: '<li>{{ newItem.text }}</li>'
})

<ol>
  <new-item>
  	v-bind:newItem="(填入要绑定的数据类型名称）"
  </new-item>
  
</ol>

```

利用循环和绑定输出一个列表

```javascript
<div id="app-7">
  <ol>
    <!--
      现在我们为每个 todo-item 提供待办项对象
      待办项对象是变量，即其内容可以是动态的。
      我们也需要为每个组件提供一个“key”，晚些时候我们会做个解释。
    -->
    <todo-item
      v-for="item in groceryList"
      v-bind:todo="item"
      v-bind:key="item.id">
    </todo-item>
  </ol>
</div>
Vue.component('todo-item', {
  props: ['todo'],
  template: '<li>{{ todo.text }}</li>'
})
var app7 = new Vue({
  el: '#app-7',
  data: {
    groceryList: [
      { id: 0, text: '蔬菜' },
      { id: 1, text: '奶酪' },
      { id: 2, text: '随便其他什么人吃的东西' }
    ]
  }
})
```

输出结果

> 1. 蔬菜
> 2. 奶酪
> 3. 随便其他什么人吃的东西

可见子单元利用props接口获取了负担元终端数据。

这样做的好处是在子单元`todo-item` 中做的更复杂的修改，不会影响到父单元。



Vue组件和Web自定义元素很相似。但是优点是可以在不需要任何补丁的情况下运行在主流浏览器里。必要时Vue组件也可以包装进原生自定义元素之内。也多了很多特别的内容，eg. 跨组件数据流



# Vue实例

## 构造器

所有Vue应用都是要通过Vue构造器来创建的

```javascript
var vm = new Vue({
  //各种选项
})
```

也可以自己扩展某项功能，做一个新的构造器

```javascript
var MyComponent = Vue.extend({
  // 扩展选项
})
// 所有的 MyComponent 实例都将以预定义的扩展选项被创建
var myComponentInstance = new MyComponent()
```

每个Vue实例都会代理data对象里的所有属性

```javascript
var data = { a: 1 }
var vm = new Vue({
  data: data
})
vm.a === data.a // -> true
// 设置属性也会影响到原始数据
vm.a = 2
data.a // -> 2
// ... 反之亦然
data.a = 3
vm.a // -> 3
```

>  这种属性是**响应的**

除了 data 属性， Vue 实例暴露了一些有用的实例属性与方法。这些属性与方法都有前缀 `$`，以便与代理的 data 属性区分。例如：

```javascript
var data = { a: 1 }
var vm = new Vue({
  el: '#example',
  data: data
})

vm.$data === data // -> true
vm.$el === document.getElementById('example') // -> true

// $watch 是一个实例方法
vm.$watch('a', function (newVal, oldVal) {
  // 这个回调将在 `vm.a`  改变后调用
})
```

注意，不要在实例属性或者回调函数中（如 `vm.$watch('a', newVal => this.myMethod())`）使用箭头函数。因为箭头函数绑定父级上下文，所以 `this` 不会像预想的一样是 Vue 实例，而是 `this.myMethod` 未被定义。



## 实例生命周期钩子

在某些特定情况下，调用某种函数的钩子。

例如

```javascript
var vm = new Vue({
  data: {
    a: 1
  },
  created: function () {
    // `this` 指向 vm 实例
    console.log('a is: ' + this.a)
  }
})
// -> "a is: 1"
```

在这个实例创建的时候就会调用这个函数

类似的还有`mounted` `update`  `destroyed`

![](https://cn.vuejs.org/images/lifecycle.png)



# 模板语法

## 插值

### 文本

`Mustache`语法，即双大括号的文本插值

```html
<span>
	Message: {{ msg }}
</span>
```

此处的插值会跟随msg的值改变而实时进行变化



还有另一个指令，可以进行一次性插值，当数据改变时插值也不会改变。注意v-once绑定的节点上所有插值均有此特性

```html
<span v-once>
This will not change: {{ msg }}
</span>
```

### HTML

```html
<div v-html="rawHtml">
  
</div>
```

此处v-html的内容会被替换为属性值html

> 此处的数据绑定会被忽略

注意 此处不可以使用v-html来复合局部模板，因为Vue不是基于字符串的模板引擎。组件适合担任UI重用与复合的基本单元

值得注意的是，**绝对不要**直接引用用户的HTML，可能会造成XSS攻击(Cross Site Scripting, CSS or XSS)

#### 模板解决方案的区别

1. **String-based 模板技术** (基于字符串的parse和compile过程)
2. **Dom-based 模板技术** (基于Dom的link或compile过程)
3. 杂交的**Living templating 技术** (基于字符串的parse 和 基于dom的compile过程)

同种类型的模板技术的**可能性**都是相同的，即同样身为dom-based的Vue.js如果愿意可以发展为angularjs的相同功能层

1. String-based ![](http://leeluolee.github.io/attach/template-engine/String-based-Template.png)
2. DOM-based ![](http://leeluolee.github.io/attach/template-engine/Dom-based-Template.png)

Vue是DOM-based，在获得初始的DOM结构后仅利用DOM API(attributes, getAttribut, firstChild)等进行详细的修改，所以在上面提到的引用来的html中引用外部模板是无法工作的

### 属性

Mustache不能在HTML属性中使用，此时应该使用v-bind

```html
<div v-bind:id="dynamicId"></div>

<button v-bind:disabled="isButtonDisabled">
  Button
</button>
```

### JavaScript 表达式

所有数据绑定也可以加入标准的JavaScript表达式

```html
{{ number + 1 }}
{{ ok ? 'YES' : 'NO' }}
{{ message.split('').reverse().join('') }}
<div v-bind:id="'list-' + id"></div>
```



这些表达式会在所属 Vue 实例的数据作用域下作为 JavaScript 被解析。有个限制就是，每个绑定都只能包含**单个表达式**，所以下面的例子都**不会**生效。

```html
<!-- 这是语句，不是表达式 -->
{{ var a = 1 }}

<!-- 流控制也不会生效，请使用三元表达式 -->
{{ if (ok) { return message } }}
```

#### 语句和表达式的区别

JavaScript中的表达式和语句是有区别的.一个表达式会产生一个值,它可以放在任何需要一个值的地方,比如,作为一个函数调用的参数.下面的每行代码都是一个表达式:

```
myvar
3 + x
myfunc("a", "b")
```

语句可以理解成一个行为.循环语句和if语句就是典型的语句.一个程序是由一系列语句组成的.JavaScript中某些需要语句的地方,你可以使用一个表达式来代替.这样的语句称之为表达式语句.但反过来不可以:你不能在一个需要表达式的地方放一个语句.比如,一个if语句不能作为一个函数的参数.

## 指令

是带有v-前缀的特殊属性，职责就是当其表达式的值改变的视乎相应的将某些行为应用到DOM上。

### 参数

一些指令可以接受一个“参数”，在指令后用冒号指明

```html
<a v-bind:href="url"></a>
```



### 修饰符

Modifiers是以半角句号`.`来指明的特殊后缀，用于指出一个指令应该以特殊的方式绑定。`.prevent`修饰符告诉v-on指令对于出发点时间调用`event.preventDefault()`

```html
<form v-on:submit.prevent="onSubmit"></form>
```

## 过滤器

Vue.js允许使用自定义过滤器。

```html
<!-- in mustaches -->
{{ message | capitalize }}
<!-- in v-bind -->
<div v-bind:id="rawId | formatId"></div>
```

过滤器函数总是接受表达式的值作为第一个参数

```javascript
new Vue({
  // ...
  filters: {
    capitalize: function (value) {
      if (!value) return ''
      value = value.toString()
      return value.charAt(0).toUpperCase() + value.slice(1)
    }
  }
})
```

过滤器也可以串联

```
{{ message | filterA | filterB }}
```

也可以接受参数

```
{{ message | filterA('arg1', 'arg2') }}
```

值得注意的是，第一个参数永远是表达式的值（message), arg1和2分别作为第二个和第三个参数传给filterA

## 缩写

```html
<!-- v-bind 缩写 -->

<!-- 完整语法 -->
<a v-bind:href="url"></a>
<!-- 缩写 -->
<a :href="url"></a>

<!-- v-on缩写 -->

<!-- 完整语法 -->
<a v-on:click="doSomething"></a>
<!-- 缩写 -->
<a @click="doSomething"></a>
```

# 计算属性

