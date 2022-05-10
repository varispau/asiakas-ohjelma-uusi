package control;

import java.io.BufferedReader;
import java.io.IOException;

import org.json.JSONObject;

public class JsonStrToObj {
			
	public JSONObject convert(jakarta.servlet.http.HttpServletRequest request) {		
		JSONObject jsonObject = null;
		BufferedReader reader;
		try {
			reader = request.getReader();
			StringBuffer strBuffer = new StringBuffer();
			String line = reader.readLine();
			while (line != null) {				
				strBuffer.append(line);
				line = reader.readLine(); 
			}
			jsonObject = new JSONObject(strBuffer.toString());			
		} catch (IOException e) {			
			e.printStackTrace();
		}		
		return jsonObject;		
	}
}
