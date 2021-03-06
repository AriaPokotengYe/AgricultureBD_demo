package cn.edu.seu.agriculture.service;

import org.json.JSONObject;

import java.util.List;
import java.util.Map;

public interface CountryViewService {

    /**
     * 实现功能：　全国各个省市某种品类平均价格
     * @param type  品类
     * @param name　名字
     * @return : 格式如　"山西" : 3.8　的json对象
     */
    public String  getCountryViewPrice(String date,String type, String name);
}
