package com.test;

import com.yd.epub.modules.parse.read.BookInfo;
import com.yd.epub.modules.parse.read.Reader;
import org.junit.Test;

import java.io.File;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/9/20
 * @Version: 1.0
 */
public class TestEpub {

    @Test
    public void test01() {
        File file = new File("/temp.epub");
        BookInfo bookInfo = new Reader().read(file, 20, 600, 800, 1);
        System.out.println(bookInfo.getCatalogs().get(0).getTitle());
        System.out.println(" ---------- ");
        System.out.println(bookInfo.getContents().get(0).getContent());
    }

}
