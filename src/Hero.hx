import defold.support.Script;

typedef HeroData = {
    position:Vector3,
    velocity:Vector3,
    ground_contact:Bool,
    correction:Vector3,
    anim:Hash,
}

class Hero extends Script<HeroData> {
    // gravity pulling the player down in pixel units/sˆ2
    var gravity = -20;

    // take-off speed when jumping in pixel units/s
    var jump_takeoff_speed = 900;

    override function init(data:HeroData) {
        // this tells the engine to send input to on_input() in this script
        Msg.post(".", GoMessages.AcquireInputFocus);

        // save the starting position
        data.position = Go.get_position();

        Msg.post("#", Messages.Reset);
    }

    override function final(_) {
        // Return input focus when the object is deleted
        Msg.post(".", GoMessages.ReleaseInputFocus);
    }

    override function update(data:HeroData, dt) {
        var gravity = Vmath.vector3(0, gravity, 0);

        if (!data.ground_contact)
            // Apply gravity if there's no ground contact
            data.velocity += gravity;

        // apply velocity to the player character
        Go.set_position(Go.get_position() + data.velocity * dt);

        update_animation(data);

        // reset volatile state
        data.correction = Vmath.vector3();
        data.ground_contact = false;
    }

    function play_animation(data:HeroData, anim:Hash) {
        if (data.anim != anim) {
            Spine.play("#spinemodel", anim, PLAYBACK_LOOP_FORWARD, 0.15);
            data.anim = anim;
        }
    }

    function update_animation(data:HeroData) {
        if (data.ground_contact)
            play_animation(data, hash("run_right"));
        else if (data.velocity.y > 0)
            play_animation(data, hash("jump_right"));
        else
            play_animation(data, hash("fall_right"));
    }

    function handle_geometry_contact(data:HeroData, normal:Vector3, distance:Float) {
        // project the correction vector onto the contact normal
        // (the correction vector is the 0-vector for the first contact point)
        var proj = Vmath.dot(data.correction, normal);
        // calculate the compensation we need to make for this contact point
        var comp = (distance - proj) * normal;
        // add it to the correction vector
        data.correction = data.correction + comp;
        // apply the compensation to the player character
        Go.set_position(Go.get_position() + comp);
        // check if the normal points enough up to consider the player standing on the ground
        // (0.7 is roughly equal to 45 degrees deviation from pure vertical direction)
        if (normal.y > 0.7)
            data.ground_contact = true;
        // project the velocity onto the normal
        proj = Vmath.dot(data.velocity, normal);
        // if the projection is negative, it means that some of the velocity points towards the contact point
        if (proj < 0)
            // remove that component in that case
            data.velocity = data.velocity - normal * proj;
    }

    override function on_message<T>(data:HeroData, message_id:Message<T>, message:T, sender:Url) {
        switch (message_id) {
            case Messages.Reset:
                data.velocity = Vmath.vector3(0, 0, 0);
                data.correction = Vmath.vector3();
                data.ground_contact = false;
                data.anim = null;
                Go.set(".", "euler.z", 0);
                Go.set_position(data.position);
                Msg.post("#collisionobject", GoMessages.Enable);
            case PhysicsMessages.ContactPointResponse:
                // check if we received a contact point message. One message for each contact point
                if (message.group == hash("danger")) {
                    play_animation(data, hash("die_right"));
                    Msg.post("#collisionobject", GoMessages.Disable);
                    Go.animate(".", "euler.z", PLAYBACK_ONCE_FORWARD, 160, GoEasing.EASING_LINEAR, 0.7);
                    Go.animate(".", "position.y", PLAYBACK_ONCE_FORWARD, Go.get_position().y - 200, GoEasing.EASING_INSINE, 0.5, 0.2,
                               function() Msg.post("controller#script", Messages.Reset));
                } else if (message.group == hash("geometry")) {
                    handle_geometry_contact(data, message.normal, message.distance);
                }
        }
    }

    override function on_input(data:HeroData, action_id:Hash, action:ScriptOnInputAction) {
        if (action_id == hash("jump") || action_id == hash("touch")) {
            if (action.pressed)
                jump(data);
            else if (action.released)
                abort_jump(data);
        }
        return false;
    }

    function jump(data:HeroData) {
        // only allow jump from ground
        if (data.ground_contact)
            // set take-off speed
            data.velocity.y = jump_takeoff_speed;
    }

    function abort_jump(data:HeroData) {
        // cut the jump short if we are still going up
        if (data.velocity.y > 0)
            // scale down the upwards speed
            data.velocity.y = data.velocity.y * 0.5;
    }
}
