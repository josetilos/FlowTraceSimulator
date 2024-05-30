# Flow trace simulator
# Jose Alberto Hernandez for EU SNS SEASON project
# 30th May 2024


library(sads)


## Input parameters: 

LinkCapacity = 100 # 10 Gbps
Load = 0.4 # 40% load

# Packet characteristics
PacketSizeDistribution = c(64,596,1500) # Trimodal distribution, packet size (bytes)
PacketSizeWeights = c(4/12,2/12,6/12) # Trimodal distribution, packet weigths (percentage)

AvgPacketSize = sum(8*PacketSizeDistribution*PacketSizeWeights) # 870 Bytes, matches Poland University
AvgServiceTime = AvgPacketSize/(LinkCapacity*1e9) # EX from queueing theory


# Flow characteristics 
# AvgFlowSize = 68410 Bytes or 78.5 packets (as it follows from Poland University trace)
Nflows = 7000 # configurable, 7000 flow IDs
alpha = 1.1 # zipf alpha distribution, top-20 flows comprises 49% of traffic





Npackets = round(Nflows*78.5)


PDF <- dzipf(x=c(1:Nflows), N=Nflows, s=alpha)
CDF <- pzipf(q=c(1:Nflows), N=Nflows, s=alpha)


# We generate a trace of duration: Window
# For example: for a 0.1 ms trace on a link operating at 100G with 40% load, the total traffic should be 4Gbit total

Window = 0.1 # 100 ms of trace

Nbits = Load*(LinkCapacity*1e9)*Window
Npackets = round(Nbits/AvgPacketSize)

lambda = Load/AvgServiceTime # M/G/1 assumed

simArrivals = cumsum(rexp(1.5*Npackets,rate=lambda))
simArrivals = simArrivals[which(simArrivals<Window)]

simflowIDs = sample(c(1:Nflows), size = length(simArrivals), prob=PDF, replace=TRUE)
simPacketsize = sample(PacketSizeDistribution, size = length(simArrivals), prob=PacketSizeWeights,replace=TRUE)


simulationTrace.df = data.frame(arrival = simArrivals,
                                flowID = simflowIDs,
                                packetsizeBytes = simPacketsize)
colnames(simulationTrace.df) = c("ArrivalTime","FlowID","PacketSize")


write.csv(simulationTrace.df, "Trace100G.csv", row.names=TRUE)



















