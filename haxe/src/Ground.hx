typedef GroundData = {
    speed:Float,
}

class Ground extends defold.support.Script<GroundData> {
    static var pieces = ["ground0", "ground1", "ground2", "ground3", "ground4", "ground5", "ground6"];

    override function init(data:GroundData) {
        data.speed = 6;
    }

    override function update(data:GroundData, dt:Float) {
        for (p in pieces) {
            var pos = Go.get_position(p);
            if (pos.x <= -228)
                pos.x = 1368 + (pos.x + 228);
            pos.x = pos.x - data.speed;
            Go.set_position(pos, p);
        }
    }

    override function on_message<T>(data:GroundData, message_id:Message<T>, message:T, sender:Url) {
        switch (message_id) {
            case Messages.SetSpeed:
                data.speed = message.speed;
        }
    }
}
