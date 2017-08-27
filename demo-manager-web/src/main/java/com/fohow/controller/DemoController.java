package com.fohow.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fohow.entity.QuartzConfigure;
import com.fohow.enums.TjResCode;
import com.fohow.service.DemoService;
import com.fohow.util.PagedResult;
import com.fohow.util.Result;
import com.fohow.util.RetResult;

@Controller
@RequestMapping("/demo")
public class DemoController {


	@Autowired
	DemoService  demoServiceImpl;
	
	/**
	 * 页面跳转
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/index")
	public ModelAndView index(){
		ModelAndView view = new ModelAndView("demo/list");
		return view;
	}
	
	/**
	 *获取分页数据
	 * @param pageNo   页数
	 * @param pageSize 每页个数
	 * @param taskName 任务名称
	 * @return
	 */
	@RequestMapping("/getList")
	@ResponseBody
	public Object  getList(Integer pageNo,Integer pageSize,String taskName)
	{
		RetResult<Result> result = new RetResult<Result>();
		try
        {
			PagedResult<QuartzConfigure> page=demoServiceImpl.getPage(pageNo, pageSize, taskName);
	        result.setObj(page);
	        result.setTjResCode(TjResCode.C800200);
        }
        catch (Exception e)
        {
        	 result.setTjResCode(TjResCode.C800400);
	        e.printStackTrace();
        }
		return result;
	}

}
