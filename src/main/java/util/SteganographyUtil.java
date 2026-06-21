package util;

public class SteganographyUtil {

    // Hide encrypted text

    public static String hideText(

            String coverText,

            String secretText) {

        return coverText +

        "[HIDDEN]"

        +

        secretText

        +

        "[/HIDDEN]";
    }

    // Extract encrypted text

    public static String extractText(

            String stegoText) {

        int start =

        stegoText.indexOf(
                "[HIDDEN]");

        int end =

        stegoText.indexOf(
                "[/HIDDEN]");

        if(start == -1 || end == -1) {

            return "";
        }

        start += 8;

        return stegoText.substring(
                start,
                end);
    }
}