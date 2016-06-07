typedef CoinData = {
    collected:Bool,
}

class Coin extends defold.support.Script<CoinData> {
    override function init(data:CoinData) {
        data.collected = false;
    }

    override function on_message<T>(data:CoinData, message_id:Message<T>, message:T, sender:Url):Void {
        switch (message_id) {
            case DefoldMessages.CollisionResponse if (!data.collected):
                data.collected = true;
                Msg.post("#sprite", DefoldMessages.Disable);
            case Messages.StartAnimation:
                var pos = Go.get_position();
                Go.animate(Go.get_id(), "position.y", PLAYBACK_LOOP_PINGPONG, pos.y + 24, GoEasing.EASING_INOUTSINE, 0.75, message.delay);
        }
    }
}
