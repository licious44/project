package ddosDetection;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.physicallayer.contract.packetlevel.IRadioMedium;
import inet.visualizer.integrated.IntegratedVisualizer;

network Simulation
{
    @display("bgb=700,400");
    types:
        channel Channel extends ned.DelayChannel
        {
            delay = 0.001us;
        }

    submodules:
        visualizer: IntegratedVisualizer {
            @display("p=200,50;i=block/app");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=200,100;i=block/app");
        }
        radioMedium: <default("IdealRadioMedium")> like IRadioMedium {
            @display("p=200,150;i=abstract/radio");
        }
        node[n]: Node {
            @display("p=100,300");
        }

    connections allowunconnected:
        for i=0..n-1, for j=0..n-1, i!=j {
            Channel --> { @display("m=s"); } --> Channel if j==i+1;
            node[i].radio --> Channel --> node[j].radio;
        }
}
