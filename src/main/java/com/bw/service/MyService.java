package com.bw.service;

import com.bw.entity.City;
import com.bw.entity.People;

import java.util.List;
import java.util.Map;

public interface MyService {
    List<City> getTree();
//查询people 取男女
    List<People> getnv();

//模糊查询
    Map<String, Object> getlist(int page, int rows,String pname,  int cid);

    void add(People people);

    List<City> getCity(int pid);

    void update(People people);

    void pishan(int id);

    void deleteById(int id);
}
