package mobile.backend;

#if android
import lime.system.JNI;
#end

class DataFolderUtil
{
	#if android
	static var _getDataFolder:Void->String = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getDataFolder", "()Ljava/lang/String;");
	static var _openDataFolder:Void->Void = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "openDataFolder", "()V");
	#end

	public static function getDataFolder():String
	{
		#if android
		return _getDataFolder();
		#else
		return "";
		#end
	}

	public static function openDataFolder():Void
	{
		#if android
		_openDataFolder();
		#end
	}
}
