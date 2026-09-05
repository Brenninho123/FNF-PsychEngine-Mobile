package mobile.backend.java;

import org.haxe.extension.Extension;

import android.content.Intent;
import android.net.Uri;

public class DataFolderUtil
{
	public static String getDataFolder()
	{
		return Extension.mainContext.getExternalFilesDir(null).getAbsolutePath();
	}

	public static void openDataFolder()
	{
		String path = Extension.mainContext.getExternalFilesDir(null).getAbsolutePath();
		Intent intent = new Intent(Intent.ACTION_VIEW);
		Uri uri = Uri.parse(path);
		intent.setDataAndType(uri, "resource/folder");
		intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

		if (intent.resolveActivityInfo(Extension.mainContext.getPackageManager(), 0) != null)
			Extension.mainContext.startActivity(intent);
	}
}
