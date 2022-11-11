package com.codingquokka.hansungvote.domain;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

public class InputThread implements Runnable {
    private byte[] bytesFile;

    private UserDAO uDao;

    public InputThread(byte[] file, UserDAO uDao) {
        this.uDao = uDao;
        this.bytesFile = file;
    }

    @Override
    public void run() {
        InputStream in = new ByteArrayInputStream(bytesFile);
        XSSFWorkbook workbook = null;
        try {
            workbook = new XSSFWorkbook(in);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        int rowNo = 0;
        //int cellIndex = 0;

        XSSFSheet sheet = workbook.getSheetAt(0); // 0 번째 시트를 가져온다
        // 만약 시트가 여러개 인 경우 for 문을 이용하여 각각의 시트를 가져온다
        int rows = sheet.getPhysicalNumberOfRows(); // 사용자가 입력한 엑셀 Row수를 가져온다
        for (rowNo = 1; rowNo < rows; rowNo++) {

            XSSFRow row = sheet.getRow(rowNo);

            if (row != null) {
                int cells = row.getPhysicalNumberOfCells(); // 해당 Row에 사용자가 입력한 셀의 수를 가져온다

                String[] temp = new String[6];

                for (int cellIndex = 0; cellIndex < cells; cellIndex++) {
                    XSSFCell cell = row.getCell(cellIndex); // 셀의 값을 가져온다
                    String value = "";
                    if (cell == null) { // 빈 셀 체크
                        continue;
                    }
                    else {
                        // 타입 별로 내용을 읽는다
                        switch (cell.getCellType()) {
                            case XSSFCell.CELL_TYPE_FORMULA:
                                value = cell.getCellFormula();
                                break;
                            case XSSFCell.CELL_TYPE_NUMERIC:
                                value = cell.getNumericCellValue() + "";
                                break;
                            case XSSFCell.CELL_TYPE_STRING:
                                value = cell.getStringCellValue() + "";
                                break;
                            case XSSFCell.CELL_TYPE_BLANK:
                                value = cell.getBooleanCellValue() + "";
                                break;
                            case XSSFCell.CELL_TYPE_ERROR:
                                value = cell.getErrorCellValue() + "";
                                break;
                        }
                    }
                    temp[cellIndex] = value;
                }
                try {
                    UserVO uVo = new UserVO();
                    uVo.setStuid(temp[0].trim());
                    uVo.setName(temp[1].trim());
                    uVo.setPhoneNumber(temp[2].trim().replace("-",""));
                    uVo.setDepartment(temp[3].trim());
                    uVo.setAgree(temp[4].trim());
                    uVo.setDelegate(temp[5].trim());
                    uDao.insertUser(uVo);
                    System.out.println(temp[0].trim() + " " + temp[1].trim() + " " + temp[2].trim().replace("-","") + " " + temp[3].trim());
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
        }
        System.out.println("Thread Terminate");
    }
}
