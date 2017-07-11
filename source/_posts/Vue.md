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

