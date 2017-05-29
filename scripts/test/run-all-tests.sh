#!/bin/bash

function abort() {
    echo "Error: $1"
    exit 1;
}


# mapic/engine tests
bash run-engine-tests.sh || abort "Engine tests failed."

# mapic/mile tests
bash run-mile-tests.sh || abort "Mile tests failed."

# mapic/mapic.js tests
bash run-mapicjs-tests.sh || abort "Mapic.js tests failed."