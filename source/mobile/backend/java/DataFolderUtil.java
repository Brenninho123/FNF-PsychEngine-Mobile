package mobile.backend.java;

import org.haxe.extension.Extension;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.support.v4.content.FileProvider;

import java.io.File;

public class DataFolderUtil
{
	public static String getDataFolder()
	{
		File dir = Extension.mainContext.getExternalFilesDir(null);
		if (dir == null)
			dir = Extension.mainContext.getFilesDir();
		ensureExists(dir);
		return dir.getAbsolutePath();
	}

	public static String getInternalDataFolder()
	{
		File dir = Extension.mainContext.getFilesDir();
		ensureExists(dir);
		return dir.getAbsolutePath();
	}

	public static String getCacheFolder()
	{
		File dir = Extension.mainContext.getExternalCacheDir();
		if (dir == null)
			dir = Extension.mainContext.getCacheDir();
		ensureExists(dir);
		return dir.getAbsolutePath();
	}

	public static String getModsFolder()
	{
		File dir = new File(getDataFolder(), "mods");
		ensureExists(dir);
		return dir.getAbsolutePath();
	}

	public static boolean isExternalStorageWritable()
	{
		return Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState());
	}

	public static long getFreeSpaceMB()
	{
		StatFs stat = new StatFs(getDataFolder());
		return (stat.getBlockSizeLong() * stat.getAvailableBlocksLong()) / (1024 * 1024);
	}

	public static long getTotalSpaceMB()
	{
		StatFs stat = new StatFs(getDataFolder());
		return (stat.getBlockSizeLong() * stat.getBlockCountLong()) / (1024 * 1024);
	}

	public static boolean deleteRecursive(String path)
	{
		return deleteRecursive(new File(path));
	}

	private static boolean deleteRecursive(File file)
	{
		if (file == null || !file.exists())
			return false;

		if (file.isDirectory())
		{
			File[] children = file.listFiles();
			if (children != null)
				for (File child : children)
					deleteRecursive(child);
		}
		return file.delete();
	}

	private static void ensureExists(File dir)
	{
		if (dir != null && !dir.exists())
			dir.mkdirs();
	}

	public static void openDataFolder()
	{
		openFolder(getDataFolder());
	}

	public static void openModsFolder()
	{
		openFolder(getModsFolder());
	}

	private static void openFolder(String path)
	{
		try
		{
			File dir = new File(path);
			ensureExists(dir);

			Uri uri;
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
			{
				String authority = Extension.mainContext.getPackageName() + ".fileprovider";
				uri = FileProvider.getUriForFile(Extension.mainContext, authority, dir);
			}
			else
			{
				uri = Uri.fromFile(dir);
			}

			Intent intent = new Intent(Intent.ACTION_VIEW);
			intent.setDataAndType(uri, "resource/folder");
			intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
				intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

			if (intent.resolveActivityInfo(Extension.mainContext.getPackageManager(), 0) != null)
			{
				Extension.mainContext.startActivity(intent);
				return;
			}

			Intent chooser = new Intent(Intent.ACTION_VIEW);
			chooser.setDataAndType(uri, "*/*");
			chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
				chooser.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

			Extension.mainContext.startActivity(Intent.createChooser(chooser, "Open folder with"));
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
