# Define Simulator
set ns [new Simulator]

# Trace files
set tracefile [open out.tr w]
$ns trace-all $tracefile

# Define nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# Define links (will vary bandwidth later)
proc create_links {ns bw queue_limit} {
    $ns duplex-link $::n0 $::n1 $bw 10ms DropTail
    $ns duplex-link $::n1 $::n2 $bw 10ms DropTail
    $ns duplex-link $::n2 $::n3 $bw 10ms DropTail
    $ns queue-limit $::n1 $::n2 $queue_limit
}

# Create traffic
proc generate_traffic {} {
    set udp [new Agent/UDP]
    set null [new Agent/Null]
    $::ns attach-agent $::n0 $udp
    $::ns attach-agent $::n3 $null
    $::ns connect $udp $null

    set cbr [new Application/Traffic/CBR]
    $cbr set packetSize_ 500
    $cbr set interval_ 0.005
    $cbr attach-agent $udp
    $::ns at 0.5 "$cbr start"
    $::ns at 4.5 "$cbr stop"
}

# Main simulation
proc run_simulation {bw} {
    global ns tracefile
    $ns flush-trace
    create_links $ns $bw 10
    generate_traffic
    $ns at 5.0 "finish"
    $ns run
}

proc finish {} {
    global tracefile
    close $tracefile
    exit 0
}

# Example run
run_simulation [lindex $argv 0]
