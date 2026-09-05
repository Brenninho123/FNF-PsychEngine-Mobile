package mobile.backend.java;

import org.haxe.extension.Extension;

public class DataFolderUtil
{
	public static String getDataFolder()
	{
		return Extension.mainContext.getExternalFilesDir(null).getAbsolutePath();
	}
}
