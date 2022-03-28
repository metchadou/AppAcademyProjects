Function.prototype.myThrottle = function (interval) {
  let tooSoon = false;

  return (...args) => {
    if (!tooSoon) {
      tooSoon = false;
      setTimeout(() => tooSoon = false, interval);
      this(...args);
    }
  }
}

class Neuron {
  fire() {
    console.log("Firing!");
  }
}

// const neuron = new Neuron();

// const interval = setInterval(() => {
//   neuron.fire();
// }, 10);

// clearInterval(interval);

// neuron.fire = neuron.fire.myThrottle(500);

// const interval = setInterval(() => {
//   neuron.fire();
// }, 10);

Function.prototype.myDebounce = function( interval ) {
  let timeoutId;

  return ( ...args ) => {
    if ( timeoutId ) {
      clearTimeout( timeoutId );
    }

    timeoutId = setTimeout(() => this( ...args ), interval);
  }
}

class SearchBar {
  constructor() {
    this.query = "";

    this.type = this.type.bind(this);
    this.search = this.search.bind(this);
  }

  type(letter) {
    this.query += letter;
    this.search();
  }

  search() {
    console.log(`searching for ${this.query}`);
  }
}

const searchBar = new SearchBar();

const queryForHelloWorld = () => {
  searchBar.type("h");
  searchBar.type("e");
  searchBar.type("l");
  searchBar.type("l");
  searchBar.type("o");
  searchBar.type(" ");
  searchBar.type("w");
  searchBar.type("o");
  searchBar.type("r");
  searchBar.type("l");
  searchBar.type("d");
};

searchBar.search = searchBar.search.myDebounce(2000);

queryForHelloWorld();