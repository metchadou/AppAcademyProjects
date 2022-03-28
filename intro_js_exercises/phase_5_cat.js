function Cat(name, owner) {
  this.name = name
  this.owner = owner
}

Cat.prototype.cuteStatement = function(){
  console.log(`Everyone loves ${this.name}`);
}

Cat.prototype.meow = function() {
  console.log('meowwwwww');
}