
* What is this?

This is a framework for futures trading on Raiden network.

2 addresses are created, one for long position and one for short. If the user pays to both addresses, the difference is returned. The value of funds belonging to the user changes with 10:1 leverage with respect to the change of the price of the underlying asset. If the user loses all the funds, his position is closed (this is known as "margin call").

The first version will use USD/ETH pair.

The price is determined using Tellor oracle. Also, Tellor is used for ensuring exchange honesty. The exchange will need to hold a stake in the contract, that will be released only if it executes the transactions honestly, based on published transfer proofs.

The node will earn income from transaction fees (spread) and from Raiden network proxy transactions.

* Installation

Start from running `boot.sh`. This will install all required dependencies. You may try to satisfy the dependencies manually if you wish.

Then run `build.sh`. This will compile all the generated code. The resulting tree will be installed under the directory `./root`.

Finally, change directory to `root` and run `../start.sh`. This will start the service.
