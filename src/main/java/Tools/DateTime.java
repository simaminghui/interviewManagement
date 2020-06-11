package Tools;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTime {

    public static String DateToString()
    {
        Date date=new Date();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"+"  "+"HH:mm");
        String format = dateFormat.format(date);
        return format;
    }


    public static void main(String[] args) {
        System.out.println(DateToString());
    }
}
