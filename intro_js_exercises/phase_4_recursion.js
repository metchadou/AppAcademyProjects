function range(start, end) {
  if (start === end) {
    return [];
  }

  return [start].concat(range(start+1, end));
}

function sumRec(arr) {
  if (arr.length === 0) {
    return 0;
  }
  
  return arr.pop() + sumRec(arr);
}

function exponentFirstVersion(base, exp) {
  if (exp === 0) {
    return 1;
  }

  return base * exponentFirstVersion(base, exp-1);
}

function exponentSecondVersion(base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  }

  if (exp % 2 === 0) {
    let num = exponentSecondVersion(base, exp / 2);
    return num * num;
  } else {
    let num = exponentSecondVersion(base, (exp-1) / 2);
    return base * (num * num);
  }
}

function fibonacci(n) {
 if (n === 0) {
   return [];
 } else if (n === 1) {
   return [0];
 } else if (n === 2) {
   return [0, 1];
 }

 let sequence = fibonacci(n-1);
 const lastNum = sequence[sequence.length-1]
 const secondToLastNum = sequence[sequence.length-2]
 sequence.push(lastNum + secondToLastNum);

 return sequence;
}

function deepDup(arr) {
  const duppedArray = [];

  arr.forEach(el => {
    if (Array.isArray(el)) {
      duppedArray.push(deepDup(el))
    } else {
      duppedArray.push(el)
    }
  });

  return duppedArray;
}

function bsearch(arr, target) {
  if (arr.length === 0) {
    return -1;
  }

  let result;
  const middleIdx = Math.floor(arr.length / 2);
  const middleNum = arr[middleIdx];

  if (middleNum === target) {
    return middleIdx;
  } else if (middleNum > target) {
    const left = arr.slice(0, middleIdx);
    result = bsearch(left, target);
  } else if (middleNum < target) {
    const right = arr.slice(middleIdx + 1, arr.length);
    result = bsearch(right, target);

    if (result !== -1) {
      result += middleIdx + 1;
    }
  }

  return result;
}

function mergeSort(arr) {
  if (arr.length === 0 || arr.length === 1) {
    return arr;
  }

  const midIdx = Math.floor(arr.length / 2);
  const left = arr.slice(0, midIdx);
  const right = arr.slice(midIdx, arr.length);
  const sortedLeft = mergeSort(left);
  const sortedRight = mergeSort(right);

  return merge(sortedLeft, sortedRight);
}

function merge(firstArr, secondArr) {
  const sorted = [];

  while (firstArr.length > 0 && secondArr.length > 0) {
    if (firstArr[0] <= secondArr[0]) {
      sorted.push(firstArr.shift());
    } else {
      sorted.push(secondArr.shift());
    }
  }

  return sorted.concat(firstArr.concat(secondArr));
}

// COULD'NT DO THE LAST ONE BY MYSELF

function subsets(arr) {
  if (arr.length === 0) {
    return [[]];
  }

  const first = arr[0];
  const withoutFirst = subsets(arr.slice(1));

  const withFirst = withoutFirst.map(sub => [first].concat(sub));

  return withoutFirst.concat(withFirst);
}