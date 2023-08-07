package com.gt.s.kos.project.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gt.s.common.ChabunUtil;
import com.gt.s.common.CodeUtil;
import com.gt.s.common.CommonUtils;
import com.gt.s.common.DateFormatUtil;
import com.gt.s.common.FileUploadUtil;
import com.gt.s.common.chabun.service.GtChabunService;
import com.gt.s.kos.account.service.GtAccountService;
import com.gt.s.kos.account.vo.GtAccountVO;
import com.gt.s.kos.employee.service.GtEmployeeService;
import com.gt.s.kos.employee.vo.GtEmployeeVO;
import com.gt.s.kos.project.service.GtProjectService;
import com.gt.s.kos.project.vo.GtProjectVO;
import com.gt.s.kos.spend.service.GtSpendService;
import com.gt.s.kos.spend.vo.GtSpendVO;

@Controller
public class GtProjectController {
	Logger log = LogManager.getLogger(this.getClass());
	
	private String gpnum = "";
	
	@Autowired(required = false)
	GtEmployeeService gtEmployeeService;
	
	@Autowired(required = false)
	GtProjectService gtProjectService;
	
	@Autowired(required = false)
	GtChabunService gtChabunService;
	
	@Autowired(required = false)
	GtAccountService gtAccountService;
	
	@Autowired(required = false)
	private GtSpendService gtSpendService;
	
	@GetMapping("ProjectSelectAll")
	public String gtProjectSelectAll(Model m, HttpServletRequest req, GtProjectVO gvo) {
		log.info("gtProjectSelectAll 진입 >>> : ");
		
		List<GtProjectVO> aList = gtProjectService.gtProjectSelectAll();
		
		LocalDate now = LocalDate.now(); // 현재시간 보내기
		
		log.info("now >>> " + now);
		
		if(aList != null && aList.size() > 0) {
			log.info("aList >>> : " + aList.size());
			m.addAttribute("aList" , aList);
			m.addAttribute("now" , now);
			
			return "project/projectManage";

		}else {
			
			return "project/projectManage";	
		}
	} // end of ProjectSelectAll
	
	@PostMapping(value = "appProjectSelectAll", produces = "application/x-www-form-urlencoded;charset=UTF-8")
	@ResponseBody
	public String appProjectSelectAll() {
		log.info("appProjectSelectAll 진입 >>> : ");
		String s = "";
		List<GtProjectVO> aList = gtProjectService.gtProjectSelectAll();
				
		if(aList != null && aList.size() > 0) {
			log.info("aList >>> : " + aList.size());
			for(int i=0; i<aList.size(); i++) {
				GtProjectVO pvo = aList.get(i);
				String con = pvo.getGpcontr();
				String num = pvo.getGpnum();
				String name = pvo.getGpname();
				String start = pvo.getGpstartdate();
				String end = pvo.getGpenddate();
				s += con + "," + num + "," + name + "," + start + "," + end + ",,,";
			}
			
			return s;
		}else {
			return s;	
		}
	}
	
	@GetMapping("projectInsert")
	@ResponseBody
	public String gtProjectInsert(Model m, GtProjectVO pvo, HttpServletRequest req) {
		log.info("컨트롤러 gtProjectInsert 진입 >>> : ");
		this.gpnum = null;
		this.gpnum = pvo.getGpnum();
		log.info(req.getParameter("gppcontype"));
		log.info("gppname >>>> " + req.getParameter("gppname"));
		log.info("gpnum >>>> " + req.getParameter("gpnum"));
		if(req.getParameter("gpcontryn") == "예") {
			
			pvo.setGpcontryn("Y");
			
		}else {
			pvo.setGpcontryn("N");
		}
		
		if(req.getParameter("gpcontryn") == "예") {
			
			pvo.setGpcontryn("Y");
			
		}else {
			pvo.setGpcontryn("N");
		}
		
		
		pvo.setGpnum(ChabunUtil.BIZ_GUBUN_PR.concat(DateFormatUtil.ymdFormats("D")).concat(gtChabunService.getGtProjectChabun().getGpnum())); 
		
		log.info("gpnum >>> " + pvo.getGpnum());
		log.info("gpname  >>> : " + pvo.getGpname());
		log.info("gpstart >>> : " + pvo.getGpstartdate());
		log.info("gpendda >>> : " + pvo.getGpenddate());
		log.info("gpcontr >>> : " + pvo.getGpcontr());
		log.info("gpcontryn >>> : " + pvo.getGpcontryn());
		log.info("gpcstar >>> : " + pvo.getGpcstartdate());
		log.info("gpcendd >>> : " + pvo.getGpcenddate());
		log.info("gpinfo  >>> : " + pvo.getGpinfo());
		log.info("gptic = >>> : " + pvo.getGptic());
		log.info("gpticman >>> : " + pvo.getGpticman());	
		
		log.info("gpconty >>> : " + pvo.getGpcontype());
		log.info("gpest 		>>> : " + pvo.getGpest());		
		log.info("gpestmount	>>> : " + pvo.getGpestmount());
		log.info("gpnote		>>> : " + pvo.getGpnote());
		
		log.info("gppcontype	>>> : "  + pvo.getGppcontype());	
		
		log.info("gppname		>>> : "  + pvo.getGppname());
		log.info("gpprank		>>> : "  + pvo.getGpprank());
		log.info("gppstartdate	>>> : "  + pvo.getGppstartdate());
		log.info("gppenddate	>>> : "  + pvo.getGppenddate());	
		log.info("gppgong		 >>> : " + pvo.getGppgong());	
		
		
		int nCnt = gtProjectService.gtProjectInsert(pvo);
		
		String str = "";
		
		if(nCnt > 0) {
			str = "OK";
		}else{
			str = "NO";
		}

		return str;
		
	} // end of ProjectInsert
	
	
	@GetMapping("projectInsertForm")
	public String gtProjectInsertForm(Model m) {
		
		String gpnum = (ChabunUtil.BIZ_GUBUN_PR.concat(DateFormatUtil.ymdFormats("D")).concat(gtChabunService.getGtProjectChabun().getGpnum())); 
		
		m.addAttribute("gpnum", gpnum);
		
		return "project/projectInsertform";
	}
	@GetMapping("searchman")
	public String gtProjectsearchman(Model m,HttpServletRequest req) {
		log.info("여기는 searchman1");
		
		List<GtEmployeeVO> aList = gtProjectService.gtEmployeeSelectAll();
		
		
		if(aList != null) {
			log.info("aList.size >>> : " + aList.size());
			
			m.addAttribute("aList", aList);
			
			return "project/searchman";
		}
		
		return "project/searchman";
		
	} // end of ProjectInsertForm
	
