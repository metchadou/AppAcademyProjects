function sumOfNPrimes(n) {
  if (n === 0) {
    return 0;
  }
  
  function isPrime(number) {
    if(number < 2) {
      return false;
    }
  
    for (let i = number - 1; i > 1; i--) {
      if (number % i === 0) {
        return false;
      }
    }
  
    return true;
  }

  function firstNPrimes(){
    let primes = [];

    for (let i = 0; primes.length < n; i++) {
      if (isPrime(i)) {
        primes.push(i)
      }
    }

    return primes;
  }

  let sum = 0;
  let primes = firstNPrimes();

  primes.forEach(num => {
    sum += num
  });

  return sum;
}

function fizzBuzz(array) {
  let arr = [];
  
  array.forEach(el => {
    if ((el % 3 === 0 || el % 5 === 0) && !(el % 3 === 0 && el % 5 === 0)) {
      arr.push(el)
    }
  });

  return arr;
}

function isSubstring(searchString, subString) {
  return searchString.includes(subString);
}

function madLib(verb, adjective, noun) {
  let sentence = `We shall ${verb} the ${adjective + ' ' + noun}`;
  console.log(sentence);
}

function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  };
  console.log(x);
}


function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block';
    console.log(x);
  };
  console.log(x);
}

function mysteryScoping3() {
  const x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  };
  console.log(x);
}

function mysteryScoping4() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  };
  console.log(x);
}

function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  };
  let x = 'out of block again';
  console.log(x);
}