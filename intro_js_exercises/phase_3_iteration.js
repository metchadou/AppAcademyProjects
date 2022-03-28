Array.prototype.bubbleSort = function() {
  let sorted = false;

  while (!sorted) {
    sorted = true;

    for (let i = 0; i < (this.length - 1); i++) {
      let current_num = this[i];
      let next_num = this[i+1];
      
      if (current_num > next_num) {
        this[i] = next_num;
        this[i+1] = current_num;
        sorted = false;
      }
    }
  }
  return this;
}

String.prototype.substrings = function () {
  const substrings = [];

  for (let i = 0; i < this.length; i++) {
    substrings.push(this[i]);

    for (let j = (i+1); j < this.length; j++) {
      substrings.push(this.slice(i,j+1));
    }
  }

  return substrings;
}