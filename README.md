## Flow Trace Simulator README

### Overview
This R script simulates network flow traces based on given link capacity, load, and packet/flow characteristics. It generates a trace file that can be used for network analysis and research purposes. The script uses the `sads` package to model packet sizes and flow distributions and outputs the trace data to a CSV file.

### Prerequisites
The script requires the `sads` R package. If not installed, the script will automatically install it.

### Input Parameters
- **LinkCapacity**: The capacity of the link in bits per second (bps). In this script, it is set to `100e9` (100 Gbps).
- **Load**: The load on the link as a fraction of the total capacity. Here, it is set to `0.4` (40% load).

#### Packet Characteristics
- **PacketSizeDistribution**: A vector specifying the sizes of packets in bytes. The script uses a trimodal distribution with packet sizes of `64`, `596`, and `1500` bytes.
- **PacketSizeWeights**: The weights corresponding to the packet size distribution. The script uses weights of `4/12`, `2/12`, and `6/12`.

#### Flow Characteristics
- **Nflows**: The number of distinct flows. In this script, it is set to `1e4` (10,000 flows).
- **alpha**: The parameter for the Zipf distribution, controlling the skewness of the flow size distribution. It is set to `1.1`.

#### Trace Duration
- **Window**: The duration of the trace in seconds. The script is set to generate a trace for `0.1` seconds (100 ms).

### Output
- The script generates a CSV file named `Trace100G.csv` containing the simulated trace data. The columns in the CSV file are:
  - **ArrivalTime**: The arrival time of the packet.
  - **FlowID**: The flow ID to which the packet belongs.
  - **PacketSize**: The size of the packet in bytes.

### Detailed Explanation
1. **Initialization**:
   - Check and install the `sads` package if it is not already installed.
   - Load the `sads` library.

2. **Calculate Average Packet Size and Service Time**:
   - Compute the average packet size (`AvgPacketSize`) using the weighted average of the specified packet sizes.
   - Calculate the average service time (`AvgServiceTime`) based on the average packet size and link capacity.

3. **Flow and Packet Distributions**:
   - Define the number of packets based on the average number of packets per flow.
   - Compute the probability density function (PDF) and cumulative density function (CDF) for the flow sizes using the Zipf distribution.

4. **Traffic Calculation**:
   - Calculate the total number of bits to be transmitted based on the load and link capacity over the specified window.
   - Determine the total number of packets to be simulated (`Npackets`).

5. **Arrival Times and Packet Sizes**:
   - Generate packet arrival times using an exponential distribution with the calculated arrival rate (`lambda`).
   - Assign flow IDs to packets based on the Zipf distribution.
   - Assign packet sizes based on the specified packet size distribution.

6. **Generate Simulation Trace**:
   - Create a data frame with the arrival times, flow IDs, and packet sizes.
   - Write the data frame to a CSV file (`Trace100G.csv`).

### Usage
1. Ensure R is installed on your system.
2. Save the script to a file (e.g., `flow_trace_simulator.R`).
3. Run the script in R:
   ```R
   source("flow_trace_simulator.R")
   ```
4. The generated trace file `Trace100G.csv` will be created in the current working directory.

### Example CSV Output
```
"ArrivalTime","FlowID","PacketSize"
0.00000123,5,64
0.00000234,7,1500
0.00000345,3,596
...
```

### Notes
- Adjust the input parameters as needed to simulate different network conditions.
- Ensure that the `sads` package is installed and loaded properly to avoid errors during the simulation.
- The script assumes an M/G/1 queuing model for the arrival process.

### Contact
For any issues or questions regarding this script, please contact Jose Alberto Hernandez at the EU SNS SEASON project.

---

This README provides an overview of the flow trace simulator script, explaining its purpose, usage, and detailed steps involved in generating the network trace. Adjustments can be made to the parameters to simulate different network conditions as required.
