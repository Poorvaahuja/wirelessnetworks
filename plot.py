import os
import matplotlib.pyplot as plt

def parse_trace(filename):
    dropped = 0
    with open(filename) as f:
        for line in f:
            if line.startswith('d'):  # 'd' stands for dropped
                dropped += 1
    return dropped

bandwidths = ['0.5Mb', '1Mb', '2Mb', '5Mb']
drops = []

for bw in bandwidths:
    # Run simulation
    os.system(f"ns simulation.tcl {bw}")
    drops.append(parse_trace("out.tr"))

# Plotting
plt.plot(bandwidths, drops, marker='o')
plt.xlabel("Bandwidth")
plt.ylabel("Packets Dropped")
plt.title("Performance: Bandwidth vs Packet Drops")
plt.grid(True)
plt.savefig("result.png")
plt.show()