	@GetMapping(value = "searchman2", produces = "application/x-www-form-urlencoded;charset=UTF-8")
	@ResponseBody
	public String gtProjectsearchman2(Model m,HttpServletRequest req, GtEmployeeVO evo) {
		log.info("여기는searchman2 드러옴 ");
				
		List<GtEmployeeVO> aList2 = gtProjectService.gtEmployeeSelect2(evo);
		
		String aa = "";
		String bb = "";
		
		log.info("aList.size() >>> : " + aList2.size());
		
		for(int i = 0 ; i < aList2.size() ; i++) {
					
					GtEmployeeVO evo_ = aList2.get(i);
					
					aa = evo_.getGename()+","+evo_.getGedept()+","+evo_.getTitle()+","+evo_.getGenum();
					
					bb += aa + "/";
			
		}
			log.info("bb >>> : " + bb);
			m.addAttribute("aList2", aList2);
		
		return bb;
		
	} // end of gtProjectsearchman2
	
	
	
	@PostMapping(value = "gtProjectFileupload")
	public String gtProjectFileupload(@RequestParam("gpfile") ArrayList<MultipartFile> files) {
		
		
		log.info("gtProjectFileupload() >>> : ");
		log.info(this.gpnum);
		
		String fileNames = FileUploadUtil.fileupload(files, this.gpnum, CommonUtils.PO_FILE_UPLOAD_PATH);
		
		log.info("fileNames > : " + fileNames);
		GtProjectVO pvo = null;
		pvo = new GtProjectVO();
		pvo.setGpnum(this.gpnum);
		pvo.setGpfile(fileNames);
		log.info("pvo.getGpnum() > : " + pvo.getGpnum());
		log.info("pvo.getGpfile() > : " + pvo.getGpfile());
		
		log.info(pvo.getGpnum());
		
		int nCnt = gtProjectService.gtProjectInsertFile(pvo);
		
		if (nCnt > 0) {
			
			return "project/projectInsert";
			
		}else {
			return "project/fail";
		}

	} // end of gtProjectFileupload
	
	@GetMapping(value = "AccountSelectForm2", produces = "application/x-www-form-urlencoded;charset=UTF-8")
	@ResponseBody
	public String gtAccountSelectForm(Model m,HttpServletRequest req, GtAccountVO gvo) {
		log.info("여기는gtAccountSelectForm 드러옴 ");
		log.info("avo.getGaname() >>> : " + gvo.getGaname());
		
		List<GtAccountVO> aList2 = gtAccountService.gtAccountSelect(gvo);
		
		String aa = "";
		String total = "";
		
		log.info("aList.size() >>> : " + aList2.size());
		
		for(int i = 0 ; i < aList2.size() ; i++) {
					
			GtAccountVO gvo_ = aList2.get(i);
					
					aa = gvo_.getGanum()+","+gvo_.getGaname()+","+gvo_.getGasnum()+","+gvo_.getGabusinesstype()+","+gvo_.getGaevent()+","+
						 gvo_.getGazone()+","+gvo_.getGaload()+","+gvo_.getGaloaddetale()+","+gvo_.getGahp()+","+gvo_.getGafax()+","+
							gvo_.getGafoundation()+","+gvo_.getStartdate()+","+gvo_.getEnddate()+","+gvo_.getGagubun()+","+gvo_.getGainfo();
					
					total += aa + "/";
			
		}
			log.info("bb >>> : " + total);
			m.addAttribute("aList2", aList2);
		
		return total;
		
	} // end of gtProjectsearchman2
	
