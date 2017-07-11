---
title: 回调函数总结
date: 2017-07-11 15:06:16
tags:
---

# 概念

在计算机程序设计中，回调函数，或简称回调（Callback 即call then back 被主函数调用运算后会返回主函数），是指通过函数参数传递到其它代码的，某一块可执行代码的引用。这一设计允许了底层代码调用在高层定义的子程序。

## 通俗来说..

主程序A调用另一个程序B，但是B得到的信息不全，就要再去call另一个函数。这个函数就是回调函数。

本来是A来调用B，但是B最终又调用了A的信息，这个过程被称为回调。

# 举个例子

```java
//待解决的作业
String aHomeWork = "1+1=?"
//室友写出答案
String theAnswer = roomMate.getAnswer(aHomeWork);
//该同学调用，自己把答案写到作业本。（也即是这个步骤不给调用了）
student.doHomeWork(aHomeWork, theAnswer);
//做作业必须得调用这个方法，而根据需求这个方法必须由室友去调用。那很显然，该室友得保持一个该同学的引用，才能正常调用啊。
//灯灯灯~
//室友说，那你在调用getAnswer方法的时候，除了传入作业，还需要把自己的引用放里面。这样我做完了，直接调用你的做作业方法就行了。
roomMate.getAnswer(aHomeWork,student);
```

完整代码

```java
public class Student {

    public void doHomeWork(String homeWork, String answer) {
        System.out.println("作业本");
        if(answer != null) {
            System.out.println("作业："+homeWork+" 答案："+ answer);
        } else {
            System.out.println("作业："+homeWork+" 答案："+ "(空白)");
        }

    }

    public static void main(String[] args) {
        Student student = new Student();

        String aHomeWork = "1+1=?";

        RoomMate roomMate = new RoomMate();
        roomMate.getAnswer(aHomeWork,student);
    }
}
```

RoomMate

```java
public class RoomMate {

    public void getAnswer(String homework, Student student) {
        if("1+1=?".equals(homework)) {
            student.doHomeWork(homework, "2");
        } else {
            student.doHomeWork(homework, "(空白)");
        }
    }
}


```

> 这位学生告诉室友要做什么作业，并把自己的引用也给了室友。该室友得到作业，做完后直接引用该学生并调用其做作业的方法，完成代写作业的任务。





# To be continued..

