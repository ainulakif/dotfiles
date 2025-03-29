
<?php

function add($a, $b) {
    // Option 1: Set a breakpoint here manually in your editor.
    // Option 2: Uncomment the next line to force a breakpoint with Xdebug.
    // xdebug_break();
    $result = $a + $b; // Try setting your breakpoint on this line.
    return $result;
}

function main() {
    $x = 10;
    $y = 20;
    $total = add($x, $y);
    echo "Result is: " . $total . "\n";
}

main();

