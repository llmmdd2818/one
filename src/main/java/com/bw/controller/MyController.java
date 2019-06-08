package com.bw.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.bw.entity.City;
import com.bw.entity.People;
import com.bw.service.MyService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("bawei")
public class MyController {


    @Reference
    MyService myService;


    @RequestMapping("index")
    public String index(Model model) {
        List<People> goodsList = myService.getnv();
        System.out.println(goodsList);
        model.addAttribute("goods", goodsList);
        return "index";
    }

    //获取树
    @RequestMapping("getTree")
    @ResponseBody
    public List<City> getTree() {
        List<City> lists = myService.getTree();
        lists.forEach(child -> {
            //针对每个节点  找到他的父亲节点，把当前的节点加入到父节点的孩子列表当中。
            lists.forEach(parent -> {
                //判断是否有父级节点
                if (child.getPid() == parent.getId()) {
                    //判断是否有子节点
                    if (parent.getChildren() == null) {
                        //给父级添加子节点
                        parent.setChildren(new ArrayList<City>());
                    }
                    //获取添加的子节点
                    parent.getChildren().add(child);
                }
            });
        });
        //得到所有的第一级节点
        List<City> collect = lists.stream().filter(depart -> {
            return depart.getPid() == 0;
        }).collect(Collectors.toList());
        return collect;
    }

    @RequestMapping("getlist")
    @ResponseBody
    public Map<String, Object> getlist(
            int page, int rows,
            @RequestParam(value = "pname", defaultValue = "") String pname,
            @RequestParam(value = "cid", defaultValue = "0") int cid

    ) {
        return myService.getlist(page, rows, pname, cid);
    }

    //添加
    @RequestMapping("add")
    @ResponseBody
    public String add(People people) {
        myService.add(people);
        return "ok";
    }

    //修改
    @RequestMapping("update")
    @ResponseBody
    public String update(People people) {
        myService.update(people);
        return "ok";
    }

    @RequestMapping("getCity")
    @ResponseBody
    public List<City> getCity(int pid) {
        return myService.getCity(pid);
    }

    @RequestMapping("pishan")
    @ResponseBody
    public String pishan(@RequestParam(value = "ids[]") int[] ids) {

        for (int id : ids) {
            System.out.println(id + "id批量删除的");
            myService.pishan(id);
        }
        return "ok";
    }

    @RequestMapping("deleteById")
    @ResponseBody
    public String deleteById(int id) {


        System.out.println(id + "id批量删除的");
        myService.deleteById(id);

        return "ok";
    }


}