	@GetMapping("AccountSelectForm")
	public String AccountSelectForm(Model m,HttpServletRequest req, GtAccountVO gvo) {
		
		List<GtAccountVO> aList3 = gtAccountService.gtAccountSelectAll2();
		log.info("aList.size() >>> : " + aList3.size());
		
		m.addAttribute("aList3", aList3);
		
		return "project/accountSelectForm";
		
	}
	
	@GetMapping(value = "projectactualcost")
	public String projectactualcost(Model m) {

		log.info("projectactualcost() > : ");

		int totalcount = 0;
		int cost_[] = new int[13];
		for (int i = 0; i < cost_.length; i++) {
			cost_[i] = 0;
		}

		List<GtSpendVO> list = gtSpendService.gtSpendSelectAll();
		if (list != null) {
			List<GtSpendVO> list_ = null;
			list_ = new ArrayList<GtSpendVO>();
			for (int i = 0; i < list.size(); i++) {
				String app = list.get(i).getApprover();
				int count_ = Integer.parseInt(list.get(i).getCount());
				if(count_>0) {
					String s = CodeUtil.edsmjeoncheck(app, count_);
					String ss = CodeUtil.edsmcheck(app, count_);
					log.info("s > : " + s);
					log.info("ss > : " + ss);
					if ((!s.equals("")) || ss.equals("OK")) {
						GtSpendVO gvo = list.get(i);
						String gubun = gvo.getGsgubun();
						String count = gvo.getGscount();
						String cost = gvo.getGscost();
						String account = gvo.getGsaccount();
						String info = gvo.getGsinfo();
						String[] gubuns = gubun.split(",");
						String[] counts = count.split(",");
						String[] costs = cost.split(",");
						String[] accounts = account.split(",");
						String[] infos = info.split(",");
						for (int ii = 0; ii < gubuns.length; ii++) {
							if (!gubuns[ii].equals("-선택-")) {
								GtSpendVO svo = null;
								svo = new GtSpendVO();
								svo.setGsdate(gvo.getGsdate());
								svo.setWriter((gvo.getWriter().split("/"))[0]);
								svo.setGsgubun(gubuns[ii]);
								svo.setGsaccount(accounts[ii]);
								svo.setGssubject(gvo.getGssubject());
								svo.setGsinfo(infos[ii]);
								svo.setGscount(counts[ii]);
								svo.setGscost(costs[ii]);
								GtProjectVO pvo = new GtProjectVO();
								pvo.setGpnum(gvo.getGpnum());
								List<GtProjectVO> proList = gtProjectService.gtProjectSelect(pvo);
								svo.setGpnum(proList.get(0).getGpname());
								svo.setTotalcost(
										Integer.toString(Integer.parseInt(counts[ii]) * Integer.parseInt(costs[ii])));
								list_.add(svo);
								for (int x = 0; x < CommonUtils.s.length; x++) {
									if (gubuns[ii].equals(CommonUtils.s[x])) {
										cost_[x] += Integer.parseInt(counts[ii]) * Integer.parseInt(costs[ii]);
									}
								}
							}
						}
					}
				}
			}
			m.addAttribute("cost_", cost_);
			m.addAttribute("list_", list_);

			return "project/projectactualcost";
		} else {
			return "project/projectactualcost";
		}

	}
	@GetMapping("projectselect")
	public String projectselect(Model m, HttpServletRequest req, GtProjectVO pvo, GtAccountVO gvo,@RequestParam("carrypnum") String carrypnum,
            @RequestParam("carryAccount") String carryAccount) {
		
		
		LocalDate now = LocalDate.now(); // 현재시간 보내기
		
		String contrname = carryAccount;
		
		gvo.setGaname(contrname);
		
		String pnum = carrypnum;
		
		pvo.setGpnum(pnum);
		
		log.info("pnum >>>> : " + pvo.getGpnum());
		List<GtAccountVO> aList2 = gtAccountService.gtAccountSelect(gvo);
		List<GtProjectVO> aList = gtProjectService.gtProjectSelect(pvo);

		GtProjectVO ss = aList.get(0);
		
		log.info("sssss >>> :" +ss.getGpnum());
		log.info(ss.getGpcontr());
		log.info(ss.getGpcontype());
		log.info(ss.getGpgubun());
		log.info(ss.getGppname());
		
		m.addAttribute("aList",aList);
		m.addAttribute("aList2",aList2);
		m.addAttribute("now",now);
		
		log.info("들어가냐 ??  >>>> : " + aList2.size());
		
		return "project/projectselect";
	} // end of projectselect
	
} // end of class
