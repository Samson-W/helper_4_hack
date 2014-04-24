package com.example.listfile;

import java.io.File;   
import java.io.IOException;   

import android.app.Activity;   
import android.widget.TextView;
import android.os.Bundle;      
import android.os.Process;

public class MainActivity extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        int myProcessID = Process.myPid();
        File yygypath = this.getFilesDir();//this.getCacheDir();
        String yygypathstr = yygypath.toString();
        String hidename = "C966A01E";
        hidename = hidename + myProcessID;
        
        File file = new File(yygypath, hidename); 
        try {
			file.createNewFile();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        String result = ""; 
        File file11 = new File(yygypathstr);
        File[] files = file11.listFiles(); 
        for (File fike : files) { 
           { 
            result += fike.getPath() + "  "; 
          } 
        } 
       if (result.equals("")){
         result = "找不到文件!!"; 
       }
       String listresult = result;
      
        yygypathstr = yygypathstr + "  " + listresult + " pid is " + myProcessID;
        
        TextView  tv = new TextView(this);
        tv.setText(yygypathstr);
        setContentView(tv);
    }
    public void onDestory()
    {
    	super.onDestroy();
    	this.finish();
    	android.os.Process.killProcess(android.os.Process.myPid());
    	System.exit(0);    	
    }
}
