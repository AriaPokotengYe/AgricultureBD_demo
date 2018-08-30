package cn.edu.seu.agriculture.service.impl;

import cn.edu.seu.agriculture.dao.DatePriceMapper;
import cn.edu.seu.agriculture.entity.DatePrice;
import cn.edu.seu.agriculture.entity.DatePriceExample;
import cn.edu.seu.agriculture.exception.DataNotExistException;
import cn.edu.seu.agriculture.exception.PathInvalidException;
import cn.edu.seu.agriculture.service.DatePriceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.Date;

@Service
public class DatePriceServiceImpl implements DatePriceService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DatePriceMapper datePriceMapper;

    /**
     * 工具函数, 将从数据库返回的结果翻译成可以转为json object的对象
     * @param datePriceList  从数据库中select到的结果list
     * @return  list<map> 格式
     */
    private List<Map<String,Object>> toListMap(List<DatePrice> datePriceList){
        List<Map<String,Object>> json = new ArrayList<>();
        List<String> dateList = new ArrayList<>();
        List<Double> priceList = new ArrayList<>();
        for(DatePrice dp : datePriceList){
            dateList.add(new Date(dp.getDate().getTime()).toString());
            priceList.add(dp.getPrice());
        }
        Map<String,Object> xMap = new HashMap<>();
        Map<String,Object> yMap = new HashMap<>();
        xMap.put("date",dateList);
        yMap.put("price",priceList);
        json.add(xMap);   // [0] 是日期
        json.add(yMap);   // [1] 是价格
        return json;
    }

    @Override
    public List<Map<String,Object>> getPriceListByInfo(String province,
                                                String market,
                                                String type,
                                                String name)
    {
        try{
            if(province == null || province.equals("")
            || market == null|| market.equals("")
            || type == null || type.equals("")
            || name == null || name.equals("")){
                throw new PathInvalidException("URL path is invalid!");
            }
            //创建查询模板

            DatePriceExample example = new DatePriceExample();
            /**
             * Implement the example.
             */
            example.createCriteria()
                    .andProvinceEqualTo(province)
                    .andMarketEqualTo(market)
                    .andTypeEqualTo(type)
                    .andNameEqualTo(name);
            example.setOrderByClause("date DESC"); //倒着取数据
            List<DatePrice> list = datePriceMapper.selectByExample(example);
            if (list == null || list.isEmpty()){
                throw new DataNotExistException("No data is stored in database!");
            }
            Collections.reverse(list); //　日期从低到高
            return this.toListMap(list);
        }catch (PathInvalidException | DataNotExistException e1){
            logger.error(e1.getMessage());
            throw e1;
        } catch (Exception e2){
            logger.error(e2.getMessage(),e2);
            throw e2;
        }
    }

    @Override
    public List<Map<String, Object>> getPriceListByInfo(String province,
                                                        String market,
                                                        String type,
                                                        String name,
                                                        String src,
                                                        String dst) {
        try{
            if(province == null || province.equals("")
                    || market == null|| market.equals("")
                    || type == null || type.equals("")
                    || name == null || name.equals("")){
                throw new PathInvalidException("URL path is invalid!");
            }
            //创建查询模板
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            DatePriceExample example = new DatePriceExample();
            try {
                java.util.Date srcDate = format.parse(src);
                java.util.Date dstDate = format.parse(dst);
                example.createCriteria()
                        .andProvinceEqualTo(province)
                        .andMarketEqualTo(market)
                        .andTypeEqualTo(type)
                        .andNameEqualTo(name)
                        .andDateBetween(srcDate,dstDate);
                example.setOrderByClause("date DESC");
            } catch (ParseException e) {
                logger.error(e.getMessage());
            }
            List<DatePrice> list = datePriceMapper.selectByExample(example);
            /**
             * Implement the example.
             */
            if (list == null || list.isEmpty()){
                throw new DataNotExistException("No data is stored in database!");
            }
            Collections.reverse(list);
            return this.toListMap(list);
        }catch (PathInvalidException | DataNotExistException e1){
            logger.error(e1.getMessage());
            throw e1;
        } catch (Exception e2){
            logger.error(e2.getMessage(),e2);
            throw e2;
        }
    }

    @Override
    public List<Map<String, Object>> getPriceListByInfo(String province,
                                                        String market,
                                                        String type,
                                                        String name,
                                                        int day) {
        try{
            if(province == null || province.equals("")
                    || market == null|| market.equals("")
                    || type == null || type.equals("")
                    || name == null || name.equals("")){
                throw new PathInvalidException("URL path is invalid!");
            }
            //创建查询模板

            DatePriceExample example = new DatePriceExample();
            /**
             * Implement the example.
             */
            example.createCriteria()
                    .andProvinceEqualTo(province)
                    .andMarketEqualTo(market)
                    .andTypeEqualTo(type)
                    .andNameEqualTo(name);
            example.setOrderByClause("date DESC"); //倒着取数据
            List<DatePrice> list = datePriceMapper.selectByExample(example);
            if (list == null || list.isEmpty()){
                throw new DataNotExistException("No data is stored in database!");
            }else if(list.size() < day){
                day = list.size();
            }
            List<DatePrice> subList  = list.subList(0,day);
            Collections.reverse(subList); //　日期从低到高
            return this.toListMap(subList);
        }catch (PathInvalidException | DataNotExistException e1){
            logger.error(e1.getMessage());
            throw e1;
        } catch (Exception e2){
            logger.error(e2.getMessage(),e2);
            throw e2;
        }
    }
}
