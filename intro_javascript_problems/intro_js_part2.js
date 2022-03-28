function printCallback(arr) {
  arr.forEach(el => {console.log(el)});
}

function titleize(names, cb) {
  let titleizedNames = names.map(name => {
    return `Mx. ${name} J. Schimdt`
  });

  cb(titleizedNames);
}

// titleize(["Mary", "Brian", "Leo"], printCallback)
// printCallback(["Mary", "Brian", "Leo"])

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function() {
  console.log(this.name + " the elephant goes 'phRRRRR!!!!!");
}

Elephant.prototype.grow = function() {
  this.height += 12;
}

Elephant.prototype.addTrick = function(trick) {
  this.tricks.push(trick);
}

Elephant.prototype.play = function() {
  const that = this
  let idx = function() {
    const maxIdx = that.tricks.length - 1;
    const minIdx = 0;
    const idx = Math.floor(Math.random() * (maxIdx - minIdx + 1)) + minIdx;
    return idx;
  };
  const trick = this.tricks[idx()];
  console.log(`${this.name} is ${trick}`);
}

// let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);

// console.log(ellie.name);
// console.log(ellie.height);
// console.log(ellie.tricks);
// ellie.trumpet();

// console.log(ellie.height);
// ellie.grow(12);
// console.log(ellie.height);

// console.log(ellie.tricks);
// ellie.addTrick("playing football");
// console.log(ellie.tricks);

// ellie.play()

// PHASE III

Elephant.paradeHelper = function(elpht) {
  console.log(elpht.name + " is trotting by");
}

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

// Elephant.paradeHelper(micah)

let herd = [ellie, charlie, kate, micah];

// herd.forEach(Elephant.paradeHelper);

// PHASE IV

function dinerBreakfast() {
  let order = "I'd like cheesy scrambled eggs please";

  let addFood = function(food) {
    order = order.split(" ").slice(0,-1).join(" ") + ` and ${food} please`;
    console.log(`${order}`);
  };

  return addFood;
}