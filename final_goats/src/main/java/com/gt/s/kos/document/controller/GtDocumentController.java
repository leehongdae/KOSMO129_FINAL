package com.gt.s.kos.document.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gt.s.common.CodeUtil;
import com.gt.s.common.K_Session;
import com.gt.s.kos.approvalline.service.GtApprovallineService;
import com.gt.s.kos.approvalline.vo.GtApprovalLineVO;
import com.gt.s.kos.business.service.GtBusinessService;
import com.gt.s.kos.business.vo.GtBusinessVO;
import com.gt.s.kos.contract.service.GtContractService;
import com.gt.s.kos.contract.vo.GtContractVO;
import com.gt.s.kos.draft.service.GtDraftService;
import com.gt.s.kos.draft.vo.GtDraftVO;
import com.gt.s.kos.employee.service.GtEmployeeService;
import com.gt.s.kos.employee.vo.GtEmployeeVO;
import com.gt.s.kos.resignation.service.GtResignationService;
import com.gt.s.kos.resignation.vo.GtResignationVO;
import com.gt.s.kos.spend.service.GtSpendService;
import com.gt.s.kos.spend.vo.GtSpendVO;
import com.gt.s.kos.vacation.service.GtVacationService;
import com.gt.s.kos.vacation.vo.GtVacationVO;

@Controller
public class GtDocumentController {

	Logger log = LogManager.getLogger(this.getClass());

	@Autowired(required = false)
	private GtApprovallineService gtApprovallineService;
	@Autowired(required = false)
	private GtContractService gtContractService;
	@Autowired(required = false)
	private GtDraftService gtDraftService;
	@Autowired(required = false)
	private GtBusinessService gtBusinessService;
	@Autowired(required = false)
	private GtVacationService gtVacationService;
	@Autowired(required = false)
	private GtSpendService gtSpendService;
	@Autowired(required = false)
	private GtResignationService gtResignationService;
	@Autowired(required = false)
	private GtEmployeeService gtEmployeeService;

	@GetMapping("document")
	public String mainDraft() {
		log.info("mainDraft() >>> : ");
		return "document/document";
	}

