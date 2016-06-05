package defold.support;

#if macro
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
using haxe.macro.Tools;

class ScriptMacro {
    static function use() {
        Context.onGenerate(function(types) {
            var out = Compiler.getOutput();
            var outDir = Path.directory(out) + "/scripts";
            var relPath = "../" + Path.withoutDirectory(out);
            deleteRec(outDir);
            sys.FileSystem.createDirectory(outDir);
            for (type in types) {
                switch (type) {
                    case TInst(_.get() => cl = {superClass: {t: _.get() => {pack: ["defold","support"], name: "Script"}, params: [tData]}}, _):
                        var props = getProperties(tData, cl.pos);
                        var name = cl.name;
                        cl.meta.add(":expose", [], cl.pos);
                        var b = new StringBuf();
                        b.add('-- Generated by Haxe, DO NOT EDIT (original source: ${cl.pos})\n');
                        b.add('require "haxe.out.main"\n\n');
                        if (props.length > 0) {
                            for (prop in props)
                                b.add('go.property("${prop.name}", ${prop.value})\n');
                            b.add("\n");
                        }
                        b.add('local comp = $name.new()

function init(self)
    comp:init(self)
end

function update(self, dt)
    comp:update(self, dt)
end

function final(self)
    comp:final(self)
end

function on_input(self, action_id, action)
    comp:on_input(self, action_id, action)
end

function on_message(self, message_id, message, sender)
    comp:on_message(self, message_id, message, sender)
end
                        ');
                        sys.io.File.saveContent('$outDir/$name.script', b.toString());
                    default:
                }
            }
        });
    }

    static function deleteRec(path:String) {
        if (sys.FileSystem.isDirectory(path)) {
            for (file in sys.FileSystem.readDirectory(path))
                deleteRec('$path/$file');
            sys.FileSystem.deleteDirectory(path);
        } else {
            sys.FileSystem.deleteFile(path);
        }
    }

    static function getProperties(type:Type, pos:Position):Array<{name:String, value:String}> {
        var result = [];
        switch (type.follow()) {
            case TAnonymous(_.get() => anon):
                for (field in anon.fields) {
                    var prop = field.meta.extract("property");
                    switch (prop) {
                        case []:
                            continue;
                        case [prop]:
                            switch (prop.params) {
                                case [{expr: EConst(CInt(s) | CFloat(s))}]:
                                    result.push({name: field.name, value: s});
                                default:
                                    throw new Error("Invalid @property params", prop.pos);
                            }
                        default:
                            throw new Error("Only single @property metadata is allowed", field.pos);
                    }
                }
            default:
                throw new Error('Invalid component data type: ${type.toString()}. Should be a structure.', pos);
        }
        return result;
    }
}
#end