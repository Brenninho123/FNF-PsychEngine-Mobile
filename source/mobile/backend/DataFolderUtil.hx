package mobile.backend;

#if android
import lime.system.JNI;
#end

class DataFolderUtil
{
	#if android
	static var _getDataFolder:Void->String = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getDataFolder", "()Ljava/lang/String;");
	#end

	public static function getDataFolder():String
	{
		#if android
		return _getDataFolder();
		#else
		return "";
		#end
	}
}
