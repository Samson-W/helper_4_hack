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
        
        /***************************************************************
         * filename head:
         * get rsl: 61CC7AE0
         * hpid: C966A01E
         * uhpid: 50D55DB7
         * ht4port: 4A6B2318
         * uht4port: 7FAFD9B1
         * ************************************************************/
        String name = "61CC7AE0";
        //String name = "C966A01E";
        name = name + myProcessID;
        
        File file = new File(yygypath, name); 
        try {
			file.createNewFile();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        String result = ""; 
        File file11 = new File(yygypathstr);
        File[] files = file11.listFiles(); 
        for (File fike : files) 
        { 
            result += fike.getPath() + "  ";  
        } 
        if (result.equals(""))
        {
        	result = "找不到文件!!"; 
        }
       String listresult = result;
      
       yygypathstr = yygypathstr + "  " + listresult + " pid is " + myProcessID;
       file.delete();
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