	@RequestMapping(value = "document_approve", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/html; charset=UTF-8")
	public String document_approve(HttpServletRequest q, GtApprovalLineVO avo, Model m) {
		String encoding = q.getCharacterEncoding();
		log.info("encoding > : " + encoding);
		avo.setApp("app");
		log.info("document_approve() >> : ");
		K_Session ks = K_Session.getInstance();
		String genum = ks.getSession(q);
		log.info("genum >>> : " + genum);
		GtEmployeeVO evo = new GtEmployeeVO();
		evo.setGenum(genum);
		evo = gtEmployeeService.goatempidcheck(evo);
		String gename = evo.getGename();
		String apryn = evo.getApryn();
		log.info("apryn >> : " + apryn);
		log.info("gename >>> : " + gename);
		avo.setGename(gename);
		m.addAttribute("avo_", avo);
		if(avo.getS_appnum() == null) {
			avo.setS_appnum("");
		}
		if(avo.getSubject()==(null)) {
			avo.setSubject("");
		}
		if(avo.getS_writer()==(null)) {
			avo.setS_writer("");
		}
		if(avo.getFormname()==(null)) {
			avo.setFormname("");
		}
		if(avo.getAppstartdate()==(null)) {
			avo.setAppstartdate("");
		}
		if(avo.getAppenddate()==(null)) {
			avo.setAppenddate("");
		}
		log.info("avo.getS_appnum() >> : " + avo.getS_appnum());
		log.info("avo.getSubject() >> : " + avo.getSubject());
		log.info("avo.getWriter() >> : " + avo.getS_writer());
		log.info("avo.getFormname() >> : " + avo.getFormname());
		log.info("avo.getAppstartdate() >> : " + avo.getAppstartdate());
		log.info("avo.getAppenddate() >> : " + avo.getAppenddate());
		

		List<GtApprovalLineVO> list_Deci_1 = gtBusinessService.gtDeciBusinessSelect(avo);
		List<GtApprovalLineVO> list_Deci_2 = gtVacationService.gtDeciVacationSelect(avo);
		List<GtApprovalLineVO> list_ = new ArrayList<GtApprovalLineVO>();
		List<GtApprovalLineVO> list_Deci = new ArrayList<GtApprovalLineVO>();
		for (int i = 0; i < list_Deci_1.size(); i++) {
			GtApprovalLineVO avo_ = list_Deci_1.get(i);
			list_.add(avo_);
		}
		log.info("list_Deci_1.size() >>> : " + list_Deci_1.size());
		for (int i = 0; i < list_Deci_2.size(); i++) {
			GtApprovalLineVO avo_ = list_Deci_2.get(i);
			list_.add(avo_);
		}
		log.info("list_Deci_2.size() >>> : " + list_Deci_2.size());
		log.info("list_.size() >>> : " + list_.size());
		if (list_.size() > 0) {
			for (int i = 0; i < list_.size(); i++) {
				GtApprovalLineVO avo_ = list_.get(i);
				String writer = avo_.getWriter().split(" ")[1];
				log.info("writer >>> : " + writer);
				avo_.setGename(writer);
				avo_.setApp("app");
				if(avo_.getS_appnum() == null) {
					avo_.setS_appnum("");
				}
				if(avo_.getSubject()==(null)) {
					avo_.setSubject("");
				}
				if(avo_.getS_writer()==(null)) {
					avo_.setS_writer("");
				}
				if(avo_.getFormname()==(null)) {
					avo_.setFormname("");
				}
				if(avo_.getAppstartdate()==(null)) {
					avo_.setAppstartdate("");
				}
				if(avo_.getAppenddate()==(null)) {
					avo_.setAppenddate("");
				}
				List<GtApprovalLineVO> list_C = gtContractService.gtContractAppSelectAll(avo_);
				List<GtApprovalLineVO> list_D = gtDraftService.draftAppSelectAll(avo_);
				List<GtApprovalLineVO> list_B = gtBusinessService.gtBusinessAppSelectAll(avo_);
				List<GtApprovalLineVO> list_V = gtVacationService.gtVacationAppSelectAll(avo_);
				List<GtApprovalLineVO> list_S = gtSpendService.gtSpendAppSelectAll(avo_);
				List<GtApprovalLineVO> list_R = gtResignationService.gtResignationAppSelectAll(avo_);
				for (int ii = 0; ii < list_C.size(); ii++) {
					GtApprovalLineVO cvo = null;
					cvo = list_C.get(ii);
					String app = cvo.getApprover();
					int count = Integer.parseInt(cvo.getCount());
					if (count >= 0) {
						String jeon = CodeUtil.edsmjeoncheck(app, count);
						String s = CodeUtil.edsmcheck(app, count);
						if ((jeon.equals("") && s.equals(writer))) {
							list_Deci.add(cvo);
						}
					}
				}

				for (int ii = 0; ii < list_D.size(); ii++) {
					GtApprovalLineVO dvo = null;
					dvo = list_D.get(ii);
					String app = dvo.getApprover();
					int count = Integer.parseInt(dvo.getCount());
					if (count >= 0) {
						String jeon = CodeUtil.edsmjeoncheck(app, count);
						String s = CodeUtil.edsmcheck(app, count);
						if ((jeon.equals("") && s.equals(writer))) {
							list_Deci.add(dvo);
						}
					}
				}

				for (int ii = 0; ii < list_B.size(); ii++) {
					GtApprovalLineVO bvo = null;
					bvo = list_B.get(ii);
					String app = bvo.getApprover();
					int count = Integer.parseInt(bvo.getCount());
					if (count >= 0) {
						String jeon = CodeUtil.edsmjeoncheck(app, count);
						String s = CodeUtil.edsmcheck(app, count);
						if ((jeon.equals("") && s.equals(writer))) {
							list_Deci.add(bvo);
						}
					}
				}

				for (int ii = 0; ii < list_V.size(); ii++) {
					GtApprovalLineVO vvo = null;
					vvo = list_V.get(ii);
					String app = vvo.getApprover();
					int count = Integer.parseInt(vvo.getCount());
					if (count >= 0) {
						String jeon = CodeUtil.edsmjeoncheck(app, count);
						String s = CodeUtil.edsmcheck(app, count);
						if ((jeon.equals("") && s.equals(writer))) {
							list_Deci.add(vvo);
						}
					}
				}

				for (int ii = 0; ii < list_S.size(); ii++) {
					GtApprovalLineVO svo = null;
					svo = list_S.get(ii);
					String app = svo.getApprover();
					int count = Integer.parseInt(svo.getCount());
					if (count >= 0) {
						String jeon = CodeUtil.edsmjeoncheck(app, count);
						String s = CodeUtil.edsmcheck(app, count);
						if ((jeon.equals("") && s.equals(writer))) {
							list_Deci.add(svo);
						}
					}
				}

				for (int ii = 0; ii < list_R.size(); ii++) {
					GtApprovalLineVO rvo = null;
					rvo = list_R.get(ii);
					String app = rvo.getApprover();
					int count = Integer.parseInt(rvo.getCount());
					if (count >= 0) {
						String jeon = CodeUtil.edsmjeoncheck(app, count);
						String s = CodeUtil.edsmcheck(app, count);
						if ((jeon.equals("") && s.equals(writer))) {
							list_Deci.add(rvo);
						}
					}
				}
			}
		}
		List<GtApprovalLineVO> list = new ArrayList<GtApprovalLineVO>();
		List<GtApprovalLineVO> list_C = gtContractService.gtContractAppSelectAll(avo);
		List<GtApprovalLineVO> list_D = gtDraftService.draftAppSelectAll(avo);
		List<GtApprovalLineVO> list_B = gtBusinessService.gtBusinessAppSelectAll(avo);
		List<GtApprovalLineVO> list_V = gtVacationService.gtVacationAppSelectAll(avo);
		List<GtApprovalLineVO> list_S = gtSpendService.gtSpendAppSelectAll(avo);
		List<GtApprovalLineVO> list_R = gtResignationService.gtResignationAppSelectAll(avo);

		String jeonyn = q.getParameter("jeonyn");
		if (jeonyn == null) {
			jeonyn = "1";
		}
		log.info("jeonyn >>> : " + jeonyn);
		if (jeonyn.equals("0")) {
			for (int i = 0; i < list_C.size(); i++) {
				GtApprovalLineVO cvo = null;
				cvo = list_C.get(i);
				String app = cvo.getApprover();
				int count = Integer.parseInt(cvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if ((jeon.equals("") && s.equals(gename)) || (apryn.equals("Y") && jeon.equals(""))) {
						list.add(cvo);
					}
				}
			}

			for (int i = 0; i < list_D.size(); i++) {
				GtApprovalLineVO dvo = null;
				dvo = list_D.get(i);
				String app = dvo.getApprover();
				int count = Integer.parseInt(dvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if ((jeon.equals("") && s.equals(gename)) || (apryn.equals("Y") && jeon.equals(""))) {
						list.add(dvo);
					}
				}
			}

			for (int i = 0; i < list_B.size(); i++) {
				GtApprovalLineVO bvo = null;
				bvo = list_B.get(i);
				String app = bvo.getApprover();
				int count = Integer.parseInt(bvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if ((jeon.equals("") && s.equals(gename)) || (apryn.equals("Y") && jeon.equals(""))) {
						list.add(bvo);
					}
				}
			}

			for (int i = 0; i < list_V.size(); i++) {
				GtApprovalLineVO vvo = null;
				vvo = list_V.get(i);
				String app = vvo.getApprover();
				int count = Integer.parseInt(vvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if ((jeon.equals("") && s.equals(gename)) || (apryn.equals("Y") && jeon.equals(""))) {
						list.add(vvo);
					}
				}
			}

			for (int i = 0; i < list_S.size(); i++) {
				GtApprovalLineVO svo = null;
				svo = list_S.get(i);
				String app = svo.getApprover();
				int count = Integer.parseInt(svo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if ((jeon.equals("") && s.equals(gename)) || (apryn.equals("Y") && jeon.equals(""))) {
						list.add(svo);
					}
				}
			}

			for (int i = 0; i < list_R.size(); i++) {
				GtApprovalLineVO rvo = null;
				rvo = list_R.get(i);
				String app = rvo.getApprover();
				int count = Integer.parseInt(rvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if ((jeon.equals("") && s.equals(gename)) || (apryn.equals("Y") && jeon.equals(""))) {
						list.add(rvo);
					}
				}
			}
			list.sort(Comparator.comparing(GtApprovalLineVO::getDate));
			list_Deci.sort(Comparator.comparing(GtApprovalLineVO::getDate));
			m.addAttribute("list_Deci", list_Deci);
			m.addAttribute("list", list);
		} else if (jeonyn.equals("2")) {
			for (int i = 0; i < list_C.size(); i++) {
				GtApprovalLineVO cvo = null;
				cvo = list_C.get(i);
				String app = cvo.getApprover();
				int count = Integer.parseInt(cvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (apryn.equals("Y") && jeon.equals("") && !s.equals(gename)) {
						list.add(cvo);
					}
				}
			}

			for (int i = 0; i < list_D.size(); i++) {
				GtApprovalLineVO dvo = null;
				dvo = list_D.get(i);
				String app = dvo.getApprover();
				int count = Integer.parseInt(dvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (apryn.equals("Y") && jeon.equals("") && !s.equals(gename)) {
						list.add(dvo);
					}
				}
			}

			for (int i = 0; i < list_B.size(); i++) {
				GtApprovalLineVO bvo = null;
				bvo = list_B.get(i);
				String app = bvo.getApprover();
				int count = Integer.parseInt(bvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (apryn.equals("Y") && jeon.equals("") && !s.equals(gename)) {
						list.add(bvo);
					}
				}
			}

			for (int i = 0; i < list_V.size(); i++) {
				GtApprovalLineVO vvo = null;
				vvo = list_V.get(i);
				String app = vvo.getApprover();
				int count = Integer.parseInt(vvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (apryn.equals("Y") && jeon.equals("") && !s.equals(gename)) {
						list.add(vvo);
					}
				}
			}

			for (int i = 0; i < list_S.size(); i++) {
				GtApprovalLineVO svo = null;
				svo = list_S.get(i);
				String app = svo.getApprover();
				int count = Integer.parseInt(svo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (apryn.equals("Y") && jeon.equals("") && !s.equals(gename)) {
						list.add(svo);
					}
				}
			}

			for (int i = 0; i < list_R.size(); i++) {
				GtApprovalLineVO rvo = null;
				rvo = list_R.get(i);
				String app = rvo.getApprover();
				int count = Integer.parseInt(rvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (apryn.equals("Y") && jeon.equals("") && !s.equals(gename)) {
						list.add(rvo);
					}
				}
			}
			list.sort(Comparator.comparing(GtApprovalLineVO::getDate));
			m.addAttribute("list", list);
		} else {
			for (int i = 0; i < list_C.size(); i++) {
				GtApprovalLineVO cvo = null;
				cvo = list_C.get(i);
				String app = cvo.getApprover();
				int count = Integer.parseInt(cvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (jeon.equals("") && s.equals(gename)) {
						list.add(cvo);
					}
				}
			}

			for (int i = 0; i < list_D.size(); i++) {
				GtApprovalLineVO dvo = null;
				dvo = list_D.get(i);
				String app = dvo.getApprover();
				int count = Integer.parseInt(dvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (jeon.equals("") && s.equals(gename)) {
						list.add(dvo);
					}
				}
			}

			for (int i = 0; i < list_B.size(); i++) {
				GtApprovalLineVO bvo = null;
				bvo = list_B.get(i);
				String app = bvo.getApprover();
				int count = Integer.parseInt(bvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (jeon.equals("") && s.equals(gename)) {
						list.add(bvo);
					}
				}
			}

			for (int i = 0; i < list_V.size(); i++) {
				GtApprovalLineVO vvo = null;
				vvo = list_V.get(i);
				String app = vvo.getApprover();
				int count = Integer.parseInt(vvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (jeon.equals("") && s.equals(gename)) {
						list.add(vvo);
					}
				}
			}

			for (int i = 0; i < list_S.size(); i++) {
				GtApprovalLineVO svo = null;
				svo = list_S.get(i);
				String app = svo.getApprover();
				int count = Integer.parseInt(svo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (jeon.equals("") && s.equals(gename)) {
						list.add(svo);
					}
				}
			}

			for (int i = 0; i < list_R.size(); i++) {
				GtApprovalLineVO rvo = null;
				rvo = list_R.get(i);
				String app = rvo.getApprover();
				int count = Integer.parseInt(rvo.getCount());
				if (count >= 0) {
					String jeon = CodeUtil.edsmjeoncheck(app, count);
					String s = CodeUtil.edsmcheck(app, count);
					if (jeon.equals("") && s.equals(gename)) {
						list.add(rvo);
					}
				}
			}
			list.sort(Comparator.comparing(GtApprovalLineVO::getDate));
			list_Deci.sort(Comparator.comparing(GtApprovalLineVO::getDate));
			m.addAttribute("list_Deci", list_Deci);
			m.addAttribute("list", list);
		}

		log.info("list.size() > : " + list.size());
		log.info("list_Deci.size() >>> : " + list_Deci.size());
		m.addAttribute("jeonyn", jeonyn);
		m.addAttribute("apryn", apryn);

		return "document/document_approve";
	}

	@GetMapping(value = "document_com")
	public String document_com(HttpServletRequest q, GtApprovalLineVO avo, Model m) {

		avo.setApp("com");
		log.info("document_com() >> : ");
		m.addAttribute("avo_", avo);
		if(avo.getS_appnum() == null) {
			avo.setS_appnum("");
		}
		if(avo.getSubject()==(null)) {
			avo.setSubject("");
		}
		if(avo.getS_writer()==(null)) {
			avo.setS_writer("");
		}
		if(avo.getFormname()==(null)) {
			avo.setFormname("");
		}
		if(avo.getAppstartdate()==(null)) {
			avo.setAppstartdate("");
		}
		if(avo.getAppenddate()==(null)) {
			avo.setAppenddate("");
		}
		List<GtApprovalLineVO> list = new ArrayList<GtApprovalLineVO>();
		List<GtApprovalLineVO> list_C = gtContractService.gtContractAppSelectAll(avo);
		List<GtApprovalLineVO> list_D = gtDraftService.draftAppSelectAll(avo);
		List<GtApprovalLineVO> list_B = gtBusinessService.gtBusinessAppSelectAll(avo);
		List<GtApprovalLineVO> list_V = gtVacationService.gtVacationAppSelectAll(avo);
		List<GtApprovalLineVO> list_S = gtSpendService.gtSpendAppSelectAll(avo);
		List<GtApprovalLineVO> list_R = gtResignationService.gtResignationAppSelectAll(avo);
		log.info("list_C.size() >>> : " + list_C.size());
		for (int i = 0; i < list_C.size(); i++) {
			GtApprovalLineVO cvo = null;
			cvo = list_C.get(i);
			String app = cvo.getApprover();
			String count = cvo.getCount();
			if (Integer.parseInt(count) > 0) {
				String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
				String ss = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if (!s.equals("") || ss.equals("OK")) {
					list.add(cvo);
				}
			}
		}
		log.info("list_D.size() >>> : " + list_D.size());
		for (int i = 0; i < list_D.size(); i++) {
			GtApprovalLineVO dvo = null;
			dvo = list_D.get(i);
			String app = dvo.getApprover();
			String count = dvo.getCount();
			if (Integer.parseInt(count) > 0) {
				String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
				String ss = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if (!s.equals("") || ss.equals("OK")) {
					list.add(dvo);
				}
			}
		}
		log.info("list_B.size() >>> : " + list_B.size());
		for (int i = 0; i < list_B.size(); i++) {
			GtApprovalLineVO bvo = null;
			bvo = list_B.get(i);
			String app = bvo.getApprover();
			String count = bvo.getCount();
			if (Integer.parseInt(count) > 0) {
				String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
				String ss = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if (!s.equals("") || ss.equals("OK")) {
					list.add(bvo);
				}
			}
		}
		log.info("list_V.size() >>> : " + list_V.size());
		for (int i = 0; i < list_V.size(); i++) {
			GtApprovalLineVO vvo = null;
			vvo = list_V.get(i);
			String app = vvo.getApprover();
			String count = vvo.getCount();
			if (Integer.parseInt(count) > 0) {
				String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
				String ss = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if (!s.equals("") || ss.equals("OK")) {
					list.add(vvo);
				}
			}
		}
		log.info("list_S.size() >>> : " + list_S.size());
		for (int i = 0; i < list_S.size(); i++) {
			GtApprovalLineVO svo = null;
			svo = list_S.get(i);
			String app = svo.getApprover();
			String count = svo.getCount();
			if (Integer.parseInt(count) > 0) {
				String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
				String ss = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if (!s.equals("") || ss.equals("OK")) {
					list.add(svo);
				}
			}
		}
		log.info("list_R.size() >>> : " + list_R.size());
		for (int i = 0; i < list_R.size(); i++) {
			GtApprovalLineVO rvo = null;
			rvo = list_R.get(i);
			String app = rvo.getApprover();
			String count = rvo.getCount();
			if (Integer.parseInt(count) > 0) {
				String s = CodeUtil.edsmjeoncheck(app, Integer.parseInt(count));
				String ss = CodeUtil.edsmcheck(app, Integer.parseInt(count));
				if (!s.equals("") || ss.equals("OK")) {
					list.add(rvo);
				}
			}
		}
		log.info("list.size() > : " + list.size());
		m.addAttribute("list", list);

		return "document/document_com";
	}

	@GetMapping(value = "document_napp")
	public String document_napp(HttpServletRequest q, GtApprovalLineVO avo, Model m) {

		avo.setApp("napp");
		log.info("document_approve() >> : ");
		K_Session ks = K_Session.getInstance();
		String genum = ks.getSession(q);
		log.info("genum >>> : " + genum);
		GtEmployeeVO evo = new GtEmployeeVO();
		evo.setGenum(genum);
		evo = gtEmployeeService.goatempidcheck(evo);
		String gename = evo.getGename();
		String apryn = evo.getApryn();
		log.info("apryn >> : " + apryn);
		log.info("gename >>> : " + gename);
		m.addAttribute("avo_", avo);
		avo.setGename(gename);
		if(avo.getS_appnum() == null) {
			avo.setS_appnum("");
		}
		if(avo.getSubject()==(null)) {
			avo.setSubject("");
		}
		if(avo.getS_writer()==(null)) {
			avo.setS_writer("");
		}
		if(avo.getFormname()==(null)) {
			avo.setFormname("");
		}
		if(avo.getAppstartdate()==(null)) {
			avo.setAppstartdate("");
		}
		if(avo.getAppenddate()==(null)) {
			avo.setAppenddate("");
		}
		List<GtApprovalLineVO> list = new ArrayList<GtApprovalLineVO>();
		List<GtApprovalLineVO> list_C = gtContractService.gtContractAppSelectAll(avo);
		List<GtApprovalLineVO> list_D = gtDraftService.draftAppSelectAll(avo);
		List<GtApprovalLineVO> list_B = gtBusinessService.gtBusinessAppSelectAll(avo);
		List<GtApprovalLineVO> list_V = gtVacationService.gtVacationAppSelectAll(avo);
		List<GtApprovalLineVO> list_S = gtSpendService.gtSpendAppSelectAll(avo);
		List<GtApprovalLineVO> list_R = gtResignationService.gtResignationAppSelectAll(avo);
		log.info("list_C.size() >>> : " + list_C.size());
		for (int i = 0; i < list_C.size(); i++) {
			GtApprovalLineVO cvo = null;
			cvo = list_C.get(i);
			list.add(cvo);
		}
		log.info("list_D.size() >>> : " + list_D.size());
		for (int i = 0; i < list_D.size(); i++) {
			GtApprovalLineVO dvo = null;
			dvo = list_D.get(i);
			list.add(dvo);
		}
		log.info("list_B.size() >>> : " + list_B.size());
		for (int i = 0; i < list_B.size(); i++) {
			GtApprovalLineVO bvo = null;
			bvo = list_B.get(i);
			list.add(bvo);
		}
		log.info("list_V.size() >>> : " + list_V.size());
		for (int i = 0; i < list_V.size(); i++) {
			GtApprovalLineVO vvo = null;
			vvo = list_V.get(i);
			list.add(vvo);
		}
		log.info("list_S.size() >>> : " + list_S.size());
		for (int i = 0; i < list_S.size(); i++) {
			GtApprovalLineVO svo = null;
			svo = list_S.get(i);
			list.add(svo);
		}
		log.info("list_R.size() >>> : " + list_R.size());
		for (int i = 0; i < list_R.size(); i++) {
			GtApprovalLineVO rvo = null;
			rvo = list_R.get(i);
			list.add(rvo);
		}
		log.info("list.size() > : " + list.size());
		m.addAttribute("list", list);

		return "document/document_napp";
	}

	@GetMapping(value = "document_prog")
	public String document_prog(HttpServletRequest q, GtApprovalLineVO avo, Model m) {
		avo.setApp("prog");
		log.info("document_approve() >> : ");
		K_Session ks = K_Session.getInstance();
		String genum = ks.getSession(q);
		log.info("genum >>> : " + genum);
		GtEmployeeVO evo = new GtEmployeeVO();
		m.addAttribute("avo_", avo);
		evo.setGenum(genum);
		evo = gtEmployeeService.goatempidcheck(evo);
		String gename = evo.getGename();
		String apryn = evo.getApryn();
		log.info("apryn >> : " + apryn);
		log.info("gename >>> : " + gename);
		avo.setGename(gename);
		if(avo.getS_appnum() == null) {
			avo.setS_appnum("");
		}
		if(avo.getSubject()==(null)) {
			avo.setSubject("");
		}
		if(avo.getS_writer()==(null)) {
			avo.setS_writer("");
		}
		if(avo.getFormname()==(null)) {
			avo.setFormname("");
		}
		if(avo.getAppstartdate()==(null)) {
			avo.setAppstartdate("");
		}
		if(avo.getAppenddate()==(null)) {
			avo.setAppenddate("");
		}
		List<GtApprovalLineVO> list = new ArrayList<GtApprovalLineVO>();
		List<GtApprovalLineVO> list_C = gtContractService.gtContractAppSelectAll(avo);
		List<GtApprovalLineVO> list_D = gtDraftService.draftAppSelectAll(avo);
		List<GtApprovalLineVO> list_B = gtBusinessService.gtBusinessAppSelectAll(avo);
		List<GtApprovalLineVO> list_V = gtVacationService.gtVacationAppSelectAll(avo);
		List<GtApprovalLineVO> list_S = gtSpendService.gtSpendAppSelectAll(avo);
		List<GtApprovalLineVO> list_R = gtResignationService.gtResignationAppSelectAll(avo);
		log.info("list_C.size() >>> : " + list_C.size());
		for (int i = 0; i < list_C.size(); i++) {
			GtApprovalLineVO cvo = null;
			cvo = list_C.get(i);
			log.info("cvo.getAppnum() >>> : " + cvo.getAppnum());
			String app = cvo.getApprover();
			int count = Integer.parseInt(cvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK"))) {
					list.add(cvo);
				}
			}
		}
		log.info("list_D.size() >>> : " + list_D.size());
		for (int i = 0; i < list_D.size(); i++) {
			GtApprovalLineVO dvo = null;
			dvo = list_D.get(i);
			log.info("dvo.getAppnum() >>> : " + dvo.getAppnum());
			String app = dvo.getApprover();
			int count = Integer.parseInt(dvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK"))) {
					list.add(dvo);
				}
			}
		}
		log.info("list_B.size() >>> : " + list_B.size());
		for (int i = 0; i < list_B.size(); i++) {
			GtApprovalLineVO bvo = null;
			bvo = list_B.get(i);
			log.info("bvo.getAppnum() >>> : " + bvo.getAppnum());
			String app = bvo.getApprover();
			int count = Integer.parseInt(bvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK"))) {
					list.add(bvo);
				}
			}
		}
		log.info("list_V.size() >>> : " + list_V.size());
		for (int i = 0; i < list_V.size(); i++) {
			GtApprovalLineVO vvo = null;
			vvo = list_V.get(i);
			log.info("vvo.getAppnum() >>> : " + vvo.getAppnum());
			String app = vvo.getApprover();
			int count = Integer.parseInt(vvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK"))) {
					list.add(vvo);
				}
			}
		}
		log.info("list_S.size() >>> : " + list_S.size());
		for (int i = 0; i < list_S.size(); i++) {
			GtApprovalLineVO svo = null;
			svo = list_S.get(i);
			log.info("svo.getAppnum() >>> : " + svo.getAppnum());
			String app = svo.getApprover();
			int count = Integer.parseInt(svo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK"))) {
					list.add(svo);
				}
			}
		}
		log.info("list_R.size() >>> : " + list_R.size());
		for (int i = 0; i < list_R.size(); i++) {
			GtApprovalLineVO rvo = null;
			rvo = list_R.get(i);
			log.info("rvo.getAppnum() >>> : " + rvo.getAppnum());
			String app = rvo.getApprover();
			int count = Integer.parseInt(rvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK"))) {
					list.add(rvo);
				}
			}
		}
		for (int i = 0; i < list.size(); i++) {
			log.info("get >>> : " + list.get(i).getAppnum());
		}
		log.info("list.size() > : " + list.size());
		m.addAttribute("list", list);

		return "document/document_prog";
	}

	@GetMapping(value = "document_ref")
	public String document_ref(HttpServletRequest q, GtApprovalLineVO avo, Model m) {

		avo.setApp("ref");
		log.info("document_approve() >> : ");
		K_Session ks = K_Session.getInstance();
		String genum = ks.getSession(q);
		log.info("genum >>> : " + genum);
		m.addAttribute("avo_", avo);
		GtEmployeeVO evo = new GtEmployeeVO();
		evo.setGenum(genum);
		evo = gtEmployeeService.goatempidcheck(evo);
		String gename = evo.getGename();
		String apryn = evo.getApryn();
		log.info("apryn >> : " + apryn);
		log.info("gename >>> : " + gename);
		avo.setGename(gename);
		if(avo.getS_appnum() == null) {
			avo.setS_appnum("");
		}
		if(avo.getSubject()==(null)) {
			avo.setSubject("");
		}
		if(avo.getS_writer()==(null)) {
			avo.setS_writer("");
		}
		if(avo.getFormname()==(null)) {
			avo.setFormname("");
		}
		if(avo.getAppstartdate()==(null)) {
			avo.setAppstartdate("");
		}
		if(avo.getAppenddate()==(null)) {
			avo.setAppenddate("");
		}
		List<GtApprovalLineVO> list = new ArrayList<GtApprovalLineVO>();
		List<GtApprovalLineVO> list_C = gtContractService.gtContractAppSelectAll(avo);
		List<GtApprovalLineVO> list_D = gtDraftService.draftAppSelectAll(avo);
		List<GtApprovalLineVO> list_B = gtBusinessService.gtBusinessAppSelectAll(avo);
		List<GtApprovalLineVO> list_V = gtVacationService.gtVacationAppSelectAll(avo);
		List<GtApprovalLineVO> list_S = gtSpendService.gtSpendAppSelectAll(avo);
		List<GtApprovalLineVO> list_R = gtResignationService.gtResignationAppSelectAll(avo);
		log.info("list_C.size() >>> : " + list_C.size());
		for (int i = 0; i < list_C.size(); i++) {
			GtApprovalLineVO cvo = null;
			cvo = list_C.get(i);
			log.info("cvo.getAppnum() >>> : " + cvo.getAppnum());
			String app = cvo.getApprover();
			int count = Integer.parseInt(cvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK")) && count >= 0) {
					list.add(cvo);
				}
			}
		}
		log.info("list_D.size() >>> : " + list_D.size());
		for (int i = 0; i < list_D.size(); i++) {
			GtApprovalLineVO dvo = null;
			dvo = list_D.get(i);
			log.info("dvo.getAppnum() >>> : " + dvo.getAppnum());
			String app = dvo.getApprover();
			int count = Integer.parseInt(dvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK")) && count >= 0) {
					list.add(dvo);
				}
			}
		}
		log.info("list_B.size() >>> : " + list_B.size());
		for (int i = 0; i < list_B.size(); i++) {
			GtApprovalLineVO bvo = null;
			bvo = list_B.get(i);
			log.info("bvo.getAppnum() >>> : " + bvo.getAppnum());
			String app = bvo.getApprover();
			int count = Integer.parseInt(bvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK")) && count >= 0) {
					list.add(bvo);
				}
			}
		}
		log.info("list_V.size() >>> : " + list_V.size());
		for (int i = 0; i < list_V.size(); i++) {
			GtApprovalLineVO vvo = null;
			vvo = list_V.get(i);
			log.info("vvo.getAppnum() >>> : " + vvo.getAppnum());
			String app = vvo.getApprover();
			int count = Integer.parseInt(vvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK")) && count >= 0) {
					list.add(vvo);
				}
			}
		}
		log.info("list_S.size() >>> : " + list_S.size());
		for (int i = 0; i < list_S.size(); i++) {
			GtApprovalLineVO svo = null;
			svo = list_S.get(i);
			log.info("svo.getAppnum() >>> : " + svo.getAppnum());
			String app = svo.getApprover();
			int count = Integer.parseInt(svo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK")) && count >= 0) {
					list.add(svo);
				}
			}
		}
		log.info("list_R.size() >>> : " + list_R.size());
		for (int i = 0; i < list_R.size(); i++) {
			GtApprovalLineVO rvo = null;
			rvo = list_R.get(i);
			log.info("rvo.getAppnum() >>> : " + rvo.getAppnum());
			String app = rvo.getApprover();
			int count = Integer.parseInt(rvo.getCount());
			if (count >= 0) {
				String jeon = CodeUtil.edsmjeoncheck(app, count);
				String s = CodeUtil.edsmcheck(app, count);
				if (jeon.equals("") && (!s.equals("OK")) && count >= 0) {
					list.add(rvo);
				}
			}
		}
		for (int i = 0; i < list.size(); i++) {
			log.info("get >>> :@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + list.get(i).getAppnum());
		}
		list.sort(Comparator.comparing(GtApprovalLineVO::getDate));
		log.info("list.size() > : " + list.size());
		m.addAttribute("list", list);

		return "document/document_ref";
	}

}
