package com.test;

import com.alibaba.fastjson.JSON;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.*;

/**
 * @Author: 冯冠凯
 * @Description:
 * @Date: Created on 2017/10/12
 * @Version: 1.0
 */
public class TestOther {

    @Test
    public void test01() {
        File file = new File("D:\\Program Files (x86)\\JetBrains\\ChaoXProjects\\culture-box\\src\\main\\webapp\\datas\\logo");
        System.out.println(file.exists());
        String path = file.getPath();
        String absolutePath = file.getAbsolutePath();
        System.out.println(path);
        System.out.println(absolutePath);
    }

    @Test
    public void test02() {
        String json = "{\"categoryId\":11}";
        HashMap<String, String> map = JSON.parseObject(json, HashMap.class);
        for (String o : map.keySet()) {
            System.out.println("key : " + o + " value : " + map.get(o));
        }
    }

    @Test
    public void test03() {
        List<Integer> list = new ArrayList<Integer>() {{
            add(1);
            add(2);
            add(3);
            add(4);
            add(5);
        }};
        List<Integer> subList = list.subList(1, 3);
        Iterator<Integer> iterator = list.iterator();
        int i = 0;
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
            list.set(i, 0);
        }
        /*ListIterator<Integer> listIterator = list.listIterator(list.size());
        while (listIterator.hasPrevious()) {
            System.out.println(listIterator.previous());
        }*/
    }

    @Test
    public void test04() {
        List<String> temp = Arrays.asList("temp1", "temp2", "temp3");
        temp.set(1, "test");
        temp.set(2, "test");
        for (String s : temp) {
            System.out.println(" test set : " + s);
        }
    }

    @Test
    public void test05() throws IOException {
        String objectid = "993e43575ae2ded5dcd82f75e232fb0c";
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpGet httpGet = new HttpGet("http://jpkc.yunya2.chaoxing.com/editor/cdn/status/" + objectid);
        CloseableHttpResponse execute = httpClient.execute(httpGet);
        System.out.println(EntityUtils.toString(execute.getEntity(), Charset.forName("UTF-8")));
        httpClient.close();
    }
}
