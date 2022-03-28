Array.prototype.uniq = function () {
  const uniqs = [];

  this.forEach(el => {
    if (!uniqs.includes(el)) {
      uniqs.push(el);
    }
  });

  return uniqs;
}

Array.prototype.twosum = function () {
  const pairs = [];
  const that = this;

  for (let i = 0; i < that.length; i++) {
    const num1 = that[i];

    for (let j = i+1; j < that.length; j++) {
      const num2 = that[j];
      
      if (num1 + num2 === 0) {
        pairs.push([i, j]);
      }
    } 
  }
  return pairs;
}

Array.prototype.transpose = function () {
  const transposed = [];
  const total_cols = this[0].length;
  const total_rows = this.length;
  const that = this;

  for (let col = 0; col < total_cols; col++) {
    const new_row = [];
    
    for (let row = 0; row < total_rows; row++) {
      const el = that[row][col];
      new_row.push(el);
    }

    transposed.push(new_row);
  }

  return transposed;
}