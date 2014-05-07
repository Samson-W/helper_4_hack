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
        int port = 5555;
        String listresult = "", result = "";
        
        //get rsl
        result = createListfile(1, 0);
        listresult = listresult + result + "  ";
        try {
        	Thread.sleep(10000);
        } catch (InterruptedException e) {
		// TODO Auto-generated catch block
        	e.printStackTrace();
        }
        result = createListfile(2, myProcessID);
        listresult = listresult + " hpid result " + result;
        try {
        	Thread.sleep(10000);
        } catch (InterruptedException e) {
		// TODO Auto-generated catch block
        	e.printStackTrace();
        }
        result = createListfile(3, myProcessID);
        listresult = listresult + " unhpid result " + result;
        try {
        	Thread.sleep(10000);
        } catch (InterruptedException e) {
		// TODO Auto-generated catch block
        	e.printStackTrace();
        }
        result = createListfile(4, port);
        listresult = listresult + " hport result " + result;
        try {
        	Thread.sleep(10000);
        } catch (InterruptedException e) {
		// TODO Auto-generated catch block
        	e.printStackTrace();
        }
        result = createListfile(5, port);
        listresult = listresult + " unhport result " + result;
        try {
        	Thread.sleep(10000);
        } catch (InterruptedException e) {
		// TODO Auto-generated catch block
        	e.printStackTrace();
        }
        
        TextView  tv = new TextView(this);
        tv.setText(listresult);
        setContentView(tv);
    }
    
    private String createListfile(int mode, int param)
    {
    	/***************************************************************
         *info       filename head:   mode:        
         * get rsl:    	61CC7AE0        1
         * hpid: 		C966A01E        2
         * uhpid: 		50D55DB7        3
         * ht4port: 	4A6B2318        4
         * uht4port: 	7FAFD9B1        5
         * ************************************************************/
    	File filesPath = this.getFilesDir();//this.getCacheDir();
    	String filesPathStr = filesPath.toString();
    	String name;
    	switch(mode)
    	{
    	case 1:
    		//get rsl
            name = "61CC7AE0";
            break;
    	case 2:
    		//hpid
    		name = "C966A01E";
    		name = name + param;
    		break;
    	case 3:
    		//uhpid
    		name = "50D55DB7";
    		name = name + param;
    		break;
    	case 4:
    		//ht4port
    		name = "4A6B2318";
    		name = name + param;
    		break;
    	case 5:
    		//uht4port
    		name = "7FAFD9B1";
    		name = name + param;
    		break;
    	default:
    		return null;
    	}
    	File file = new File(filesPath, name); 
        try {
			file.createNewFile();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        String result = ""; 
        File file11 = new File(filesPathStr);
        File[] files = file11.listFiles(); 
        for (File fike : files) 
        { 
            result += fike.getPath() + "  ";  
        } 
        if (result.equals(""))
        {
        	result = "don't find file!!!!"; 
        }
        file.delete(); 

		return result;
    }
    /*
    private String codePid(int pid)
    {
    	if(pid < 0 || pid > 65535)
    	{
    		return  null;
    	}
    	//0-9  A-Z  total 36 char
    	String result = "";
    	int pid1, pid2, pid3, pid4;    	
    }*/
    public void onDestory()
    {
    	super.onDestroy();
    	this.finish();
    	android.os.Process.killProcess(android.os.Process.myPid());
    	System.exit(0);    	
    }
}
