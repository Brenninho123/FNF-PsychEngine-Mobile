package mobile.backend;

#if android
import lime.system.JNI;
#end

class DataFolderUtil
{
	#if android
	static var _getDataFolder:Void->String = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getDataFolder", "()Ljava/lang/String;");
	static var _getInternalDataFolder:Void->String = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getInternalDataFolder", "()Ljava/lang/String;");
	static var _getCacheFolder:Void->String = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getCacheFolder", "()Ljava/lang/String;");
	static var _getModsFolder:Void->String = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getModsFolder", "()Ljava/lang/String;");
	static var _isExternalStorageWritable:Void->Bool = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "isExternalStorageWritable", "()Z");
	static var _getFreeSpaceMB:Void->Float = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getFreeSpaceMB", "()J");
	static var _getTotalSpaceMB:Void->Float = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "getTotalSpaceMB", "()J");
	static var _deleteRecursive:String->Bool = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "deleteRecursive", "(Ljava/lang/String;)Z");
	static var _openDataFolder:Void->Void = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "openDataFolder", "()V");
	static var _openModsFolder:Void->Void = JNI.createStaticMethod("mobile.backend.java.DataFolderUtil", "openModsFolder", "()V");
	#end

	public static function getDataFolder():String
	{
		#if android
		return _getDataFolder();
		#else
		return "";
		#end
	}

	public static function getInternalDataFolder():String
	{
		#if android
		return _getInternalDataFolder();
		#else
		return "";
		#end
	}

	public static function getCacheFolder():String
	{
		#if android
		return _getCacheFolder();
		#else
		return "";
		#end
	}

	public static function getModsFolder():String
	{
		#if android
		return _getModsFolder();
		#else
		return "mods/";
		#end
	}

	public static function isExternalStorageWritable():Bool
	{
		#if android
		return _isExternalStorageWritable();
		#else
		return true;
		#end
	}

	public static function getFreeSpaceMB():Int
	{
		#if android
		return Std.int(_getFreeSpaceMB());
		#else
		return -1;
		#end
	}

	public static function getTotalSpaceMB():Int
	{
		#if android
		return Std.int(_getTotalSpaceMB());
		#else
		return -1;
		#end
	}

	public static function deleteRecursive(path:String):Bool
	{
		#if android
		return _deleteRecursive(path);
		#else
		return false;
		#end
	}

	public static function openDataFolder():Void
	{
		#if android
		_openDataFolder();
		#end
	}

	public static function openModsFolder():Void
	{
		#if android
		_openModsFolder();
		#end
	}
}
