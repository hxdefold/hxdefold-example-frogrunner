class Messages {
    public static var Enable(default,never) = new Message<Void>("enable");
    public static var Disable(default,never) = new Message<Void>("disable");
    public static var CollisionResponse(default,never) = new Message<{}>("collision_response");
    public static var StartAnimation(default,never) = new Message<{delay:Float}>("start_animation");
    public static var Reset(default,never) = new Message<Void>("reset");
    public static var DeleteSpawn(default,never) = new Message<{id:Hash}>("delete_spawn");
    public static var SetSpeed(default,never) = new Message<{speed:Float}>("set_speed");
    public static var ContactPointResponse(default,never) = new Message<ContactPointResponseData>("contact_point_response");
    public static var AcquireInputFocus(default,never) = new Message<Void>("acquire_input_focus");
    public static var ReleaseInputFocus(default,never) = new Message<Void>("release_input_focus");
    public static var SetParent(default,never) = new Message<{parent_id:Hash}>("set_parent");
}

typedef ContactPointResponseData = {
    position:Vector3,
    normal:Vector3,
    relative_velocity:Vector3,
    distance:Float,
    applied_impulse:Float,
    life_time:Float,
    mass:Float,
    other_mass:Float,
    other_id:Hash,
    other_position:Vector3,
    group:Hash,
}
