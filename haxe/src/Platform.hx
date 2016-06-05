typedef PlatformData = {
    speed:Float,
    coins:lua.Table<Int,Hash>,
}

class Platform extends Script<PlatformData> {
    override function init(data:PlatformData) {
        data.speed = 9; // Default speed
        data.coins = lua.Table.create();
    }

    override function final(data:PlatformData) {
        lua.PairTools.ipairsEach(data.coins, function(i,p) Go.delete(p));
    }

    override function update(data:PlatformData, dt:Float) {
        var pos = Go.get_position();
        if (pos.x < -500)
            Msg.post("/level/controller#script", Messages.DeleteSpawn, {id: Go.get_id()});
        pos.x = pos.x - data.speed;
        Go.set_position(pos);
    }

    public static var CreateCoinsMessage(default,never) = new Message<{coins:Int}>("create_coins");

    override function on_message<T>(data:PlatformData, message_id:Message<T>, message:T, sender:Url) {
        switch (message_id) {
            case Messages.SetSpeed:
                data.speed = message.speed;
            case CreateCoinsMessage:
                create_coins(data, message.coins);
        }
    }

    function create_coins(data:PlatformData, coins:Int) {
        var spacing = 56;
        var pos = Go.get_position();
        var x = pos.x - coins * (spacing * 0.5) - 24;
        for (i in 1...coins) {
            var coin = Factory.create("#coin_factory", Vmath.vector3(x + i * spacing , pos.y + 64, 1));
            Msg.post(coin, Messages.SetParent, { parent_id: Go.get_id() });
            Msg.post(coin, Messages.StartAnimation, { delay: i / 10 });
            lua.Table.insert(data.coins, coin);
        }
    }
}
