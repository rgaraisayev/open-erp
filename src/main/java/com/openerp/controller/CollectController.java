package com.openerp.controller;

import com.openerp.entity.*;
import com.openerp.util.Constants;
import com.openerp.util.DateUtility;
import com.openerp.util.Util;
import net.emaze.dysfunctional.Groups;
import net.emaze.dysfunctional.dispatching.delegates.Pluck;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/collect")
public class CollectController extends SkeletonController {

    @GetMapping(value = {"/{page}", "/{page}/{data}"})
    public String route(Model model, @PathVariable("page") String page, @PathVariable("data") Optional<String> data, RedirectAttributes redirectAttributes) throws Exception {
        session.setAttribute(Constants.PAGE, page);
        String description = "";
        List<Module> moduleList = (List<Module>) session.getAttribute(Constants.MODULES);
        for(Module m: moduleList){
            if(m.getPath().equalsIgnoreCase(page)){
                description = m.getDescription();
                break;
            }
        }
        session.setAttribute(Constants.MODULE_DESCRIPTION, description);

        if(page.equalsIgnoreCase(Constants.ROUTE.PAYMENT_REGULATOR)){
            List<Schedule> schedules = scheduleRepository.getSchedules(new Date());
            model.addAttribute(Constants.LIST, Util.convertPaymentSchedule(schedules));
            if(!model.containsAttribute(Constants.FORM)){
                model.addAttribute(Constants.FORM, new Schedule());
            }
        } else if(page.equalsIgnoreCase(Constants.ROUTE.PAYMENT_REGULATOR_DETAIL)){
            model.addAttribute(Constants.LIST, scheduleRepository.getScheduleDetails(new Date(), Integer.parseInt(data.get())));
        } if(page.equalsIgnoreCase(Constants.ROUTE.PAYMENT_REGULATOR_NOTE)){
            List<PaymentRegulatorNote> paymentRegulatorNotes = new ArrayList<>();
            int paymentId = 0;
            if(data.equals(Optional.empty())){
                paymentRegulatorNotes = paymentRegulatorNoteRepository.getPaymentRegulatorNotesByActiveTrue();
            } else {
                paymentRegulatorNotes = paymentRegulatorNoteRepository.getPaymentRegulatorNotesByActiveTrueAndPayment_Id(Integer.parseInt(data.get()));
                paymentId = Integer.parseInt(data.get());
            }
            model.addAttribute(Constants.LIST, paymentRegulatorNotes);
            model.addAttribute(Constants.PAYMENT_ID, paymentId);
            model.addAttribute(Constants.CONTACT_CHANNELS, dictionaryRepository.getDictionariesByActiveTrueAndDictionaryType_Attr1("contact-channel"));
            if(!model.containsAttribute(Constants.FORM)){
                model.addAttribute(Constants.FORM, new PaymentRegulatorNote());
            }
        }
        return "layout";
    }

    @PostMapping(value = "/payment-regulator-note")
    public String postShortenedWorkingDay(@ModelAttribute(Constants.FORM) @Validated PaymentRegulatorNote paymentRegulatorNote, BindingResult binding, RedirectAttributes redirectAttributes) throws Exception {
        redirectAttributes.addFlashAttribute(Constants.STATUS.RESPONSE, Util.response(binding,Constants.TEXT.SUCCESS));
        if(!binding.hasErrors()){
            paymentRegulatorNoteRepository.save(paymentRegulatorNote);
        }
        return mapPost(paymentRegulatorNote, binding, redirectAttributes);
    }
}