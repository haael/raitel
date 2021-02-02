

Start from running `boot.sh`. This will install all required dependencies. You may try to satisfy the dependencies manually if you wish.

Then run `build.sh`. This will compile all the generated code. The resulting tree will be installed under the directory `./root`.

Finally, change directory to `root` and run `start.sh`. This will start the service. The script will keep running until you kill it, and the service will stop.

Then you can access the interface under `http://localhost:5005/`.
