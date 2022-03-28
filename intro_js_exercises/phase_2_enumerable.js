Array.prototype.myEach = function (cb) {
  const that = this;
  for (let i = 0; i < that.length; i++) {
    cb(that[i]);
  }
}

Array.prototype.myMap = function(cb) {
  const mappedArray = [];

  this.myEach(function(el) {
    new_el = cb(el);
    mappedArray.push(new_el);
  })

  return mappedArray;
}

Array.prototype.myReduce = function(cb, initVal) {
  let accumulator = initVal;

  if (initVal === undefined) {
    accumulator = this[0];

    for (let i = 1; i < this.length; i++) {
      let el = this[i];
      accumulator = cb(accumulator, el);
    }
  } else {
    this.myEach(function(el) {
      accumulator = cb(accumulator, el);
    })
  }
  return accumulator;
}