package simu5g.simulations.cicddos2019;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.Upf;
import simu5g.nodes.backgroundCell.BackgroundCell;
import simu5g.world.radio.LteChannelControl;


network Network5G
{
    parameters:
        int numnode = default(0);
        int numBgCells = default(0);
        @display("bgb=5000,5000,white;bgi=background/pisa,c");
    submodules:
        channelControl: LteChannelControl {
            @display("p=230.34999,340.918;is=vs;t=,l");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=230.34999,737.12;is=vs;t=,l");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=230.34999,1188.606;is=vs;t=,l");
        }
        binder: Binder {
            @display("p=239.564,1769.088;is=vs;t=,l");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=175.066,2285.072;is=vs;t=,l");
        }
        server: StandardHost {
            @display("p=3753,1331.064;is=vs;i=device/server");
        }
        router: Router {
            @display("p=3152.52,1331.064;i=device/smallrouter;is=vs");
        }
        upf: Upf {
            @display("p=2491.992,1331.064;is=vs");
        }
        gnb1: gNodeB {
            @display("p=2491.992,1861.488;is=l;i2=status/execute");
        }
        bgCell[numBgCells]: BackgroundCell {
            @display("p=1142.536,3086.69;is=l");
        }
        iot_device[numnode]: NRUe {
            @display("p=1547.952,1078.038;is=s;r=750,#DBFF00,,0;i=misc/sensor3");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> upf.filterGate;
        upf.pppg++ <--> Eth10G <--> gnb1.ppp;
}
