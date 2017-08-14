---
title: 算法：找到连续数组缺失的两个数
date: 2017-08-14 22:02:26
tags: 算法
---



在连续的数组里缺失了2个数，找到一种O(logN)的方法找到这两个





# 初步想法

二分，判断左右部分的首尾差是否相同，如果相同则两边各有一个缺失的数，如果不一样说明集中在两边

递归查找直到只剩4个，判断出左右后可以直接得出缺失的数

```java
public static int[] getNext(int[] left, int[] right) {
    if ((left[left.length() - 1] 
         - left[0]) == (right[right.length() - 1] - right[0]))
    	return null;
    else if ((left[left.length() - 1] 
         - left[0]) < (right[right.length() - 1] - right[0]))
    	return right;
  	else
      	return left;
}

public static int getMissing(int[] nums) {
    if (nums.length == 4) {
        for (int i = 0; i < 4; i++) {
            if (nums[i] != nums[i + 1] - 1)
              return nums[i] + 1;
        }
    }
  
	
}
```

