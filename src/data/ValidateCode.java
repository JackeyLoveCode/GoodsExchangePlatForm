package data;

 
  


import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.Random;

import javax.imageio.ImageIO;

/**  
 * ClassName:ValidateCode <br/>  
 * Function: TODO ADD FUNCTION. <br/>  
 * Reason:   TODO ADD REASON. <br/>  
 * Date:     2018骞�11鏈�8鏃� 涓嬪崍2:33:53 <br/>  
 * @author   Administrator  
 * @version    
 * @since    JDK 1.6  
 * @see        
 */
/**
 * 楠岃瘉鐮佺敓鎴愬櫒
 *
 * @author 
 */
public class ValidateCode {
    // 鍥剧墖鐨勫搴︺��
    private int width = 160;
    // 鍥剧墖鐨勯珮搴︺��
    private int height = 40;
    // 楠岃瘉鐮佸瓧绗︿釜鏁�
    private int codeCount = 5;
    // 楠岃瘉鐮佸共鎵扮嚎鏁�
    private int lineCount = 150;
    // 楠岃瘉鐮�
    private String code = null;
    // 楠岃瘉鐮佸浘鐗嘊uffer
    private BufferedImage buffImg = null;
 
    // 楠岃瘉鐮佽寖鍥�,鍘绘帀0(鏁板瓧)鍜孫(鎷奸煶)瀹规槗娣锋穯鐨�(灏忓啓鐨�1鍜孡涔熷彲浠ュ幓鎺�,澶у啓涓嶇敤浜�)
    private char[] codeSequence = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
            'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
            'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
 
    /**
     * 榛樿鏋勯�犲嚱鏁�,璁剧疆榛樿鍙傛暟
     */
    public ValidateCode() {
        this.createCode();
    }
 
    /**
     * @param width  鍥剧墖瀹�
     * @param height 鍥剧墖楂�
     */
    public ValidateCode(int width, int height) {
        this.width = width;
        this.height = height;
        this.createCode();
    }
 
    /**
     * @param width     鍥剧墖瀹�
     * @param height    鍥剧墖楂�
     * @param codeCount 瀛楃涓暟
     * @param lineCount 骞叉壈绾挎潯鏁�
     */
    public ValidateCode(int width, int height, int codeCount, int lineCount) {
        this.width = width;
        this.height = height;
        this.codeCount = codeCount;
        this.lineCount = lineCount;
        this.createCode();
    }
 
    public void createCode() {
        int x = 0, fontHeight = 0, codeY = 0;
        int red = 0, green = 0, blue = 0;
 
        x = width / (codeCount + 2);//姣忎釜瀛楃鐨勫搴�(宸﹀彸鍚勭┖鍑轰竴涓瓧绗�)
        fontHeight = height - 2;//瀛椾綋鐨勯珮搴�
        codeY = height - 4;
 
        // 鍥惧儚buffer
        buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = buffImg.createGraphics();
        // 鐢熸垚闅忔満鏁�
        Random random = new Random();
        // 灏嗗浘鍍忓～鍏呬负鐧借壊
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);
        // 鍒涘缓瀛椾綋,鍙互淇敼涓哄叾瀹冪殑
        Font font = new Font("Fixedsys", Font.PLAIN, fontHeight);
//        Font font = new Font("Times New Roman", Font.ROMAN_BASELINE, fontHeight);
        g.setFont(font);
 
        for (int i = 0; i < lineCount; i++) {
            // 璁剧疆闅忔満寮�濮嬪拰缁撴潫鍧愭爣
            int xs = random.nextInt(width);//x鍧愭爣寮�濮�
            int ys = random.nextInt(height);//y鍧愭爣寮�濮�
            int xe = xs + random.nextInt(width / 8);//x鍧愭爣缁撴潫
            int ye = ys + random.nextInt(height / 8);//y鍧愭爣缁撴潫
 
            // 浜х敓闅忔満鐨勯鑹插�硷紝璁╄緭鍑虹殑姣忎釜骞叉壈绾跨殑棰滆壊鍊奸兘灏嗕笉鍚屻��
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            g.setColor(new Color(red, green, blue));
            g.drawLine(xs, ys, xe, ye);
        }
 
        // randomCode璁板綍闅忔満浜х敓鐨勯獙璇佺爜
        StringBuffer randomCode = new StringBuffer();
        // 闅忔満浜х敓codeCount涓瓧绗︾殑楠岃瘉鐮併��
        for (int i = 0; i < codeCount; i++) {
            String strRand = String.valueOf(codeSequence[random.nextInt(codeSequence.length)]);
            // 浜х敓闅忔満鐨勯鑹插�硷紝璁╄緭鍑虹殑姣忎釜瀛楃鐨勯鑹插�奸兘灏嗕笉鍚屻��
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            g.setColor(new Color(red, green, blue));
            g.drawString(strRand, (i + 1) * x, codeY);
            // 灏嗕骇鐢熺殑鍥涗釜闅忔満鏁扮粍鍚堝湪涓�璧枫��
            randomCode.append(strRand);
        }
        // 灏嗗洓浣嶆暟瀛楃殑楠岃瘉鐮佷繚瀛樺埌Session涓��
        code = randomCode.toString();
    }
 
    public void write(String path) throws IOException {
        OutputStream sos = new FileOutputStream(path);
        this.write(sos);
    }
 
    public void write(OutputStream sos) throws IOException {
        ImageIO.write(buffImg, "png", sos);
        sos.close();
    }
 
    public BufferedImage getBuffImg() {
        return buffImg;
    }
 
    public String getCode() {
        return code;
    }
 
    /**
     * 娴嬭瘯鍑芥暟,榛樿鐢熸垚鍒癲鐩�
     * @param args
     */
    public static void main(String[] args) {
        ValidateCode vCode = new ValidateCode(160,40,5,150);
        try {
            String path="D:/"+new Date().getTime()+".png";
            System.out.println(vCode.getCode()+" >"+path);
            vCode.write(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

  
