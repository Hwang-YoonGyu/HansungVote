package com.codingquokka.hansungenquete.domain;

import org.springframework.stereotype.Repository;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.*;
import java.security.spec.RSAPublicKeySpec;

@Repository
public class RSA {
    public static String RSA_WEB_KEY ="";
    public static String RSA_INSTANCE ="";
    /**생성자 만들어주는 모습 **/
    public RSA() {
        RSA_WEB_KEY = "_RSA_WEB_Key_"; // 개인키 session key
        RSA_INSTANCE = "RSA"; // rsa transformation

    }



    /**
     * 복호화
     *
     * @param privateKey
     * @param securedValue
     * @return
     * @throws Exception
     */
    public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance(RSA.RSA_INSTANCE);
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }

    /**
     * 16진 문자열을 byte 배열로 변환한다.
     *
     * @param hex
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) { return new byte[] {}; }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }


    /**
     * rsa 공개키, 개인키 생성
     *
     * @param request
     */
    public void initRsa(HttpServletRequest request) {
        HttpSession session = request.getSession();

        KeyPairGenerator generator;
        try {
            generator = KeyPairGenerator.getInstance(RSA.RSA_INSTANCE);
            generator.initialize(1024);

            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance(RSA.RSA_INSTANCE);
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            session.setAttribute(RSA.RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장

            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

            request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
            request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
