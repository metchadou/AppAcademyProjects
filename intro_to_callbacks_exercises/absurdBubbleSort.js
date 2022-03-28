const readline = require( "readline" );

const reader = readline.createInterface( {
  input: process.stdin,
  output: process.stdout
} )

function askIfGreaterThan( el1, el2, cb ) {
  reader.question( `Is ${el1} greater than ${el2} ?\n`, function (res) {
    ( res === "yes" ) ? cb( true ) : cb( false );
  } )
}

function innerBubbleSortLoop( arr, i, madeAnySwaps, outerBubbleSortLoop ) {
  if ( i === ( arr.length - 1 ) ) {
    outerBubbleSortLoop( madeAnySwaps );
  } else {
    askIfGreaterThan( arr[ i ], arr[ i + 1 ], ( isGreaterThan ) => {
      if ( isGreaterThan ) {
        [ arr[ i ], arr[ i + 1 ] ] = [ arr[ i + 1 ], arr[ i ] ];
        madeAnySwaps = true;
      }

      innerBubbleSortLoop( arr, i + 1, madeAnySwaps, outerBubbleSortLoop )
    } )
  }
}

function absurdBubbleSort( arr, sortCompletionCb ) {
  function outerBubbleSortLoop( madeAnySwaps ) {
    if ( madeAnySwaps ) {
      innerBubbleSortLoop( arr, 0, false, outerBubbleSortLoop );
    } else {
      sortCompletionCb( arr );
    }
  }

  outerBubbleSortLoop( true );
}

absurdBubbleSort( [ 5, 4, 1, 3 ], ( arr ) => {
  console.log( "Sorted array: " + JSON.stringify( arr ) );
  reader.close();
} )

// innerBubbleSortLoop( [ 5, 4, 1, 3 ], 0, false, 
//   ( madeAnySwaps ) => {
//     console.log( "In outer bubble sort" );
//     reader.close();
//   } );

// askIfGreaterThan( 3, 5, ( ans ) => {
//   ans ? console.log("true") : console.log("false");
//   reader.close();
// } );