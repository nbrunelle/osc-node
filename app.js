var osc = require("osc"),
    cmd = require('node-cmd'),
    Omx = require('node-omxplayer'),
    omxplayer = Omx();

/****************
 * OSC Over UDP *
 ****************/

var getIPAddresses = function () {
    var os = require("os"),
        interfaces = os.networkInterfaces(),
        ipAddresses = [];

    for (var deviceName in interfaces) {
        var addresses = interfaces[deviceName];
        for (var i = 0; i < addresses.length; i++) {
            var addressInfo = addresses[i];
            if (addressInfo.family === "IPv4" && !addressInfo.internal) {
                ipAddresses.push(addressInfo.address);
            }
        }
    }

    return ipAddresses;
};

var udpPort = new osc.UDPPort({
    localAddress: "0.0.0.0",
    localPort: 9998
});

udpPort.on("ready", function () {
    var ipAddresses = getIPAddresses();

    console.log("Listening for OSC over UDP.");
    ipAddresses.forEach(function (address) {
        console.log(" Host:", address + ", Port:", udpPort.options.localPort);
    });

    // Make the screen blank
    // Disable in order to see the console for updates
    // cmd.run('/opt/vc/bin/tvservice -p');
});

udpPort.on("message", function (oscMessage) {
    if(oscMessage.address == '/play') {
        omxplayer.newSource(oscMessage.args[0], 'hdmi', false, 100);
    }

    if(oscMessage.address == '/loop') {
        omxplayer.newSource(oscMessage.args[0], 'hdmi', true, 100);
    }

    if(oscMessage.address == '/prev' && omxplayer.running) {
        omxplayer.back30();
    }

    if(oscMessage.address == '/pause' && omxplayer.running) {
        omxplayer.pause();
    }

    if(oscMessage.address == '/stop' && omxplayer.running) {
        omxplayer.quit();
    }

    if(oscMessage.address == '/cmd') {
        cmd.run(oscMessage.args[0]);
    }
});

udpPort.on("error", function (err) {
    console.log(err);
});

udpPort.open();
