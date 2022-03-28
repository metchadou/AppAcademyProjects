class Clock {
  constructor() {
    const date = new Date();
    [ this.hours, this.minutes, this.seconds ] = [ date.getHours(), date.getMinutes(), date.getSeconds() ];
    this.printTime();
    setInterval( this._tick.bind(this), 1000 );
  }

  printTime() {
    console.log( `${this.hours}:${this.minutes}:${this.seconds}` );
  }

  _tick() {
    if ( this.hours === 23 && 
          this.minutes === 59 &&
           this.seconds === 59 ) {
      [ this.hours, this.minutes, this.seconds ] = [ 0, 0, 0 ];
    }

    if ( this.minutes === 59 &&
          this.seconds === 59 ) {
      this.minutes = 0;
      this.hours += 1;
    }

    if (this.seconds === 59) {
      this.seconds = 0;
      this.minutes += 1;
    } else {
      this.seconds += 1;
    }

    this.printTime();
  }
}

let clock = new Clock();