package com.gt.s.kos.resignation.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.gt.s.common.K_Session;
import com.gt.s.common.chabun.service.GtChabunService;
import com.gt.s.kos.approvalline.vo.GtApprovalLineVO;
import com.gt.s.kos.draft.vo.GtDraftVO;
import com.gt.s.kos.employee.service.GtEmployeeService;
import com.gt.s.kos.employee.vo.GtEmployeeVO;
import com.gt.s.kos.resignation.service.GtResignationService;
import com.gt.s.kos.resignation.vo.GtResignationVO;

@Controller
public class GtResignationController {
	
	
	private String chabun;

	Logger logger = LogManager.getLogger(GtResignationController.class);
	
	@Autowired(required=false)
	private GtResignationService gtResignationService;
	
	@Autowired(required=false)
	private GtChabunService gtChabunService;
	
	 @Autowired(required=false)
	 private GtEmployeeService gtEmployeeService;
	
	// 사직서 입력폼
    @GetMapping("resignationInsertForm")
    public String resignationInsertForm(HttpServletRequest req, GtEmployeeVO gevo, Model model) {
       
       K_Session ks = K_Session.getInstance();
       String genum= ks.getSession(req);
       gevo.setGenum(genum);
       
       GtEmployeeVO sAll = gtEmployeeService.gecheck(gevo);
       
       String gename   = sAll.getGename(); 
       String gedept   = sAll.getGedept(); 
       String title  = sAll.getTitle();
       String writer = gedept + "/" + gename  + "/" +  title;
       logger.info(">>> resignationInsertForm() :: length() : "  + writer.length());
       
       model.addAttribute("genum" , genum);
       model.addAttribute("writer" , writer);
       return "resignation/resignationInsertForm";
       
    } // end of resignationForm()
	
	
	// 사직서 입력폼에서 ajax
	@GetMapping("gtResignationChanbun")
	@ResponseBody
	public String gtResignationChanbun() {
		
		logger.info(">>> gtResignationChanbun() In");
		
		this.chabun =  ChabunUtil.BIZ_GUBUN_RE.concat(DateFormatUtil.ymdFormats("D")).concat(gtChabunService.getGtResignationChabun().getGrnum());
		
		logger.info(">>> gtResignationChanbun() :: grnum : " + chabun);
		
		return chabun;
	}
	
	@GetMapping("resignationInsert")
	@ResponseBody
	public String resignationInsert(GtResignationVO rvo, HttpServletRequest req) {
		
		logger.info(">>> resignationInsert() In");
		
		this.chabun = null;
		
		this.chabun = rvo.getGrnum();

		
		rvo.setGrnum(chabun);
		rvo.setApprover(rvo.getApprover().replace(",", "/"));
		rvo.setDept(rvo.getDept().replace(",", "/"));
		logger.info("rvo.getApprover() > : " + rvo.getApprover());
		
		int nCnt = gtResignationService.gtResignationInsert(rvo);
		
		logger.info(">>> resignationInsert() In :: nCnt : " + nCnt);
		
		if(nCnt > 0) {
			return "YES";
		}else {
			
			return "NO";			
		}
		
	} // end of resignationInsert()
	
	// file insert
	 @PostMapping("gtResignationInsertFile")
	   public String gtResignationInsertFile(@RequestParam("grfile") ArrayList<MultipartFile> files) {      
	      logger.info(">>> gtResignationInsertFile() In");
	      
	      String fileNames = FileUploadUtil.fileupload(files, this.chabun, CommonUtils.RE_FILE_UPLOAD_PATH);
	      logger.info("fileNames > : " + fileNames);
	      
	      GtResignationVO grvo = null;
	      grvo = new GtResignationVO();
	      grvo.setGrnum(this.chabun);
	      grvo.setGrfile(fileNames);
	      logger.info("svo.getGsnum() > : " + grvo.getGrnum());
	      logger.info("svo.getGsfile() > : " + grvo.getGrfile());
	      
	      logger.info(grvo.getGrnum());
	      
	      int nCnt = gtResignationService.gtResignationInsertFile(grvo);
			if (nCnt > 0) {
				List<GtResignationVO> list = gtResignationService.gtResignationSelect(grvo);
				grvo = list.get(0);
				String num = grvo.getGrnum();
				String subject = grvo.getGrsubject();
				String writer = grvo.getWriter();
				String date = grvo.getInsertdate();
				logger.info("date > : " + date);
				String app = grvo.getApprover();
				String count = grvo.getCount();
				String s = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if(!s.equals("OK")) {
					GtEmployeeVO evo = null;
					evo = new GtEmployeeVO();
					evo.setGename(s);
					String email = gtEmployeeService.emailcheck(evo).getGeemail();
					CodeUtil.googlemail(num, subject, writer, date, email);
				}
				return "business/businessInsert";
				
			}else {
				return "business/fail";
			}
	   } // end of gtResignationInsertFile()
	 
	
	@GetMapping(value = "gtResignationSelect")
	public String gtResignaitonSelect(GtApprovalLineVO avo, Model m, HttpServletRequest q) {
		
		logger.info("avo.getGsnum() > : " + avo.getAppnum());
		GtResignationVO rvo = null;
		rvo = new GtResignationVO();
		rvo.setGrnum(avo.getAppnum());
		List<GtResignationVO> list = gtResignationService.gtResignationSelect(rvo);
		rvo = list.get(0);
		m.addAttribute("rvo", rvo);
		
		return "resignation/resignationSelect";
	}
	
    @GetMapping(value = "refileDownloadlist", produces = "application/x-www-form-urlencoded;charset=UTF-8")
    @ResponseBody
    public String fileDownloadList(HttpServletRequest q) {
    	
    	String num = q.getParameter("grnum");
    	String reString = "";
    	
    	try {
	        File path = new File(CommonUtils.RE_FILE_UPLOAD_PATH + "//" + num);
	        String[] fileList = path.list();
	        for(int i=0; i<fileList.length; i++) {
	        	reString += fileList[i] + ",";
	        }
    	}catch(Exception e) {
    		logger.info("파일 리스트 에러 >> : " + e.getMessage());
    	}
        
        return reString;

    }
    
    // 파일 다운로드 처리
    @GetMapping(value = "fileDownloadref")
    public void fileDownload(@RequestParam String file, @RequestParam String num, HttpServletResponse s, HttpServletRequest q) {
    	s.setContentType("text/html; charset=UTF-8");
    	logger.info("file > : " + file);
    	logger.info("gsnum > : " + num);
    	
    	boolean b = FileUploadUtil.filedownload(s, q, num, file, CommonUtils.RE_FILE_UPLOAD_PATH);
    	
    	logger.info("b > : " + b);
    }
    

	

	
	
}
