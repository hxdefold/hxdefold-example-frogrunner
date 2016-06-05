typedef LevelData = {
    @property(6) var speed:Float;
    var gridw:Float;
    var spawns:lua.Table<Int,Hash>;
}

class Controller extends Script<LevelData> {
    static var grid = 460;
    static var platform_heights = [100, 200, 350];
    static var coins = 3;

    override function init(data:LevelData) {
        Msg.post("ground/controller#script", Messages.SetSpeed, {speed: data.speed});
        data.gridw = 0;
        data.spawns = lua.Table.create();
    }

    override function update(data:LevelData, dt:Float) {
        data.gridw += data.speed;

        if (data.gridw >= grid) {
            data.gridw = 0;

            if (Math.random() > 0.2) {
                var h = platform_heights[Std.random(platform_heights.length)];
                var f = "#platform_factory";
                var coins = coins;
                if (Math.random() > 0.5) {
                    f = "#platform_long_factory";
                    coins *= 2; // Twice the number of coins on long platforms
                }
                var p = Factory.create(f, Vmath.vector3(1600, h, 0), null, lua.Table.create(), 0.6);
                Msg.post(p, Messages.SetSpeed, {speed: data.speed});
                Msg.post(p, Platform.CreateCoinsMessage, {coins: coins});
                lua.Table.insert(data.spawns, p);
            }
        }
    }

    override function on_message<T>(data:LevelData, message_id:Message<T>, message:T, sender:Url) {
        switch (message_id) {
            case Messages.Reset:
                Msg.post("hero#script", Messages.Reset);
                lua.PairTools.ipairsEach(data.spawns, function(i, p) Go.delete(p));
                data.spawns = lua.Table.create();
            case Messages.DeleteSpawn:
                lua.PairTools.ipairsEach(data.spawns, function(i, p) {
                    if (p == message.id) {
                        lua.Table.remove(data.spawns, i);
                        Go.delete(p);
                    }
                });
        }
    }
}
