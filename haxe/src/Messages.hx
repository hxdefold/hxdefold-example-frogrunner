@:publicFields
class Messages {
    static var Exit(default,never) = new Message<{code:Int}>("exit");
    static var Reboot(default,never) = new Message<RebootData>("reboot");
    static var SetUpdateFrequency(default,never) = new Message<{frequency:Int}>("set_update_frequency");
    static var StartRecord(default,never) = new Message<StartRecordData>("start_record");
    static var StopRecord(default,never) = new Message<Void>("stop_record");
    static var ToggleProfile(default,never) = new Message<Void>("toggle_profile");

    static var Enable(default,never) = new Message<Void>("enable");
    static var Disable(default,never) = new Message<Void>("disable");
    static var CollisionResponse(default,never) = new Message<{}>("collision_response");
    static var StartAnimation(default,never) = new Message<{delay:Float}>("start_animation");
    static var Reset(default,never) = new Message<Void>("reset");
    static var DeleteSpawn(default,never) = new Message<{id:Hash}>("delete_spawn");
    static var SetSpeed(default,never) = new Message<{speed:Float}>("set_speed");
    static var ContactPointResponse(default,never) = new Message<ContactPointResponseData>("contact_point_response");
    static var AcquireInputFocus(default,never) = new Message<Void>("acquire_input_focus");
    static var ReleaseInputFocus(default,never) = new Message<Void>("release_input_focus");
    static var SetParent(default,never) = new Message<{parent_id:Hash}>("set_parent");
}

typedef RebootData = {
    ?arg1:String,
    ?arg2:String,
    ?arg3:String,
    ?arg4:String,
    ?arg5:String,
    ?arg6:String,
}

typedef StartRecordData = {
    file_name:String,
    ?frame_period:Int,
    ?fps:Int,
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
