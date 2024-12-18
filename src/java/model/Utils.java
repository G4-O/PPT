/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;

/**
 *
 * @author umarzein
 */
public class Utils {
    private static final DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
    public static long iso8601_to_long(String date){
        return Instant.parse(date)
            .getEpochSecond();
    }
    public static String long_to_iso8601(long timestamp){
        return df1.format(new java.util.Date(timestamp));
    }
}
